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

#define BottomViewHeight (KBottomHeight+45)                                         //底部 View 的高度
#define FirstTableViewOriginHeight (KMAINSIZE.height-BottomViewHeight)                    //第一个 tableView 高度
#define SecondTableViewOriginHeight (KMAINSIZE.height-KNaviHeight-BottomViewHeight)       //第二个 tableView 高度

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

/** 返回按钮 */
@property(nonatomic , strong)UIButton *backButton;
/** 二维码按钮 */
@property(nonatomic , strong)UIButton *scanCodeButton;
/** 导航栏 */
@property(nonatomic , strong)GoodsDetailNavigationView *navigationView;
/** bottomView */
@property(nonatomic , strong)GoodsDetailBottomView *bottomView;
/** 第一个 tableView */
@property(nonatomic , strong)UITableView *firstTableView;
/** 第二个显示商品详情的 tableView */
@property(nonatomic , strong)UITableView *secondTableView;
/** 商品详情 Model */
@property(nonatomic , strong)GoodsDetailResultModel *resultModel;
/**  第一个 cell 内容高度 */
@property(nonatomic , assign)CGFloat firstTableContentHeight;

@end

@implementation GoodsDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstTableContentHeight = FirstTableViewOriginHeight;
    
    [self goodsDetailDataRequest];
}

#pragma mark - 添加子视图
- (void)initSubviews {
    [self.view addSubview:self.firstTableView];
    [self.view addSubview:self.secondTableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.scanCodeButton];
    [self.view addSubview:self.navigationView];
}

#pragma mark - 导航栏
- (GoodsDetailNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[GoodsDetailNavigationView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KNaviHeight)];
        _navigationView.delegate = self;
        [_navigationView setAlpha:0.0f];
    }
    return _navigationView;
}

#pragma mark - 底部操作栏
- (GoodsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[GoodsDetailBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-BottomViewHeight, KMAINSIZE.width, BottomViewHeight)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)firstTableView {
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, FirstTableViewOriginHeight) style:UITableViewStylePlain];
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
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self getFirstTableViewHeight], KMAINSIZE.width, SecondTableViewOriginHeight) style:UITableViewStylePlain];
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _secondTableView.backgroundColor = KTableBackgroundColor;
        _secondTableView.showsVerticalScrollIndicator = NO;
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        _secondTableView.estimatedRowHeight = 0;
        _secondTableView.estimatedSectionHeaderHeight = 0;
        _secondTableView.estimatedSectionFooterHeight = 0;
        [_secondTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _secondTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.secondTableView) {
        return 1;
    } return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.secondTableView) {
        return 1200;
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
                return 30;
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
        UITableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [detailCell.contentView setBackgroundColor:[UIColor orangeColor]];
        return detailCell;
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
    if (_firstTableContentHeight <= FirstTableViewOriginHeight) {
        _firstTableContentHeight = FirstTableViewOriginHeight;
    } else {
        _firstTableContentHeight = self.firstTableView.contentSize.height;
    }
    return _firstTableContentHeight;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView == self.firstTableView) {
        CGFloat valueNum = _firstTableContentHeight - FirstTableViewOriginHeight;
        if ((offsetY - valueNum) > 50) {
            [self gotoDetailAnimation];//进入图文详情的动画
        }
    } else if (scrollView==self.secondTableView) {
        if (offsetY < -50) {
            [self backToFirstTableViewAnimation];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.firstTableView) {
        CGFloat scale = self.firstTableView.contentOffset.y;
        if (scale < 80 && scale > 0) {
            CGFloat nav_alptha = scale/80;
            self.navigationView.alpha = nav_alptha;
            self.backButton.alpha = 1 - nav_alptha;
            self.scanCodeButton.alpha = 1 - nav_alptha;
        } else if (scale > 80) {
            self.navigationView.alpha = 1.0;
            self.backButton.alpha = 0.0;
            self.scanCodeButton.alpha = 0.0;
        } else if (scale < 0) {
            self.navigationView.alpha = 0.0;
            self.backButton.alpha = 1.0;
            self.scanCodeButton.alpha = 1.0;
        }
    }
}

#pragma mark - 进入图文详情
- (void)gotoDetailAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationView.moveLine.frame = CGRectMake((KMAINSIZE.width/2)+30, KNaviHeight-4, 25, 4);
        [self.navigationView.goodsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.navigationView.goodsButton.titleLabel setFont:KFont(15)];
        [self.navigationView.detailsButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [self.navigationView.detailsButton.titleLabel setFont:KFont(16)];
        _firstTableView.frame = CGRectMake(0, -FirstTableViewOriginHeight, KMAINSIZE.width, FirstTableViewOriginHeight);
        _secondTableView.frame = CGRectMake(0, KNaviHeight, KMAINSIZE.width, SecondTableViewOriginHeight);
    } completion:nil];
}

#pragma mark - 返回宝贝
- (void)backToFirstTableViewAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationView.moveLine.frame = CGRectMake((KMAINSIZE.width/2)-55, KNaviHeight-4, 25, 4);
        [self.navigationView.goodsButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [self.navigationView.goodsButton.titleLabel setFont:KFont(16)];
        [self.navigationView.detailsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.navigationView.detailsButton.titleLabel setFont:KFont(15)];
        _firstTableView.frame = CGRectMake(0, 0, KMAINSIZE.width, FirstTableViewOriginHeight);
        _secondTableView.frame = CGRectMake(0, _firstTableContentHeight, KMAINSIZE.width, SecondTableViewOriginHeight);
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
- (void)GoodsDetailBottomView:(GoodsDetailBottomView *)bottomView buttonAction:(NSInteger)index {
    switch (index) {
        case 0: {//收藏
            NSLog(@"收藏");
        } break;
        case 1: {//跳转店铺
            NSLog(@"跳转店铺");
        } break;
        case 2: {//跳转购物车
            NSLog(@"跳转购物车");
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
    NSLog(@"分享商品");
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
}

//商品详情数据请求
- (void)goodsDetailDataRequest {
    NSString * urlString = @"r=apply.goods.detail";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.goodsID?self.goodsID:@"",@"id",
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [GoodsDetailResultModel yy_modelWithDictionary:responseDic[@"result"]];
            NSLog(@"商品详情：%@",responseDic);
            [self initSubviews];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}

#pragma mark - lazy
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(6, KNaviHeight-44, 44, 44)];
        [_backButton setImage:[UIImage imageNamed:@"goodsDetailBack"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)scanCodeButton {
    if (!_scanCodeButton) {
        _scanCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanCodeButton setFrame:CGRectMake(KMAINSIZE.width-50, KNaviHeight-44, 44, 44)];
        [_scanCodeButton setImage:[UIImage imageNamed:@"goodsDetailScanCode"] forState:UIControlStateNormal];
        [_scanCodeButton addTarget:self action:@selector(scanCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanCodeButton;
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
