//
//  GoodsListViewController.m
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsListHeaderView.h"
#import "GoodsListCollectionCell.h"
#import "GoodsListTableCell.h"
#import "GoodsListModel.h"
#import "AllCategoryDataModel.h"
#import "GoodsListFilterViewController.h"
#import "HomepageBaseGoodsDetailController.h"
// 首页板块类型
typedef NS_ENUM(NSInteger , GoodsListLayoutStyle) {
    CollectionStyle = 0 ,
    TableStyle ,
};

@interface GoodsListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,GoodsListCollectionCellDelegate,GoodsListTableCellDelegate,UITextFieldDelegate>
{
    NSInteger requestPage;
}
/** 头部 View */
@property(nonatomic , strong)GoodsListHeaderView *headerView;
/** collection */
@property(nonatomic , strong)UICollectionView *listCollectionView;
/** 布局格式 */
@property(nonatomic , assign)GoodsListLayoutStyle layoutStyle;
/** 价格排序 */
@property(nonatomic , copy)NSString *priceSorted;
/** 排序规则 */
@property(nonatomic , copy)NSString *orderingRule;
/** 数据模型数组 */
@property(nonatomic , strong)NSMutableArray *goodsListModelArray;
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

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部商品";
    _goodsListModelArray = [NSMutableArray array];
    _filterViewPop = NO;
    
    //首页9.9专区直达这个界面，所以需重新请求全部分类
    if (!self.categoryDataModel) {
        [self goodsCategoryRequest];
    }
    
    _layoutStyle = CollectionStyle;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.listCollectionView];
    
    requestPage = 1;
    [self goodsListRequest];
}




#pragma mark - header所有点击事件的响应
- (void)headerViewBlockAction:(NSInteger)index {
    [self.view endEditing:YES];
    switch (index) {
        case 1001: {
            _layoutStyle = CollectionStyle;
            [self.listCollectionView reloadData];
            [_filterVC takeBackView];
        } break;
        case 1002: {
            _layoutStyle = TableStyle;
            [self.listCollectionView reloadData];
            [_filterVC takeBackView];
        } break;
        case 1003: {
            //NSLog(@"综合");
            _orderingRule = nil;
            _priceSorted = nil;
            requestPage = 1;
            [self goodsListRequest];
            [_filterVC takeBackView];
        } break;
        case 1004: {
            //NSLog(@"销量");
            _orderingRule = @"sales";
            _priceSorted = nil;
            requestPage = 1;
            [self goodsListRequest];
            [_filterVC takeBackView];
        } break;
        case 1005: {
            //NSLog(@"价格低到高");
            _orderingRule = @"minprice";
            _priceSorted = @"asc";
            requestPage = 1;
            [self goodsListRequest];
            [_filterVC takeBackView];
        } break;
        case 1006: {
            //NSLog(@"价格高到低");
            _orderingRule = @"minprice";
            _priceSorted = @"desc";
            requestPage = 1;
            [self goodsListRequest];
            [_filterVC takeBackView];
        } break;
        case 1007: {
            //NSLog(@"筛选");
            if (!_filterViewPop) {
                _filterVC = [[GoodsListFilterViewController alloc]init];
                _filterVC.view.frame = CGRectMake(0, 90, KMAINSIZE.width, KMAINSIZE.height-90-KNaviHeight);
                [self addChildViewController:_filterVC];
                MJWeakSelf
                _filterVC.categoryDataModel = self.categoryDataModel;
                _filterVC.takeBackBlock = ^(NSInteger index) {
                    _filterViewPop = NO;
                };
                _filterVC.confirmBlock = ^(NSString *isrecommand, NSString *isnew, NSString *ishot, NSString *isdiscount, NSString *issendfree, NSString *istime, NSString *categoryID) {
                    _isrecommand = isrecommand;
                    _isnew = isnew;
                    _ishot = ishot;
                    _isdiscount = isdiscount;
                    _issendfree = issendfree;
                    _istime = istime;
                    if (categoryID.length > 0) {
                        _categatoryId = categoryID;
                    }
                    //再次搜索
                    [weakSelf goodsListRequest];
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

#pragma mark - headerView
- (GoodsListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GoodsListHeaderView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 90)];
        _headerView.searchTextField.delegate = self;
        _headerView.searchTextField.text = _searchKeywords;
        MJWeakSelf
        _headerView.headerViewBlock = ^(NSInteger index) {
            [weakSelf headerViewBlockAction:index];
        };
    }
    return _headerView;
}

- (UICollectionView *)listCollectionView {
    if (!_listCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-90) collectionViewLayout:flowLayout];
        _listCollectionView.backgroundColor = KTableBackgroundColor;
        _listCollectionView.alwaysBounceVertical = YES;
        [_listCollectionView registerClass:[GoodsListCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsListCollectionCell class])];
        [_listCollectionView registerClass:[GoodsListTableCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsListTableCell class])];
        _listCollectionView.delegate = self;
        _listCollectionView.dataSource = self;
        _listCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _listCollectionView;
}

#pragma mark - 上拉加载更多
- (void)loadmore {
    requestPage++;
    [self goodsListRequest];
}

#pragma mark - <UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _goodsListModelArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    switch (_layoutStyle) {
        case CollectionStyle: {
            return 5;
        } break;
        case TableStyle: {
            return 1;
        } break;
        default: {
            return CGFLOAT_MIN;
        } break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //每行3个 item，每个间隔为5，collection 左右间距也为5
    switch (_layoutStyle) {
        case CollectionStyle: {
            return (CGSize){(KMAINSIZE.width-5)/2, 270*KScreenRatio};
        } break;
        case TableStyle: {
            return (CGSize){KMAINSIZE.width, 165*KScreenRatio};
        } break;
        default: {
            return CGSizeZero;
        }
            break;
    }
}

#pragma mark - <UICollectionViewDataSource>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (_layoutStyle) {
        case CollectionStyle: {
            GoodsListCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsListCollectionCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        case TableStyle: {
            GoodsListTableCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsListTableCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        default: {
            return nil;
        } break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_goodsListModelArray count] > 0) {
        switch (_layoutStyle) {
            case CollectionStyle: {
                GoodsListCollectionCell * collectionCell = (GoodsListCollectionCell *)cell;
                collectionCell.goodsListCommodityModel = _goodsListModelArray[indexPath.item];
            } break;
            case TableStyle: {
                GoodsListTableCell * tableCell = (GoodsListTableCell *)cell;
                tableCell.goodsListCommodityModel = _goodsListModelArray[indexPath.item];
            } break;
                
            default:
                break;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    GoodsListCommodityModel *commodityModel = _goodsListModelArray[indexPath.item];
    //NSLog(@"进入商品详情：%@",commodityModel.title);
    HomepageBaseGoodsDetailController *vc = [[HomepageBaseGoodsDetailController alloc]init];
    vc.goodsId = commodityModel.goodsID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建请求的参数字典
- (NSMutableDictionary *)getParameterDictionary {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    //第几页
    [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)requestPage] forKey:@"page"];
    // 分页
    [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)KPageSize] forKey:@"pagesize"];
    // 分类 ID
    if (_categatoryId.length > 0) {
        [paramDic setObject:_categatoryId forKey:@"cate"];
    }
    // 搜索关键词
    if (_searchKeywords.length > 0) {
        [paramDic setObject:_searchKeywords forKey:@"keywords"];
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

#pragma mark - 全部商品数据请求
- (void)goodsListRequest {
    NSString * urlString = @"r=apply.goods.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    NSMutableDictionary *paramDic = [self getParameterDictionary];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (requestPage == 1) {
            [_goodsListModelArray removeAllObjects];
        }
        [self.listCollectionView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            GoodsListModel *goodsListModel = [GoodsListModel yy_modelWithDictionary:responseDic[@"result"]];
            [_goodsListModelArray addObjectsFromArray:goodsListModel.list];
            
            if ([goodsListModel.list count] < KPageSize) {
                [self.listCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.listCollectionView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 分类类别数据请求
- (void)goodsCategoryRequest {
    NSString * urlString = @"r=apply.shop.category";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.categoryDataModel = [AllCategoryDataModel yy_modelWithDictionary:responseDic];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    _searchKeywords = textField.text;
    [self goodsListRequest];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [_filterVC takeBackView];
    return YES;
}

#pragma mark - 购买按钮被点击
- (void)GoodsListCollectionCell:(GoodsListCollectionCell *)cell didSelectShoppingCartWith:(GoodsListCommodityModel *)commodityModel {
    [self.view endEditing:YES];
    HomepageBaseGoodsDetailController *vc = [[HomepageBaseGoodsDetailController alloc]init];
    vc.goodsId = commodityModel.goodsID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)GoodsListTableCell:(GoodsListTableCell *)cell didSelectShoppingCartWith:(GoodsListCommodityModel *)commodityModel {
    [self.view endEditing:YES];
    HomepageBaseGoodsDetailController *vc = [[HomepageBaseGoodsDetailController alloc]init];
    vc.goodsId = commodityModel.goodsID;
    [self.navigationController pushViewController:vc animated:YES];
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
