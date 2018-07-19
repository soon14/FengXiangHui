//
//  AllGoodsViewController.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AllGoodsViewController.h"
#import "AllGoodsSearchView.h"
#import "AllGoodsLeftTableViewCell.h"
#import "AllGoodsRightCollectionViewCell.h"
#import "AllGoodsCollectionHeaderView.h"
#import "AllCategoryDataModel.h"

#define TableViewWidth  [UIScreen mainScreen].bounds.size.width * 0.28
#define CollectionViewWidth [UIScreen mainScreen].bounds.size.width * 0.72

@interface AllGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic , strong)UITableView *leftTableView;
@property(nonatomic , strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic , strong)UICollectionView *classifyCollectionView;
/** 搜索框 */
@property(nonatomic , strong)AllGoodsSearchView *searchView;
/** 一级分类模型 */
@property(nonatomic , strong)AllCategoryDataModel *categoryDataModel;
/**  二级分类模型 */
@property(nonatomic , strong)AllCategoryDataResultModel *categoryDataResultModel;

@end

@implementation AllGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"全部商品";
    //添加搜索框
    [self.view addSubview:self.searchView];
    //添加左边tableView
    [self.view addSubview:self.leftTableView];
    //添加右边 collectionView
    [self.view addSubview:self.classifyCollectionView];
    //分类类别数据请求
    [self goodsCategoryRequest];
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

            [self.leftTableView reloadData];
            //选中 tableView 第一行
            NSIndexPath *selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.leftTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
            //刷新 collectionView
            self.categoryDataResultModel = self.categoryDataModel.result[0];
            [self.classifyCollectionView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 搜索框
- (AllGoodsSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[AllGoodsSearchView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 45)];
    }
    return _searchView;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, TableViewWidth, KMAINSIZE.height-KNaviHeight-KTabbarHeight-45) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = KTableBackgroundColor;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.tableFooterView = [[UIView alloc] init];
        [_leftTableView registerClass:[AllGoodsLeftTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AllGoodsLeftTableViewCell class])];
    }
    return _leftTableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryDataModel.result.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllGoodsLeftTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AllGoodsLeftTableViewCell class])];
    leftCell.catetoryModel = self.categoryDataModel.result[indexPath.row];
    return leftCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.categoryDataResultModel = self.categoryDataModel.result[indexPath.row];
    [self.classifyCollectionView reloadData];
}

#pragma mark - collectionView
- (UICollectionView *)classifyCollectionView {
    if (!_classifyCollectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _classifyCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(TableViewWidth, 45, CollectionViewWidth, KMAINSIZE.height-KTabbarHeight-KNaviHeight-45) collectionViewLayout:_customLayout];
        _classifyCollectionView.backgroundColor = [UIColor whiteColor];
        _classifyCollectionView.delegate = self;
        _classifyCollectionView.dataSource = self;
        _classifyCollectionView.showsVerticalScrollIndicator = NO;
        _classifyCollectionView.alwaysBounceVertical = YES;
        [_classifyCollectionView registerClass:[AllGoodsRightCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([AllGoodsRightCollectionViewCell class])];
        [_classifyCollectionView registerClass:[AllGoodsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([AllGoodsCollectionHeaderView class])];
    }
    return _classifyCollectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryDataResultModel.children.count;
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //每行3个 item，每个间隔为5，collection 左右间距也为5
    return (CGSize){(CollectionViewWidth-20)/3, 117*KScreenRatio};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

#pragma mark - sectionHeader 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if ([self.categoryDataResultModel.advimg length] > 0) {
        return (CGSize){KMAINSIZE.width, 130};
    }
    return CGSizeZero;
}

#pragma mark - 指定头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if ([self.categoryDataResultModel.advimg length] > 0) {
            AllGoodsCollectionHeaderView *RView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([AllGoodsCollectionHeaderView class]) forIndexPath:indexPath];
            RView.imageURLString = self.categoryDataResultModel.advimg;
            return RView;
        } return nil;
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AllGoodsRightCollectionViewCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AllGoodsRightCollectionViewCell class]) forIndexPath:indexPath];
    collectionCell.categoryChildrenModel = self.categoryDataResultModel.children[indexPath.item];
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AllCategoryDataChildrenModel *childrenModel = self.categoryDataResultModel.children[indexPath.item];
    NSLog(@"%@",childrenModel.name);
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
