//
//  GoodsDetailViewController.m
//  FengXH
//
//  Created by sun on 2018/9/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailResultModel.h"
#import "GoodsDetailBottomView.h"//底部 View
#import "GoodsDetailNavigationView.h"//自定义的导航栏
#import "GoodsDetailOptionsPopupView.h"//点击加入购物车弹出的 View
#import "GoodsDetailGoodsInfoCell.h"//商品图片、价格、大小标题等 cell
#import "GoodsDetailMemberLevelCell.h"//店主可享受优惠价格 cell
#import "GoodsDetailJDAdressCell.h"//京东商品可选择地址 cell
#import "GoodsDetailFreightCell.h"//运费 cell
#import "GoodsDetailQuelityCell.h"//质量保证等信息 cell
#import "GoodsDetailCountCell.h"//数量、规格等信息
#import "GoodsDetailShopCell.h"//店铺信息
#import "GoodsDetailDragCell.h"//上拉查看详情
#import "GoodsDetailContentImageCell.h"//详情页展示图片 cell
#import "GoodsDetailQRCodePopupView.h"//商品二维码
#import "ZHFAddTitleAddressView.h"//京东四级地址选择
#import "ConfirmOrderViewController.h"//立即购买确认订单


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

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,GoodsDetailBottomViewDelegate,GoodsDetailBottomViewDelegate,GoodsDetailGoodsInfoCellDelegate,GoodsDetailShopCellDelegate,ZHFAddTitleAddressViewDelegate>
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
/** 商品二维码图片 */
@property(nonatomic , strong)UIImageView *goodsQRCode;
/** 京东四级地址选择 */
@property(nonatomic , strong)ZHFAddTitleAddressView *addTitleAddressView;
/** 选择完的京东四级地址，用于展示在 cell 上 */
@property(nonatomic , copy)NSString *jdGoodsAddress;
/** 商品详情 Model */
@property(nonatomic , strong)GoodsDetailResultModel *resultModel;
/** 第一个 tableView 内容高度 */
@property(nonatomic , assign)CGFloat firstTableContentHeight;
/** 规格、数量，用于 cell 上展示 */
@property(nonatomic , copy)NSString *optionsNumString;


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
    
    
}

#pragma mark - 添加子视图
- (void)initSubviews {
    [self.view addSubview:self.firstTableView];
    [self.view addSubview:self.secondTableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.navigationView];
    [self caculateContentImageHeight];
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
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
                if (self.resultModel.seckillinfo) {
                    return (360*KScreenRatio + 150);//秒杀商品
                } return (360*KScreenRatio + 125);//非秒杀商品
            } break;
            case MemberLevelType: {
                if (self.resultModel.member_level) {
                    return 35;
                } return CGFLOAT_MIN;
            } break;
            case JDGoodsAdressType: {
                if (self.resultModel.sku_jdid) {
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
                    if (_jdGoodsAddress) {
                        addressCell.address = _jdGoodsAddress;
                    }
                }
            } break;
            case FreightType: {
                GoodsDetailFreightCell *freightCell = (GoodsDetailFreightCell *)cell;
                if (self.resultModel.jdgoods) {
                    freightCell.jdGoodsModel = self.resultModel.jdgoods;
                } else {
                    freightCell.freight = self.resultModel.dispatchprice;
                }
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
                GoodsDetailCountCell *countCell = (GoodsDetailCountCell *)cell;
                if (self.optionsNumString) {
                    countCell.optionsNumString = self.optionsNumString;
                }
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
                //选择数量规格
                GoodsDetailOptionsPopupView *addCartView = [[GoodsDetailOptionsPopupView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
                addCartView.goodsDetailResultModel = self.resultModel;
                [addCartView showInView:self.view];
                MJWeakSelf
                addCartView.optionsSelectedBlock = ^(GoodsDetailResultOptionsModel *optionsModel, NSString *IDNumberString, NSString *goodsNum) {
                    weakSelf.optionsNumString = [NSString stringWithFormat:@"数量:%ld\t\t\t%@",[goodsNum integerValue],optionsModel?optionsModel.title:@""];
                    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:CountType];
                    [weakSelf.firstTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                };
            } break;
            case JDGoodsAdressType: {
                //京东商品选择地址查看运费
                [self.addTitleAddressView addAnimate];
            } break;
                
            default:
                break;
        }
    }
}

#pragma mark - ZHFAddTitleAddressViewDelegate
-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
    if (titleAddress.length > 0) {
        NSMutableString *addressString = [NSMutableString stringWithString:titleAddress];
        [addressString deleteCharactersInRange:NSMakeRange(0, 1)];
        _jdGoodsAddress = addressString;
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:JDGoodsAdressType];
        [self.firstTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [self jdGoodsFreightRequest:titleID];
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
        case 3: {
            //加入购物车
            if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                GoodsDetailOptionsPopupView *addCartView = [[GoodsDetailOptionsPopupView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
                addCartView.goodsDetailResultModel = self.resultModel;
                [addCartView showInView:self.view];
                MJWeakSelf
                addCartView.optionsSelectedBlock = ^(GoodsDetailResultOptionsModel *optionsModel, NSString *IDNumberString, NSString *goodsNum) {
                    weakSelf.optionsNumString = [NSString stringWithFormat:@"数量:%ld\t\t\t%@",[goodsNum integerValue],optionsModel?optionsModel.title:@""];
                    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:CountType];
                    [weakSelf.firstTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    [weakSelf addGoodsToShopCart:optionsModel IDNumber:IDNumberString Count:goodsNum];
                };
            } else {
                [DBHUD ShowInView:self.view withTitle:@"请先前往个人中心登录或注册"];
            }
        } break;
        case 4: {
            //立即购买
            if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                GoodsDetailOptionsPopupView *addCartView = [[GoodsDetailOptionsPopupView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
                addCartView.goodsDetailResultModel = self.resultModel;
                [addCartView showInView:self.view];
                MJWeakSelf
                addCartView.optionsSelectedBlock = ^(GoodsDetailResultOptionsModel *optionsModel, NSString *IDNumberString, NSString *goodsNum) {
                    weakSelf.optionsNumString = [NSString stringWithFormat:@"数量:%ld\t\t\t%@",[goodsNum integerValue],optionsModel?optionsModel.title:@""];
                    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:CountType];
                    [weakSelf.firstTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    ConfirmOrderViewController *VC = [[ConfirmOrderViewController alloc] init];
                    VC.goodsID = weakSelf.goodsID;
                    VC.optionID = optionsModel.optionsID;
                    VC.goodsNum = goodsNum;
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                };
            } else {
                [DBHUD ShowInView:self.view withTitle:@"请先前往个人中心登录或注册"];
            }
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
    GoodsDetailQRCodePopupView *QRCodeView = [[GoodsDetailQRCodePopupView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
    QRCodeView.imageURL = self.resultModel.share_image;
    [QRCodeView showInView:self.view];
}

#pragma mark - 加入购物车请求
- (void)addGoodsToShopCart:(GoodsDetailResultOptionsModel *)optionsModel IDNumber:(NSString *)IDNum Count:(NSString *)count {
    NSString *url = @"r=apply.cart.add";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
        [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    }
    if (self.goodsID) {
        [paramDic setObject:self.goodsID forKey:@"id"];
    }
    if (optionsModel) {
        [paramDic setObject:optionsModel.optionsID forKey:@"optionid"];
    }
    if (count) {
        [paramDic setObject:count forKey:@"total"];
    }
    [DBHUD ShowProgressInview:[UIApplication sharedApplication].keyWindow Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:[UIApplication sharedApplication].keyWindow];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:[UIApplication sharedApplication].keyWindow withTitle:@"添加到购物车成功"];
        } else {
            [DBHUD ShowInView:[UIApplication sharedApplication].keyWindow withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:[UIApplication sharedApplication].keyWindow];
        [DBHUD ShowInView:[UIApplication sharedApplication].keyWindow withTitle:KNetworkError];
        
    }];
}

#pragma mark - 根据地址 id 查询京东商品运费请求
- (void)jdGoodsFreightRequest:(NSString *)addressID {
    NSMutableArray *idArray = [NSMutableArray arrayWithArray:[addressID componentsSeparatedByString:@","]];
    if (idArray.count < 4) {
        [idArray addObject:@"0"];
    }
    NSMutableString *idsString = [NSMutableString string];
    for (NSString *str in idArray) {
        [idsString appendString:[NSString stringWithFormat:@",%@",str]];
    }
    [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
    NSString *url = @"r=apply.goods.kpl_freight";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%ld",self.resultModel.sku_jdid],@"sku_jdid",
                              idsString,@"address", nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue] == 1) {
            self.resultModel.jdgoods = [GoodsDetailResultJDGoodsModel yy_modelWithDictionary:responseDic[@"result"]];
            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:FreightType];
            [self.firstTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
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
            //NSLog(@"商品详情：%@",responseDic);
            [self initSubviews];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}

#pragma mark - lazy
- (ZHFAddTitleAddressView *)addTitleAddressView {
    if (!_addTitleAddressView) {
        _addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
        _addTitleAddressView.title = @"选择地址";
        _addTitleAddressView.delegate1 = self;
        _addTitleAddressView.defaultHeight = 450;
        _addTitleAddressView.titleScrollViewH = 37;
    }
    return _addTitleAddressView;
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
}





- (void)dealloc {
    NSLog(@"%s",__func__);
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
