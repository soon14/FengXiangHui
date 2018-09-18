//
//  GoodsDetailViewController.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailResultModel.h"
#import "GoodsDetailBottomView.h"//底部 View
#import "GoodsDetailNavigationView.h"//自定义的导航栏
#import "GoodsDetailPopupView.h"//点击加入购物车弹出的 View
#import "GoodsDetailGoodsInfoCell.h"//商品图片、价格、大小标题等 cell
#import "GoodsDetailMemberLevelCell.h"//店主可享受优惠价格 cell
#import "GoodsDetailJDAdressCell.h"//京东商品可选择地址 cell
#import "GoodsDetailFreightCell.h"//运费 cell
#import "GoodsDetailQuelityCell.h"//质量保证等信息 cell
#import "GoodsDetailCountCell.h"//数量、规格等信息
#import "GoodsDetailShopCell.h"//店铺信息
#import "GoodsDetailDragCell.h"//上拉查看详情
#import "GoodsDetailContentImageCell.h"//详情页展示图片 cell

/** 七陌客服 */
#import "QMChatRoomViewController.h"
#import <QMChatSDK/QMChatSDK.h>
#import <QMChatSDK/QMChatSDK-Swift.h>
#import "QMChatRoomGuestBookViewController.h"
#import "QMAlert.h"
#import "QMManager.h"

#define ServiceAppKey @"23327890-e082-11e7-82ef-59ca8660f8ce"

#define BottomViewHeight (KBottomHeight+45)                                         //底部 View 的高度
#define TableViewOriginHeight (KMAINSIZE.height-KNaviHeight-BottomViewHeight)       // tableView 原始高度

typedef NS_ENUM(NSInteger , GoodsDetailCellType) {
    GoodsInfoType = 0,      //轮播图、价格、销量等
    MemberLevelType,        //店主可享受优惠价格
    JDGoodsAdressType,      //京东商品可选择地址查看运费
    FreightType,            //运费
    QualityType,            //质量保证
    CountType,              //数量规格
    ShopType,               //店铺信息
    DragType                //上拉查看详情
};

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,GoodsDetailBottomViewDelegate,GoodsDetailBottomViewDelegate,GoodsDetailGoodsInfoCellDelegate,GoodsDetailShopCellDelegate>
{
    NSMutableArray *contentImageHeightArray;        //存放详情页图片高度的数组
}
/** 导航栏 */
@property(nonatomic , strong)GoodsDetailNavigationView *navigationView;
/** bottomView */
@property(nonatomic , strong)GoodsDetailBottomView *bottomView;
/** 第一个 tableView */
@property(nonatomic , strong)UITableView *firstTableView;
/** 第二个显示商品详情的 tableView */
@property(nonatomic , strong)UITableView *secondTableView;
/** 客服按钮 */
@property(nonatomic , strong)UIButton *serviceButton;
/** 商品二维码图片 */
@property(nonatomic , strong)UIImageView *goodsQRCode;
/** 商品详情 Model */
@property(nonatomic , strong)GoodsDetailResultModel *resultModel;
/**  第一个 tableView 内容高度 */
@property(nonatomic , assign)CGFloat firstTableContentHeight;

/** 客服 */
@property(nonatomic , assign) BOOL isPushed;
@property(nonatomic , assign) BOOL isConnecting;
@property(nonatomic , strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic , copy) NSDictionary * dictionary;

@end

@implementation GoodsDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    contentImageHeightArray = [NSMutableArray array];
    _firstTableContentHeight = TableViewOriginHeight;
    
    [self goodsDetailDataRequest];
    
    //客服相关
    self.isConnecting = NO;
    self.isPushed = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess:) name:CUSTOM_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerFailure:) name:CUSTOM_LOGIN_ERROR_USER object:nil];
}

#pragma mark - 添加子视图
- (void)initSubviews {
    [self.view addSubview:self.firstTableView];
    [self.view addSubview:self.secondTableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.serviceButton];
    [self caculateContentImageHeight];
}

#pragma mark - 计算详情页每张图片高度并放入数组
- (void)caculateContentImageHeight {
    //创建一个分线程
    MJWeakSelf
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i=0; i<weakSelf.resultModel.content.count; i++) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",weakSelf.resultModel.content[i]]]];
            UIImage *image = [UIImage imageWithData:data];
            [contentImageHeightArray addObject:[NSString stringWithFormat:@"%f",KMAINSIZE.width/image.size.width*image.size.height]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.secondTableView reloadData];
        });
    });
}

#pragma mark - 导航栏
- (GoodsDetailNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[GoodsDetailNavigationView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KNaviHeight)];
        _navigationView.delegate = self;
    }
    return _navigationView;
}

#pragma mark - 底部操作栏
- (GoodsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[GoodsDetailBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-BottomViewHeight, KMAINSIZE.width, BottomViewHeight)];
        _bottomView.delegate = self;
        _bottomView.isFavorite = self.resultModel.isFavorite;
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)firstTableView {
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNaviHeight, KMAINSIZE.width, TableViewOriginHeight) style:UITableViewStylePlain];
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _firstTableView.backgroundColor = KTableBackgroundColor;
        _firstTableView.showsVerticalScrollIndicator = NO;
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.estimatedRowHeight = 0;
        _firstTableView.estimatedSectionHeaderHeight = 0;
        _firstTableView.estimatedSectionFooterHeight = 0;
        [_firstTableView registerClass:[GoodsDetailGoodsInfoCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailGoodsInfoCell class])];
        [_firstTableView registerClass:[GoodsDetailMemberLevelCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailMemberLevelCell class])];
        [_firstTableView registerClass:[GoodsDetailJDAdressCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailJDAdressCell class])];
        [_firstTableView registerClass:[GoodsDetailFreightCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailFreightCell class])];
        [_firstTableView registerClass:[GoodsDetailQuelityCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailQuelityCell class])];
        [_firstTableView registerClass:[GoodsDetailCountCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailCountCell class])];
        [_firstTableView registerClass:[GoodsDetailShopCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailShopCell class])];
        [_firstTableView registerClass:[GoodsDetailDragCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailDragCell class])];
        [_firstTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _firstTableView;
}

- (UITableView *)secondTableView {
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self getFirstTableViewHeight]+KNaviHeight, KMAINSIZE.width, TableViewOriginHeight) style:UITableViewStylePlain];
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _secondTableView.backgroundColor = KTableBackgroundColor;
        _secondTableView.showsVerticalScrollIndicator = NO;
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        _secondTableView.estimatedRowHeight = 0;
        _secondTableView.estimatedSectionHeaderHeight = 0;
        _secondTableView.estimatedSectionFooterHeight = 0;
        [_secondTableView registerClass:[GoodsDetailContentImageCell class] forCellReuseIdentifier:NSStringFromClass([GoodsDetailContentImageCell class])];
        [_secondTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _secondTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.firstTableView) {
        return 8;
    } return contentImageHeightArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.secondTableView) {
        if (contentImageHeightArray) {
            return [contentImageHeightArray[indexPath.section] floatValue];
        } return CGFLOAT_MIN;
    } else {
        switch (indexPath.section) {
            case GoodsInfoType: {
                return (360*KScreenRatio + 125);
            } break;
            case MemberLevelType: {
                if (self.resultModel.member_level) {
                    return 35;
                } return CGFLOAT_MIN;
            } break;
            case JDGoodsAdressType: {
                if (self.resultModel.jdgoods) {
                    return 40;
                } return CGFLOAT_MIN;
            } break;
            case FreightType: {
                return 40;
            } break;
            case QualityType: {
                if (self.resultModel.sku_jdid) {//京东商品
                    return 25;
                } else {
                    if ([self.resultModel.tag.quality count] < 1) {
                        return CGFLOAT_MIN;
                    } else if ([self.resultModel.tag.quality count] > 0 && [self.resultModel.tag.quality count] < 4) {
                        return 25;
                    } else {
                        return 50;
                    }
                }
            } break;
            case CountType: {
                return 40;
            } break;
            case ShopType: {
                return 60;
            } break;
            case DragType: {
                return 20;
            } break;
            default: return CGFLOAT_MIN; break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.firstTableView) {
        switch (section) {
            case MemberLevelType: {
                if (self.resultModel.member_level) {
                    return 8;
                } return CGFLOAT_MIN;
            } break;
            case JDGoodsAdressType:
            case FreightType: {
                return CGFLOAT_MIN;
            } break;
                
            default: {
                return 8;
            } break;
        }
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.secondTableView) {
        GoodsDetailContentImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailContentImageCell class])];
        return imageCell;
    } else if (tableView == self.firstTableView) {
        switch (indexPath.section) {
            case GoodsInfoType: {
                GoodsDetailGoodsInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailGoodsInfoCell class])];
                return infoCell;
            } break;
            case MemberLevelType: {
                if (self.resultModel.member_level) {
                    GoodsDetailMemberLevelCell *memberLevelCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailMemberLevelCell class])];
                    return memberLevelCell;
                }
            } break;
            case JDGoodsAdressType: {
                if (self.resultModel.jdgoods) {
                    GoodsDetailJDAdressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailJDAdressCell class])];
                    return addressCell;
                }
            } break;
            case FreightType: {
                GoodsDetailFreightCell *freightCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailFreightCell class])];
                return freightCell;
            } break;
            case QualityType: {
                if (self.resultModel.sku_jdid || [self.resultModel.tag.quality count] > 0) {
                    GoodsDetailQuelityCell *qualityCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailQuelityCell class])];
                    return qualityCell;
                }
            } break;
            case CountType: {
                GoodsDetailCountCell *countCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailCountCell class])];
                return countCell;
            } break;
            case ShopType: {
                GoodsDetailShopCell *shopCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailShopCell class])];
                return shopCell;
            } break;
            case DragType: {
                GoodsDetailDragCell *dragCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsDetailDragCell class])];
                return dragCell;
            } break;
            default:
                break;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.firstTableView) {
        switch (indexPath.section) {
            case GoodsInfoType: {
                GoodsDetailGoodsInfoCell *infoCell = (GoodsDetailGoodsInfoCell *)cell;
                infoCell.goodsDetailResultModel = self.resultModel;
                infoCell.delegate = self;
            } break;
            case MemberLevelType: {
                if (self.resultModel.member_level) {
                    GoodsDetailMemberLevelCell *memberLevelCell = (GoodsDetailMemberLevelCell *)cell;
                    memberLevelCell.memberLevelModel = self.resultModel.member_level;
                }
            } break;
            case JDGoodsAdressType: {
                if (self.resultModel.jdgoods) {
                    GoodsDetailJDAdressCell *addressCell = (GoodsDetailJDAdressCell *)cell;
                    addressCell.jdGoodsModel = self.resultModel.jdgoods;
                }
            } break;
            case FreightType: {
                GoodsDetailFreightCell *freightCell = (GoodsDetailFreightCell *)cell;
                freightCell.freight = self.resultModel.dispatchprice;
            } break;
            case QualityType: {
                GoodsDetailQuelityCell *qualityCell = (GoodsDetailQuelityCell *)cell;
                if (self.resultModel.sku_jdid) {
                    qualityCell.qualityArray = @[@"7天退换",@"京东配送",@"京东168包邮"];
                } else if ([self.resultModel.tag.quality count] > 0) {
                    qualityCell.qualityArray = self.resultModel.tag.quality;
                }
            } break;
            case CountType: {
                //GoodsDetailCountCell *countCell = (GoodsDetailCountCell *)cell;
                
            } break;
            case ShopType: {
                GoodsDetailShopCell *shopCell = (GoodsDetailShopCell *)cell;
                shopCell.shopDetailModel = self.resultModel.shopdetail;
                shopCell.delegate = self;
            } break;
                
            default:
                break;
        }
    } else if (tableView == self.secondTableView) {
        GoodsDetailContentImageCell *imageCell = (GoodsDetailContentImageCell *)cell;
        imageCell.urlString = self.resultModel.content[indexPath.section];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.firstTableView) {
        switch (indexPath.section) {
            case CountType: {
                NSLog(@"选择数量规格等。。。。");
            } break;
                
            default:
                break;
        }
    }
}

#pragma mark - 取到 firstTableView 的 contentSize
- (CGFloat )getFirstTableViewHeight {
    [self.firstTableView layoutIfNeeded];
    if (self.firstTableView.contentSize.height <= TableViewOriginHeight) {
        _firstTableContentHeight = TableViewOriginHeight;
    } else {
        _firstTableContentHeight = self.firstTableView.contentSize.height;
    }
    return _firstTableContentHeight;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView == self.firstTableView) {
        CGFloat valueNum = _firstTableContentHeight - TableViewOriginHeight;
        if ((offsetY - valueNum) > 50) {
            [self gotoDetailAnimation];//进入图文详情的动画
        }
    } else if (scrollView == self.secondTableView) {
        if (offsetY < -50) {
            [self backToFirstTableViewAnimation];
        }
    }
}

#pragma mark - 进入图文详情
- (void)gotoDetailAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        _navigationView.moveLine.frame = CGRectMake((KMAINSIZE.width/2)+30, KNaviHeight-4, 25, 4);
        [_navigationView.goodsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_navigationView.goodsButton.titleLabel setFont:KFont(15)];
        [_navigationView.detailsButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_navigationView.detailsButton.titleLabel setFont:KFont(16)];
        _firstTableView.frame = CGRectMake(0, -TableViewOriginHeight, KMAINSIZE.width, TableViewOriginHeight);
        _secondTableView.frame = CGRectMake(0, KNaviHeight, KMAINSIZE.width, TableViewOriginHeight);
    } completion:nil];
}

#pragma mark - 返回宝贝
- (void)backToFirstTableViewAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        _navigationView.moveLine.frame = CGRectMake((KMAINSIZE.width/2)-55, KNaviHeight-4, 25, 4);
        [_navigationView.goodsButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_navigationView.goodsButton.titleLabel setFont:KFont(16)];
        [_navigationView.detailsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_navigationView.detailsButton.titleLabel setFont:KFont(15)];
        _firstTableView.frame = CGRectMake(0, KNaviHeight, KMAINSIZE.width, TableViewOriginHeight);
        _secondTableView.frame = CGRectMake(0, _firstTableContentHeight+KNaviHeight, KMAINSIZE.width, TableViewOriginHeight);
    } completion:nil];
}

#pragma mark - 自定义导航栏点击事件
- (void)GoodsDetailNavigationView:(GoodsDetailNavigationView *)navigationView buttonAction:(NSInteger)index {
    switch (index) {
        case 0: {//返回
            [self.navigationController popViewControllerAnimated:YES];
        } break;
        case 1: {//弹出二维码
            [self scanCodeButtonAction:nil];
        } break;
        case 2: {//商品
            [self backToFirstTableViewAnimation];
        } break;
        case 3: {//详情
            [self gotoDetailAnimation];
        } break;
        default:
            break;
    }
}

#pragma mark - 底部按钮点击事件
- (void)GoodsDetailBottomView:(GoodsDetailBottomView *)bottomView buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {//收藏
            if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                if (sender.selected) {
                    [self removeCollectGoodsRequest:sender];//移除收藏
                } else {
                    [self addCollectGoodsRequest:sender];//添加收藏
                }
            } else {
                [DBHUD ShowInView:self.view withTitle:@"请先前往个人中心登录或注册"];
            }
        } break;
        case 1: {//跳转店铺
            NSLog(@"跳转店铺");
        } break;
        case 2: {//跳转购物车
            [self.tabBarController setSelectedIndex:3];
        } break;
        case 3: {//加入购物车
            GoodsDetailPopupView *addCartView = [[GoodsDetailPopupView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
            addCartView.popupType = 0;
            [addCartView showInView:self.view];
        } break;
        case 4: {//立即购买
            GoodsDetailPopupView *addCartView = [[GoodsDetailPopupView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
            addCartView.popupType = 1;
            [addCartView showInView:self.view];
        } break;
        default:
            break;
    }
}

#pragma mark - 分享商品
- (void)GoodsDetailGoodsInfoCell:(GoodsDetailGoodsInfoCell *)cell shareAction:(UIButton *)sender {
    [ShareManager shareWithTitle:self.resultModel.title andMessage:self.resultModel.subtitle andUrl:self.resultModel.share_url andImg:@[self.resultModel.thumb]];
}

#pragma mark - 进入店铺
- (void)GoodsDetailShopCell:(GoodsDetailShopCell *)cell buttonAction:(UIButton *)sender {
    NSLog(@"进入店铺");
}

#pragma mark - 返回按钮点击事件
- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 二维码扫描
- (void)scanCodeButtonAction:(UIButton *)sender {
    NSLog(@"弹出二维码");
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIView *backView = [[UIView alloc] initWithFrame:window.bounds];
//    [backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
//    [window addSubview:backView];
//    
//    [backView addSubview:self.goodsQRCode];
//    [self.goodsQRCode mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(window.mas_centerY);
//        make.centerX.mas_equalTo(window.mas_centerX);
//        make.width.mas_equalTo(300);
//        make.width.mas_equalTo(400);
//    }];
//    
//    [self.goodsQRCode yy_setImageWithURL:[NSURL URLWithString:self.resultModel.share_image] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        
//    }];
}



#pragma mark -  移除收藏网络请求
- (void)removeCollectGoodsRequest:(UIButton *)sender {
    NSString *url = @"r=apply.favorite.remove";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              self.goodsID,@"goodsid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            NSLog(@"操作成功了啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊");
            self.bottomView.isFavorite = !sender.selected;
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark -  添加收藏网络请求
- (void)addCollectGoodsRequest:(UIButton *)sender {
    NSString *url = @"r=apply.favorite.toggle";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
             [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                                                                self.goodsID,@"id",
                                                   sender.selected ? @0 : @1,@"isfavorite",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            self.bottomView.isFavorite = !sender.selected;
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 商品详情数据请求
- (void)goodsDetailDataRequest {
    NSString * urlString = @"r=apply.goods.detail";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.goodsID?self.goodsID:@"",@"id",
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
//    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:self.goodsID?self.goodsID:@"",@"id", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [GoodsDetailResultModel yy_modelWithDictionary:responseDic[@"result"]];
            NSLog(@"商品详情：%@",responseDic);
            [self initSubviews];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}



- (UIImageView *)goodsQRCode {
    if (!_goodsQRCode) {
        _goodsQRCode = [[UIImageView alloc] init];
    }
    return _goodsQRCode;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.isPushed = YES;
}

- (UIButton *)serviceButton {
    if (!_serviceButton) {
        _serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceButton setFrame:CGRectMake(KMAINSIZE.width-40, KMAINSIZE.height-BottomViewHeight-80, 30, 30)];
        [_serviceButton setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
        [_serviceButton addTarget:self action:@selector(serviceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceButton;
}

#pragma mark------点击客服按钮
- (void)serviceButtonAction {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
        [self.indicatorView startAnimating];
        // 按钮连点控制
        if (self.isConnecting) {
            return;
        }
        self.isConnecting = YES;
        /**
         accessId:  接入客服系统的密钥， 登录web客服系统（渠道设置->移动APP客服里获取）
         userName:  用户名， 区分用户， 用户名可直接在后台会话列表显示
         userId:    用户ID， 区分用户（只能使用  数字 字母(包括大小写) 下划线）
         以上3个都是必填项
         */
        [QMConnect registerSDKWithAppKey:ServiceAppKey userName:[[NSUserDefaults standardUserDefaults] objectForKey:KUserMobile] userId:[[NSUserDefaults standardUserDefaults] objectForKey:KUserId]];
    } else {
        [self presentLoginViewController];
    }
}

#pragma mark----客服注册成功
- (void)registerSuccess:(NSNotification *)sender {
    NSLog(@"注册成功");
    if ([QMManager defaultManager].selectedPush) {
        [self showChatRoomViewController:@"" processType:@"" entranceId:@""]; //
    } else {
        // 页面跳转控制
        if (self.isPushed) {
            return;
        }
        [QMConnect sdkGetWebchatScheduleConfig:^(NSDictionary * _Nonnull scheduleDic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dictionary = scheduleDic;
                if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
                    NSLog(@"日程管理");
                    [self starSchedule];
                } else {
                    NSLog(@"技能组");
                    [self getPeers];
                }
            });
        } failBlock:^{
            
        }];
    }
    [QMManager defaultManager].selectedPush = NO;
}
#pragma mark----客服注册失败
- (void)registerFailure:(NSNotification *)sender {
    NSLog(@"注册失败::%@", sender.object);
    self.isConnecting = NO;
    [self.indicatorView stopAnimating];
}

#pragma mark - 技能组选择
- (void)getPeers {
    [QMConnect sdkGetPeers:^(NSArray * _Nonnull peerArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *peers = peerArray;
            self.isConnecting = NO;
            [_indicatorView stopAnimating];
            if (peers.count == 1 && peers.count != 0) {
                [self showChatRoomViewController:[peers.firstObject objectForKey:@"id"] processType:@"" entranceId:@""];
            }else {
                [self showPeersWithAlert:peers messageStr:NSLocalizedString(@"title.type", nil)];
            }
        });
    } failureBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.isConnecting = NO;
        });
    }];
}

#pragma mark - 日程管理
- (void)starSchedule {
    self.isConnecting = NO;
    [_indicatorView stopAnimating];
    if ([self.dictionary[@"scheduleId"]  isEqual: @""] || [self.dictionary[@"processId"]  isEqual: @""] || [self.dictionary objectForKey:@"entranceNode"] == nil || [self.dictionary objectForKey:@"leavemsgNodes"] == nil) {
        [QMAlert showMessage:NSLocalizedString(@"title.sorryconfigurationiswrong", nil)];
    }else{
        NSDictionary *entranceNode = self.dictionary[@"entranceNode"];
        NSArray *entrances = entranceNode[@"entrances"];
        if (entrances.count == 1 && entrances.count != 0) {
            [self showChatRoomViewController:[entrances.firstObject objectForKey:@"processTo"] processType:[entrances.firstObject objectForKey:@"processType"] entranceId:[entrances.firstObject objectForKey:@"_id"]];
        }else{
            [self showPeersWithAlert:entrances messageStr:NSLocalizedString(@"title.schedule_type", nil)];
        }
    }
}

- (void)showPeersWithAlert: (NSArray *)peers messageStr: (NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"title.type", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.isConnecting = NO;
    }];
    [alertController addAction:cancelAction];
    for (NSDictionary *index in peers) {
        UIAlertAction *surelAction = [UIAlertAction actionWithTitle:[index objectForKey:@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.dictionary[@"scheduleEnable"] integerValue] == 1) {
                [self showChatRoomViewController:[index objectForKey:@"processTo"] processType:[index objectForKey:@"processType"] entranceId:[index objectForKey:@"_id"]];
            }else{
                [self showChatRoomViewController:[index objectForKey:@"id"] processType:@"" entranceId:@""];
            }
        }];
        [alertController addAction:surelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 跳转聊天界面
- (void)showChatRoomViewController:(NSString *)peerId processType:(NSString *)processType entranceId:(NSString *)entranceId {
    QMChatRoomViewController *chatRoomViewController = [[QMChatRoomViewController alloc] init];
    chatRoomViewController.peerId = peerId;
    chatRoomViewController.isPush = NO;
    chatRoomViewController.avaterStr = @"";
    if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
        chatRoomViewController.isOpenSchedule = true;
        chatRoomViewController.scheduleId = self.dictionary[@"scheduleId"];
        chatRoomViewController.processId = self.dictionary[@"processId"];
        chatRoomViewController.currentNodeId = peerId;
        chatRoomViewController.processType = processType;
        chatRoomViewController.entranceId = entranceId;
    } else {
        chatRoomViewController.isOpenSchedule = false;
    }
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
}


- (void)dealloc {
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CUSTOM_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CUSTOM_LOGIN_ERROR_USER object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
