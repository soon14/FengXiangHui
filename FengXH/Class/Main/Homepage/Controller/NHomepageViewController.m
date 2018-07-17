//
//  NHomepageViewController.m
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "NHomepageViewController.h"
#import "HomepageDataModel.h" // 所有模型
#import "SDCycleScrollView.h" // banner，随便找了一个
#import "HomePageFunctionCell.h" // 功能区Cell
#import "HomePageHotSpotCell.h" // 热点Cell
#import "HomePagePicturewCell.h" // 联盟图片
#import "HomePageFoodieGoodsCell.h" // 联盟商品
#import "HomePageSecondKillTimeCell.h"//秒杀倒计时
#import "HomePageSecondKillGoodsCell.h"//秒杀商品

// 首页板块类型
typedef NS_ENUM(NSInteger , HomePageStyle) {
    /// banner板块
    HomePageStyle_banner = 0 ,
    /// 10个按钮板块上面的五个
    HomePageStyle_function1 ,
    /// 10个按钮板块下面的五个
    HomePageStyle_function2 ,
    /// 热点
    HomePageStyle_hotSport ,
    /// 店主礼包、京东优选、店主专区
    HomePageStyle_picturew ,
    /// 整点秒杀时间
    HomePageStyle_secondKill_time ,
    /// 整点秒杀商品
    HomePageStyle_secondKill_goods ,
    /// 吃货联盟
    HomePageStyle_foodie ,
    /// 吃货联盟商品
    HomePageStyle_foodie_goods ,
    /// 爱在护肤
    HomePageStyle_skincare ,
    /// 爱在护肤商品
    HomePageStyle_skincare_goods ,
    /// 美时美刻
    HomePageStyle_merryTime ,
    /// 美时美刻商品
    HomePageStyle_merryTime_goods ,
    /// 安家落户
    HomePageStyle_settledown ,
    /// 安家落户商品
    HomePageStyle_settledown_goods ,
    /// 咿呀学语
    HomePageStyle_burble ,
    /// 咿呀学语商品
    HomePageStyle_burble_goods ,
    /// 强身健体
    HomePageStyle_bodybuilding ,
    /// 强身健体商品
    HomePageStyle_bodybuilding_goods ,
    /// 猜你喜欢
    HomePageStyle_guesslike ,
    /// 猜你喜欢商品
    HomePageStyle_guesslike_goods
};

@interface NHomepageViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,HomePageFunctionDelegate,HomePagePicturewDelegate,HomePageSecondKillTimeDelegate,HomePageSecondKillGoodsDelegate,HomePageFoodieGoodsDelegate,HomePageFoodieGoodsDetailDelegate>

/** 首页Collectionview */
@property(nonatomic , strong)UICollectionView *homeCollectionView ;
/** 首页板块个数，由这个数字来控制板块数量和类型，可随意调换位置，方便后期维护 */
@property(nonatomic , strong)NSArray *homePlateTypeArray ;
/** 轮播控件 */
@property(nonatomic , strong)SDCycleScrollView *bannerScrollView;
/** 数据模型 */
@property(nonatomic , strong)HomepageDataModel *dataModel;
/** 滚动广告的图片数组 */
@property(nonatomic , strong)NSMutableArray *bannerImageArray;

@end

@implementation NHomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"疯享汇全球优选商城";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.homeCollectionView];
    [self homepageDateRequest];
}

#pragma mark - 首页数据请求
- (void)homepageDateRequest {
    NSString * urlString = @"r=apply";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] isEqualToString:@"1"]) {
            
            self.dataModel = [HomepageDataModel yy_modelWithDictionary:responseDic[@"result"]];
            //滚动广告图片数组
            self.bannerImageArray = [NSMutableArray array];
            if ([self.dataModel.M1471835880921.data count] > 0) {
                for (HomepageDataBannerDataModel *bannerModel in self.dataModel.M1471835880921.data) {
                    [self.bannerImageArray addObject:bannerModel.imgurl];
                }
            }
            [self.homeCollectionView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homePlateTypeArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    switch (style) {
        case HomePageStyle_banner: {
            UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
            self.bannerScrollView.imageURLStringsGroup = self.bannerImageArray;
            [cell.contentView addSubview:self.bannerScrollView];
            return cell;
        } break;
        case HomePageStyle_function1:
        case HomePageStyle_function2:{
            HomePageFunctionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageFunctionCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        case HomePageStyle_hotSport: {
            HomePageHotSpotCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageHotSpotCell class]) forIndexPath:indexPath];
            return cell;
        } break;
        case HomePageStyle_secondKill_time: {
            HomePageSecondKillTimeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillTimeCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        case HomePageStyle_secondKill_goods: {
            HomePageSecondKillGoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillGoodsCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        case HomePageStyle_picturew:
        case HomePageStyle_foodie:
        case HomePageStyle_skincare:
        case HomePageStyle_merryTime:
        case HomePageStyle_settledown:
        case HomePageStyle_burble:
        case HomePageStyle_bodybuilding:
        case HomePageStyle_guesslike:{
            HomePagePicturewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePagePicturewCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        case HomePageStyle_foodie_goods:
        case HomePageStyle_skincare_goods:
        case HomePageStyle_merryTime_goods:
        case HomePageStyle_settledown_goods:
        case HomePageStyle_burble_goods:
        case HomePageStyle_bodybuilding_goods:{
            HomePageFoodieGoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageFoodieGoodsCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        case HomePageStyle_guesslike_goods: {
            HomePageFoodieGoodsDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageFoodieGoodsDetailCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        } break;
        default: {
            return nil;
        } break;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guesslike_goods: {
            return self.dataModel.M1530682437506.goods_list.count;
        } break;
        default: {
            return 1;
        } break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    switch (style) {
        case HomePageStyle_banner: {
            
        } break;
        case HomePageStyle_function1: {
            HomePageFunctionCell * functionCell = (HomePageFunctionCell *)cell;
            functionCell.menuDataArray = self.dataModel.M1471835886075.data;
        } break;
        case HomePageStyle_function2: {
            HomePageFunctionCell * functionCell = (HomePageFunctionCell *)cell;
            functionCell.menuDataArray = self.dataModel.M1529474107640.data;
        } break;
        case HomePageStyle_hotSport: {
            HomePageHotSpotCell * hotSpotCell = (HomePageHotSpotCell *)cell;
            hotSpotCell.noticeDataModel = self.dataModel.M1482809676486.data;
        } break;
        case HomePageStyle_picturew: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1528772177656.data;
        } break;
        case HomePageStyle_secondKill_time: {
            HomePageSecondKillTimeCell * timeCell = (HomePageSecondKillTimeCell *)cell;
            timeCell.secondKillModel = self.dataModel.M1510122188416;
        } break;
        case HomePageStyle_secondKill_goods: {
            HomePageSecondKillGoodsCell * secondKillCell = (HomePageSecondKillGoodsCell *)cell;
            secondKillCell.goodsArray = self.dataModel.M1510122188416.data.goods;
        } break;
        case HomePageStyle_foodie:{
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1512455725970.data;
        } break;
        case HomePageStyle_foodie_goods:{
            HomePageFoodieGoodsCell * foodieCell = (HomePageFoodieGoodsCell *)cell;
            foodieCell.foodsArray = self.dataModel.M1516787844386.goods_list;
        } break;
        case HomePageStyle_skincare: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1512455784147.data;
        } break;
        case HomePageStyle_skincare_goods: {
            HomePageFoodieGoodsCell * foodieCell = (HomePageFoodieGoodsCell *)cell;
            foodieCell.foodsArray = self.dataModel.M1512373325297.goods_list;
        } break;
        case HomePageStyle_merryTime: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1512455826986.data;
        } break;
        case HomePageStyle_merryTime_goods: {
            HomePageFoodieGoodsCell * foodieCell = (HomePageFoodieGoodsCell *)cell;
            foodieCell.foodsArray = self.dataModel.M1512373372365.goods_list;
        } break;
        case HomePageStyle_settledown: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1512455857299.data;
        } break;
        case HomePageStyle_settledown_goods: {
            HomePageFoodieGoodsCell * foodieCell = (HomePageFoodieGoodsCell *)cell;
            foodieCell.foodsArray = self.dataModel.M1487819230395.goods_list;
        } break;
        case HomePageStyle_burble: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1512455916966.data;
        } break;
        case HomePageStyle_burble_goods: {
            HomePageFoodieGoodsCell * foodieCell = (HomePageFoodieGoodsCell *)cell;
            foodieCell.foodsArray = self.dataModel.M1487818916357.goods_list;
        } break;
        case HomePageStyle_bodybuilding: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1512455889850.data;
        } break;
        case HomePageStyle_bodybuilding_goods: {
            HomePageFoodieGoodsCell * foodieCell = (HomePageFoodieGoodsCell *)cell;
            foodieCell.foodsArray = self.dataModel.M1512373413982.goods_list;
        } break;
        case HomePageStyle_guesslike: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            picturCell.pictureArray = self.dataModel.M1530682233521.data;
        } break;
        case HomePageStyle_guesslike_goods: {
            HomePageFoodieGoodsDetailCell * guesslickCell = (HomePageFoodieGoodsDetailCell *)cell;
            guesslickCell.guessLikeModel = self.dataModel.M1530682437506.goods_list[indexPath.item];
        } break;
        default: {
        } break;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    switch (style) {
        case HomePageStyle_guesslike_goods: {
            // 点击了猜你喜欢某个item
            HomepageDataGuessYouLikeGoodsDataModel * guessLikeModel = self.dataModel.M1530682437506.goods_list[indexPath.item];
            // other
            NSLog(@"猜你喜欢商品点击了整个商品事件%@",guessLikeModel);
        } break;
        default: {
        } break;
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    CGFloat collectionViewWidth = collectionView.frame.size.width;
    switch (style) {
        case HomePageStyle_banner: {
            return CGSizeMake(collectionViewWidth, 146 * KScreenRatio);
        } break;
        case HomePageStyle_function1: {
            return CGSizeMake(collectionViewWidth, ([self.dataModel.M1471835886075.data count] / 5.0) * 100.0);
        } break;
        case HomePageStyle_function2: {
            return CGSizeMake(collectionViewWidth, ([self.dataModel.M1529474107640.data count] / 5.0) * 100.0);
        } break;
        case HomePageStyle_hotSport:
        case HomePageStyle_secondKill_time: {
            return CGSizeMake(collectionViewWidth, 40);
        } break;
        case HomePageStyle_secondKill_goods: {
            return CGSizeMake(collectionViewWidth, 130);
        } break;
        case HomePageStyle_picturew: {
            return CGSizeMake(collectionViewWidth, 160*KScreenRatio);
        } break;
        case HomePageStyle_foodie:
        case HomePageStyle_skincare:
        case HomePageStyle_merryTime:
        case HomePageStyle_settledown:
        case HomePageStyle_burble:
        case HomePageStyle_bodybuilding:{
            return CGSizeMake(collectionViewWidth, 47);
        } break;
        case HomePageStyle_foodie_goods:
        case HomePageStyle_skincare_goods:
        case HomePageStyle_merryTime_goods:
        case HomePageStyle_settledown_goods:
        case HomePageStyle_burble_goods:
        case HomePageStyle_bodybuilding_goods:{
            return CGSizeMake(collectionViewWidth, 227*KScreenRatio);
        } break;
        case HomePageStyle_guesslike: {
            return CGSizeMake(collectionViewWidth, 45.0);
        } break;
        case HomePageStyle_guesslike_goods: {
            return CGSizeMake((collectionViewWidth - 20.0) / 3.0, 227*KScreenRatio);
        } break;
        default: {
            return CGSizeZero;
        } break;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guesslike_goods: {
            return UIEdgeInsetsMake(5, 5, 5, 5);
        } break;
        default: {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        } break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guesslike_goods: {
            return 5.0;
        } break;
        default: {
            return CGFLOAT_MIN;
        } break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guesslike_goods: {
            return 5.0;
        } break;
        default: {
            return CGFLOAT_MIN;
        } break;
    }
}

#pragma mark all delegate
// MARK: 10个功能区点击
- (void)HomePageFunctionCell:(HomePageFunctionCell *)cell didSelectFunctiomItemWith:(HomepageDataMenuDataModel *)functionItemModel {
    NSLog(@"10个功能区点击");
}

// MARK: 倒计时更多按钮被点击
- (void)HomePageSecondKillTimeCell:(HomePageSecondKillTimeCell *)cell didClickMoreButton:(HomepageDataSecondKillModel *)secondKillModel {
    NSLog(@"倒计时更多按钮被点击");
}

// MARK: 倒计时商品 item 被点击
- (void)HomePageSecondKillGoodsCell:(HomePageSecondKillGoodsCell *)cell didSelectGoodsItemWith:(HomepageDataSecondKillGoodsModel *)secondKillGoodsModel {
    NSLog(@" 倒计时商品 item 被点击");
}

// MARK: picturerew 图片点击
- (void)HomePagePicturewCell:(HomePagePicturewCell *)cell didSelectPicturerwItemWith:(HomepageDataMenuDataModel *)functionItemModel {
    NSLog(@"picturerew 图片点击");
}

// MARK: 吃货联盟商品点击了整个商品事件
- (void)HomePageFoodieGoodsCell:(HomePageFoodieGoodsCell *)cell didSelectItemWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel {
    NSLog(@"吃货联盟商品点击了整个商品事件");
}

// MARK: 吃货联盟点击了购物车事件
- (void)HomePageFoodieGoodsCell:(HomePageFoodieGoodsCell *)cell didSelectShoppingCartWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel {
    NSLog(@"吃货联盟点击了购物车事件");
}

// MARK: 猜你喜欢商品点击了购物车按钮
- (void)HomePageFoodieGoodsDetailCell:(HomePageFoodieGoodsDetailCell *)cell didSelectShoppingCartButtonWithGuessLickModel:(HomepageDataGuessYouLikeGoodsDataModel *)guessLikeModel {
    NSLog(@"猜你喜欢商品点击了购物车按钮");
}












#pragma mark - 懒加载
- (UICollectionView *)homeCollectionView {
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _homeCollectionView.backgroundColor = KTableBackgroundColor;
        // 注册10个功能cell
        [_homeCollectionView registerClass:[HomePageFunctionCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageFunctionCell class])];
        // 注册一个通用Cell
        [_homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        // 注册热点Cell
        [_homeCollectionView registerClass:[HomePageHotSpotCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageHotSpotCell class])];
        // 秒杀倒计时Cell
        [_homeCollectionView registerClass:[HomePageSecondKillTimeCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillTimeCell class])];
        // 秒杀商品Cell
        [_homeCollectionView registerClass:[HomePageSecondKillGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillGoodsCell class])];
        // 单独显示图片的cell
        [_homeCollectionView registerClass:[HomePagePicturewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePagePicturewCell class])];
        // 显示商品的cell
        [_homeCollectionView registerClass:[HomePageFoodieGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageFoodieGoodsCell class])];
        // 猜你喜欢的商品cell
        [_homeCollectionView registerClass:[HomePageFoodieGoodsDetailCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageFoodieGoodsDetailCell class])];
        _homeCollectionView.dataSource = self;
        _homeCollectionView.delegate = self;
    }
    return _homeCollectionView;
}

- (NSArray *)homePlateTypeArray {
    if (!_homePlateTypeArray) {
        // 把功能按顺序放在数组里面
        _homePlateTypeArray = @[@(HomePageStyle_banner),@(HomePageStyle_function1),@(HomePageStyle_function2),
                                @(HomePageStyle_hotSport),@(HomePageStyle_picturew),
                                @(HomePageStyle_secondKill_time),@(HomePageStyle_secondKill_goods),
                                @(HomePageStyle_foodie),@(HomePageStyle_foodie_goods),
                                @(HomePageStyle_skincare),@(HomePageStyle_skincare_goods),
                                @(HomePageStyle_merryTime),@(HomePageStyle_merryTime_goods),
                                @(HomePageStyle_settledown),@(HomePageStyle_settledown_goods),
                                @(HomePageStyle_burble),@(HomePageStyle_burble_goods),
                                @(HomePageStyle_bodybuilding),@(HomePageStyle_bodybuilding_goods),
                                @(HomePageStyle_guesslike),@(HomePageStyle_guesslike_goods)];
        // 或者把数组里面放模型
        //_homePlateTypeArray = @[@{@"platType":@(HomePageStyle_banner)},@{@"platType":@(HomePageStyle_function)}];
    }
    return _homePlateTypeArray;
}

- (SDCycleScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 146*KScreenRatio) delegate:self placeholderImage:nil];
        _bannerScrollView.backgroundColor = self.homeCollectionView.backgroundColor;;
    }
    return _bannerScrollView;
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
