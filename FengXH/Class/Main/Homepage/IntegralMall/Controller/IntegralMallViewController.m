//
//  IntegralMallViewController.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralMallViewController.h"
#import "IntegralmallHeaderView.h"
#import "IntegralMallResultModel.h"
#import "IntegralMallGoodsCell.h"
#import "IntegralGoodsDetailViewController.h"

@interface IntegralMallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *itemsModelArray;
}
/** collection */
@property(nonatomic , strong)UICollectionView *mallCollectionView;

@end

@implementation IntegralMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    itemsModelArray = [NSMutableArray array];
    
    [self.view addSubview:self.mallCollectionView];
    
    [self requestIntegralMallData];
}

#pragma mark - 积分商城数据请求
- (void)requestIntegralMallData {
    NSString *url = @"r=apply.diypage";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:@"29",@"id", nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        [itemsModelArray removeAllObjects];
        [self.mallCollectionView.mj_header endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            IntegralMallResultModel *resultModel = [IntegralMallResultModel yy_modelWithDictionary:responseDic[@"result"]];
            for (IntegralMallResultItemsModel *itemsModel in resultModel.items) {
                if ([itemsModel.itemsID isEqualToString:@"goods"]) {
                    [itemsModelArray addObject:itemsModel];
                }
            }
            [self.mallCollectionView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.mallCollectionView.mj_header.isRefreshing == YES) {
            [self.mallCollectionView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - collectionView
- (UICollectionView *)mallCollectionView {
    if (!_mallCollectionView) {
        UICollectionViewFlowLayout *_customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _mallCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+90)) collectionViewLayout:_customLayout];
        _mallCollectionView.backgroundColor = KTableBackgroundColor;
        _mallCollectionView.delegate = self;
        _mallCollectionView.dataSource = self;
        _mallCollectionView.showsVerticalScrollIndicator = NO;
        _mallCollectionView.alwaysBounceVertical = YES;
        [_mallCollectionView registerClass:[IntegralMallHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([IntegralMallHeaderView class])];
        [_mallCollectionView registerClass:[IntegralMallGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([IntegralMallGoodsCell class])];
        _mallCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    return _mallCollectionView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_mallCollectionView.mj_footer.isRefreshing) {
        [self requestIntegralMallData];
    }
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return itemsModelArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    IntegralMallResultItemsModel *itemsModel = itemsModelArray[section];
    return itemsModel.items.count;
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(KMAINSIZE.width/2, (KMAINSIZE.width/2)+130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - sectionHeader 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KMAINSIZE.width, 45);
}

#pragma mark - 指定头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        IntegralMallHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([IntegralMallHeaderView class]) forIndexPath:indexPath];
        switch (indexPath.section) {
            case 0: {
                headerView.title = @"积分福利";
            } break;
            case 1: {
                headerView.title = @"格调生活";
            } break;
            default: {
                headerView.title = @"其他";
            } break;
        }
        return headerView;
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IntegralMallGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IntegralMallGoodsCell class]) forIndexPath:indexPath];
    IntegralMallResultItemsModel *itemsModel = itemsModelArray[indexPath.section];
    goodsCell.integralGoodsModel = itemsModel.items[indexPath.item];
    return goodsCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
        IntegralMallResultItemsModel *itemsModel = itemsModelArray[indexPath.section];
        IntegralMallResultItemsGoodsModel *goodsModel = itemsModel.items[indexPath.item];
        IntegralGoodsDetailViewController *VC = [[IntegralGoodsDetailViewController alloc] init];
        VC.goodsID = goodsModel.gid;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        [self presentLoginViewControllerWithSuccessBlock:^{
            
        } WithFailureBlock:^{
            
        }];
    }
    
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
