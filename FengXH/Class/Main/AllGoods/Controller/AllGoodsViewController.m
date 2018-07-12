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

#define TableViewWidth  [UIScreen mainScreen].bounds.size.width * 0.25
#define CollectionViewWidth [UIScreen mainScreen].bounds.size.width * 0.75

@interface AllGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *leftTableArray;
}
@property(nonatomic , strong)UITableView *leftTableView;
@property(nonatomic , strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic , strong)UICollectionView *classifyCollectionView;
/** 搜索框 */
@property(nonatomic , strong)AllGoodsSearchView *searchView;

@end

static NSString *collectionID = @"RightCollectionViewCellID";
static NSString *collectionHeaderID = @"RightCollectionHeaderID";

@implementation AllGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"全部商品";
    
    [self.view addSubview:self.searchView];
    
    
    leftTableArray = @[@"实时推荐",@"口红精选",@"美容护肤",@"男士护理",@"彩妆香水",@"个人洗护",@"口红精选",@"美白",@"护发素",@"牙齿美白",@"女士护理",@"男士护理",@"青少年",@"中老年",@"口红精选",@"面部护理",@"男士护理",@"身体护理",@"洗漱用品"];
    
    //添加左边tableView
    [self.view addSubview:self.leftTableView];
    
    //添加右边 collectionView
    [self.view addSubview:self.classifyCollectionView];
    
    //选中 tableView 第一行
    NSIndexPath *selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [_leftTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
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
    }
    return _leftTableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return leftTableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllGoodsLeftTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"leftCellID"];
    if (!leftCell) {
        leftCell = [[AllGoodsLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCellID"];
        
    }
    return leftCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    AllGoodsLeftTableViewCell *leftCell = (AllGoodsLeftTableViewCell *)cell;
    [leftCell.titleLabel setText:leftTableArray[indexPath.row]];
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
        [_classifyCollectionView registerClass:[AllGoodsRightCollectionViewCell class] forCellWithReuseIdentifier:collectionID];
        [_classifyCollectionView registerClass:[AllGoodsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderID];
    }
    return _classifyCollectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 17;
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
    return (CGSize){KMAINSIZE.width, 130};
}

#pragma mark - 指定头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        AllGoodsCollectionHeaderView *RView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderID forIndexPath:indexPath];
        return RView;
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AllGoodsRightCollectionViewCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    
    return collectionCell;
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
