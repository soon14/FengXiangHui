//
//  MerchantsUnionViewController.m
//  FengXH
//
//  Created by sun on 2018/9/25.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "MerchantsUnionViewController.h"
#import "GoodsDetailResultModel.h"
#import "UICollectionViewFlowLayout+Add.h"
#import "MerchantsUnionShopkeeperCell.h"
#import "merchantsUnionHeaderView.h"
#import "GoodsListFilterViewController.h"
#import "GoodsListModel.h"
#import "GoodsListTableCell.h"
#import "GoodsListCollectionCell.h"
#import "GoodsDetailViewController.h"

typedef NS_ENUM(NSInteger , ShopGoodsLayoutStyle) {
    CollectionStyle = 0 ,
    TableStyle ,
};

@interface MerchantsUnionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,GoodsListCollectionCellDelegate,GoodsListTableCellDelegate>
{
    NSInteger requestPage;//请求页数
    NSMutableArray *goodsListModelArray;//商品模型数组
}
/** UICollectionView */
@property(nonatomic , strong)UICollectionView *shopCollectionView;
/** 布局x样式 */
@property(nonatomic , assign)ShopGoodsLayoutStyle layoutStyle;
/** 搜索框 */
@property(nonatomic , strong)UITextField *searchTextField;
/** 价格排序 */
@property(nonatomic , copy)NSString *priceSorted;
/** 排序规则 */
@property(nonatomic , copy)NSString *orderingRule;
/** 筛选的 View */
@property(nonatomic , strong)GoodsListFilterViewController *filterVC;
/** 筛选的 View 是否弹出 */
@property(nonatomic , assign)BOOL filterViewPop;

/// 筛选分类用
/** 推荐商品 */
@property(nonatomic , copy)NSString *isrecommand;
/** 新品上市 */
@property(nonatomic , copy)NSString *isnew;
/** 热卖商品 */
@property(nonatomic , copy)NSString *ishot;
/** 促销商品 */
@property(nonatomic , copy)NSString *isdiscount;
/** 卖家包邮 */
@property(nonatomic , copy)NSString *issendfree;
/** 限时抢购 */
@property(nonatomic , copy)NSString *istime;

@end

@implementation MerchantsUnionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺主页";
    goodsListModelArray = [NSMutableArray array];
    _filterViewPop = NO;
    _layoutStyle = CollectionStyle;
    
    [self.view addSubview:self.shopCollectionView];
    
    requestPage = 1;
    [self merchantsGoodsListRequest:requestPage];
}



#pragma mark - collectionView
- (UICollectionView *)shopCollectionView {
    if (!_shopCollectionView) {
        UICollectionViewFlowLayout *_customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _shopCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) collectionViewLayout:_customLayout];
        _customLayout.sectionHeadersPinToVisibleBoundsAll = YES;
        _shopCollectionView.backgroundColor = KTableBackgroundColor;
        _shopCollectionView.delegate = self;
        _shopCollectionView.dataSource = self;
        _shopCollectionView.showsVerticalScrollIndicator = NO;
        _shopCollectionView.alwaysBounceVertical = YES;
        [_shopCollectionView registerClass:[MerchantsUnionShopkeeperCell class] forCellWithReuseIdentifier:NSStringFromClass([MerchantsUnionShopkeeperCell class])];
        [_shopCollectionView registerClass:[GoodsListTableCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsListTableCell class])];
        [_shopCollectionView registerClass:[GoodsListCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsListCollectionCell class])];
        [_shopCollectionView registerClass:[MerchantsUnionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MerchantsUnionHeaderView class])];
        _shopCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _shopCollectionView;
}

#pragma mark - 上拉加载更多
- (void)loadmore {
    requestPage++;
    [self merchantsGoodsListRequest:requestPage];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            if (self.goodsDetailResultModel) {
                return 1;
            } return 0;
        } break;
        case 1: {
            return goodsListModelArray.count;
        } break;
        default: return 0; break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (self.goodsDetailResultModel) {
                return CGSizeMake(KMAINSIZE.width, 70);
            } return CGSizeZero;
        } break;
        case 1: {
            if (goodsListModelArray.count > 0) {
                switch (_layoutStyle) {
                    case CollectionStyle: {
                        return (CGSize){(KMAINSIZE.width-5)/2, 180*KScreenRatio+90};
                    } break;
                    case TableStyle: {
                        return (CGSize){KMAINSIZE.width, 160*KScreenRatio};
                    } break;
                    default: {
                        return CGSizeZero;
                    } break;
                }
            } return CGSizeZero;
        } break;
        default: return CGSizeZero; break;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 1: {
            return UIEdgeInsetsMake(5, 0, 5, 0);
        } break;
        default: {
            return UIEdgeInsetsZero;
        } break;
    }
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 1: {
            switch (_layoutStyle) {
                case CollectionStyle: {
                    return 5;
                } break;
                case TableStyle: {
                    return 0.5;
                } break;
                default: {
                    return CGFLOAT_MIN;
                } break;
            }
        } break;
        default: {
            return CGFLOAT_MIN;
        } break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - sectionHeader 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1: {
            return CGSizeMake(KMAINSIZE.width, 90);
        } break;
        default: {
            return CGSizeZero;
        } break;
    }
}

#pragma mark - 指定头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                MerchantsUnionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([MerchantsUnionHeaderView class]) forIndexPath:indexPath];
                return headerView;
            }
            return nil;
        } break;
        default: return nil; break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                MerchantsUnionHeaderView *headerView = (MerchantsUnionHeaderView *)view;
                headerView.searchTextField.delegate = self;
                self.searchTextField = headerView.searchTextField;
                MJWeakSelf
                headerView.headerViewBlock = ^(NSInteger index) {
                    [weakSelf headerViewBlockAction:index];
                };
            }
        } break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            MerchantsUnionShopkeeperCell *shopkeeperCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MerchantsUnionShopkeeperCell class]) forIndexPath:indexPath];
            return shopkeeperCell;
        } break;
        case 1: {
            if ([goodsListModelArray count] > 0) {
                switch (_layoutStyle) {
                    case CollectionStyle: {
                        GoodsListCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsListCollectionCell class]) forIndexPath:indexPath];
                        return cell;
                    } break;
                    case TableStyle: {
                        GoodsListTableCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsListTableCell class]) forIndexPath:indexPath];
                        return cell;
                    } break;
                    default: {
                        return nil;
                    } break;
                }
            } return nil;
        } break;
        default: {
            return nil;
        } break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (self.goodsDetailResultModel) {
                MerchantsUnionShopkeeperCell *shopkeeperCell = (MerchantsUnionShopkeeperCell *)cell;
                shopkeeperCell.shopDetailModel = self.goodsDetailResultModel.shopdetail;
            }
        } break;
        case 1: {
            if ([goodsListModelArray count] > 0) {
                switch (_layoutStyle) {
                    case CollectionStyle: {
                        GoodsListCollectionCell * collectionCell = (GoodsListCollectionCell *)cell;
                        collectionCell.delegate = self;
                        collectionCell.goodsListCommodityModel = goodsListModelArray[indexPath.item];
                    } break;
                    case TableStyle: {
                        GoodsListTableCell * tableCell = (GoodsListTableCell *)cell;
                        tableCell.delegate = self;
                        tableCell.goodsListCommodityModel = goodsListModelArray[indexPath.item];
                    } break;
                        
                    default:
                        break;
                }
            }
        } break;
            
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    switch (indexPath.section) {
        case 1: {
            GoodsListCommodityModel *commodityModel = goodsListModelArray[indexPath.item];
            GoodsDetailViewController *VC = [[GoodsDetailViewController alloc]init];
            VC.goodsID = commodityModel.goodsID;
            [self.navigationController pushViewController:VC animated:YES];
        } break;
            
        default:
            break;
    }
}

#pragma mark - 购买按钮被点击
- (void)GoodsListCollectionCell:(GoodsListCollectionCell *)cell didSelectShoppingCartWith:(GoodsListCommodityModel *)commodityModel {
    [self.view endEditing:YES];
    GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
    VC.goodsID = commodityModel.goodsID;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)GoodsListTableCell:(GoodsListTableCell *)cell didSelectShoppingCartWith:(GoodsListCommodityModel *)commodityModel {
    [self.view endEditing:YES];
    GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
    VC.goodsID = commodityModel.goodsID;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    self.searchTextField.text = textField.text;
    requestPage = 1;
    [self merchantsGoodsListRequest:requestPage];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [_filterVC takeBackView];
    return YES;
}

#pragma mark - header所有点击事件的响应
- (void)headerViewBlockAction:(NSInteger)index {
    [self.view endEditing:YES];
    switch (index) {
        case 1001: {
            _layoutStyle = CollectionStyle;
            [self.shopCollectionView reloadData];
            [_filterVC takeBackView];
        } break;
        case 1002: {
            _layoutStyle = TableStyle;
            [self.shopCollectionView reloadData];
            [_filterVC takeBackView];
        } break;
        case 1003: {
            //NSLog(@"综合");
            _orderingRule = nil;
            _priceSorted = nil;
            _isrecommand = nil;
            _isnew = nil;
            _ishot = nil;
            _isdiscount = nil;
            _issendfree = nil;
            _istime = nil;
            requestPage = 1;
            [self merchantsGoodsListRequest:requestPage];
            [_filterVC takeBackView];
        } break;
        case 1004: {
            //NSLog(@"销量");
            _orderingRule = @"sales";
            _priceSorted = nil;
            _isrecommand = nil;
            _isnew = nil;
            _ishot = nil;
            _isdiscount = nil;
            _issendfree = nil;
            _istime = nil;
            requestPage = 1;
            [self merchantsGoodsListRequest:requestPage];
            [_filterVC takeBackView];
        } break;
        case 1005: {
            //NSLog(@"价格低到高");
            _orderingRule = @"minprice";
            _priceSorted = @"asc";
            _isrecommand = nil;
            _isnew = nil;
            _ishot = nil;
            _isdiscount = nil;
            _issendfree = nil;
            _istime = nil;
            requestPage = 1;
            [self merchantsGoodsListRequest:requestPage];
            [_filterVC takeBackView];
        } break;
        case 1006: {
            //NSLog(@"价格高到低");
            _orderingRule = @"minprice";
            _priceSorted = @"desc";
            _isrecommand = nil;
            _isnew = nil;
            _ishot = nil;
            _isdiscount = nil;
            _issendfree = nil;
            _istime = nil;
            requestPage = 1;
            [self merchantsGoodsListRequest:requestPage];
            [_filterVC takeBackView];
        } break;
        case 1007: {
            //NSLog(@"筛选");
            if (!_filterViewPop) {
                _filterVC = [[GoodsListFilterViewController alloc]init];
                _filterVC.view.frame = CGRectMake(0, 160-[self getCollectionViewContentOffset], KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-160+[self getCollectionViewContentOffset]);
                [self addChildViewController:_filterVC];
                MJWeakSelf
                _filterVC.takeBackBlock = ^(NSInteger index) {
                    _filterViewPop = NO;
                };
                _filterVC.confirmBlock = ^(NSString *isrecommand, NSString *isnew, NSString *ishot, NSString *isdiscount, NSString *issendfree, NSString *istime) {
                    _isrecommand = isrecommand;
                    _isnew = isnew;
                    _ishot = ishot;
                    _isdiscount = isdiscount;
                    _issendfree = issendfree;
                    _istime = istime;
                    _orderingRule = nil;
                    _priceSorted = nil;
                    requestPage = 1;
                    //再次搜索
                    [weakSelf merchantsGoodsListRequest:1];
                };
                [self.view addSubview:_filterVC.view];
                [_filterVC showView];
                _filterViewPop = YES;
            }
        } break;
        default:
            break;
    }
}

#pragma mark - 获取 collectionView 偏移
- (CGFloat)getCollectionViewContentOffset {
    if (self.shopCollectionView.contentOffset.y < 70) {
        return self.shopCollectionView.contentOffset.y;
    } else {
        return 70;
    }
}

#pragma mark - 创建请求的参数字典
- (NSMutableDictionary *)getParameterDictionary {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    //第几页
    [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)requestPage] forKey:@"page"];
    // 分页
    [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)KPageSize] forKey:@"pagesize"];
    // 商户 ID
    if (self.goodsDetailResultModel.merchid && self.goodsDetailResultModel.merchid.length > 0) {
        [paramDic setObject:self.goodsDetailResultModel.merchid forKey:@"merchid"];
    }
    // 搜索关键词
    if (_searchTextField.text.length > 0) {
        [paramDic setObject:_searchTextField.text forKey:@"keywords"];
    }
    //排序规则
    if (_orderingRule.length > 0) {
        [paramDic setObject:_orderingRule forKey:@"order"];
    }
    // 价格排序
    if (_priceSorted.length > 0) {
        [paramDic setObject:_priceSorted forKey:@"by"];
    }
    //推荐商品  isrecommand     1:是     0:否
    if (_isrecommand.length > 0) {
        [paramDic setObject:_isrecommand forKey:@"isrecommand"];
    }
    //新品上市  isnew           1:是     0:否
    if (_isnew.length > 0) {
        [paramDic setObject:_isnew forKey:@"isnew"];
    }
    //热卖商品  ishot           1:是     0:否
    if (_ishot.length > 0) {
        [paramDic setObject:_ishot forKey:@"ishot"];
    }
    //促销商品  isdiscount      1:是     0:否
    if (_isdiscount.length > 0) {
        [paramDic setObject:_isdiscount forKey:@"isdiscount"];
    }
    //卖家包邮  issendfree      1:是     0:否
    if (_issendfree.length > 0) {
        [paramDic setObject:_issendfree forKey:@"issendfree"];
    }
    //限时抢购  istime          1:是     0:否
    if (_istime.length > 0) {
        [paramDic setObject:_istime forKey:@"istime"];
    }
    
    return paramDic;
}

#pragma mark - 店铺商品数据请求
- (void)merchantsGoodsListRequest:(NSInteger)page {
    NSString * urlString = @"r=apply.goods.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    NSMutableDictionary *paramDic = [self getParameterDictionary];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (requestPage == 1) {
            [goodsListModelArray removeAllObjects];
        }
        [self.shopCollectionView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            GoodsListModel *goodsListModel = [GoodsListModel yy_modelWithDictionary:responseDic[@"result"]];
            [goodsListModelArray addObjectsFromArray:goodsListModel.list];
            
            if ([goodsListModel.list count] < KPageSize) {
                [self.shopCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.shopCollectionView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
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
