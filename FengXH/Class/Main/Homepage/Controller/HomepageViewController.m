//
//  HomepageViewController.m
//  FengXH
//
//  Created by sun on 2018/10/11.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "HomepageViewController.h"
#import "HomepageResultModel.h"//首页数据模型
#import "SDCycleScrollView.h" // banner，随便找了一个
#import "HomePageLikeHeaderView.h"//猜你喜欢头视图
#import "HomePageSearchCell.h"//搜索框 cell
#import "HomePageFunctionCell.h"//10个功能区 cell
#import "HomePageHotSpotCell.h"//热点 cell
#import "HomePagePicturewCell.h"//店主专区等 cell
#import "HomePageSecondKillCell.h"//今日秒杀 cell
#import "HomePageCategoryCell.h"//几大分类商品的 cell

#import "WebJumpViewController.h"//网页控制器
#import "SpellBarViewController.h"//拼团
#import "JingDongViewController.h"//京东优选
#import "FreshViewController.h"//生鲜超市
#import "GoodsDetailViewController.h"//商品详情
#import "GoodsListViewController.h"//全部商品
#import "IntegralBaseViewController.h"//积分商城
#import "SecondsKillViewController.h"//今日秒杀
#import "PhoneViewController.h"//云电话
#import "ArticleListBaseViewController.h"//赏金文章
#import "SignInViewController.h"//签到领奖
#import "PromotionPosterViewController.h"//推广海报
#import "UnionMerchantViewController.h"//商户爆款


// 首页板块类型
typedef NS_ENUM(NSInteger , HomePageStyle) {
    /// 搜索 cell
    HomePageStyle_search = 0 ,
    /// banner板块
    HomePageStyle_banner ,
    /// 10个按钮板块
    HomePageStyle_function ,
    /// 热点
    HomePageStyle_hotSport ,
    /// 店主礼包、京东优选、店主专区
    HomePageStyle_picturew ,
    /// 整点秒杀
    HomePageStyle_secondKill ,
    /// 推荐商品
    HomePageStyle_recommendGoods ,
    /// 猜你喜欢
    HomePageStyle_guessYouLike ,
};

@interface HomepageViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,SDCycleScrollViewDelegate,HomePageFunctionDelegate,HomePagePicturewDelegate,HomePageSecondKillCellDelegate,HomePageCategoryCellDelegate,HomePageCategoryGoodsCellDelegate>

/** 首页Collectionview */
@property(nonatomic , strong)UICollectionView *homeCollectionView ;
/** 首页板块个数，由这个数字来控制板块数量和类型，可随意调换位置，方便后期维护 */
@property(nonatomic , strong)NSArray *homePlateTypeArray ;
/** 轮播控件 */
@property(nonatomic , strong)SDCycleScrollView *bannerScrollView;
/** 滚动广告的图片数组 */
@property(nonatomic , strong)NSMutableArray *bannerImageArray;
/** model */
@property(nonatomic , strong)HomepageResultModel *resultModel;

@end

@implementation HomepageViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"疯享汇全球优选商城";
    
    [self.view addSubview:self.homeCollectionView];
    [self homepageDataRequest];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"调试" forState:UIControlStateNormal];
//    [btn setFrame:CGRectMake(KMAINSIZE.width-50, 0, 44, 44)];
//    [btn setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
//    [btn.titleLabel setFont:KFont(14)];
//    [self.navigationController.navigationBar addSubview:btn];
//    [btn addTarget:self action:@selector(newGoodsDetailVC) forControlEvents:UIControlEventTouchUpInside];
}

//#pragma mark - 测试
//- (void)newGoodsDetailVC {
//    NPhoneLoginViewController *VC = [[NPhoneLoginViewController alloc] init];
//    VC.loginSuccessBlock = ^{
//        NSLog(@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈");
//    };
//    [self presentViewController:VC animated:YES completion:nil];
//}

#pragma mark - 首页数据请求
- (void)homepageDataRequest {
    NSString * urlString = @"r=apply.appIos";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.homeCollectionView.mj_header.isRefreshing == YES) {
            [self.homeCollectionView.mj_header endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            self.resultModel = [HomepageResultModel yy_modelWithDictionary:responseDic[@"result"]];
            //滚动广告图片数组
            self.bannerImageArray = [NSMutableArray array];
            if ([self.resultModel.banner count] > 0) {
                for (HomepageResultPictureModel *pictureModel in self.resultModel.banner) {
                    [self.bannerImageArray addObject:pictureModel.imgurl];
                }
            }
            [self.homeCollectionView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.homeCollectionView.mj_header.isRefreshing == YES) {
            [self.homeCollectionView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - collectionView
- (UICollectionView *)homeCollectionView {
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout *_customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) collectionViewLayout:_customLayout];
        _homeCollectionView.backgroundColor = KTableBackgroundColor;
        _homeCollectionView.delegate = self;
        _homeCollectionView.dataSource = self;
        _homeCollectionView.showsVerticalScrollIndicator = NO;
        _homeCollectionView.alwaysBounceVertical = YES;
        [_homeCollectionView registerClass:[HomePageLikeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HomePageLikeHeaderView class])];
        [_homeCollectionView registerClass:[HomePageSearchCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageSearchCell class])];
        [_homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageBannerCellID"];
        [_homeCollectionView registerClass:[HomePageFunctionCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageFunctionCell class])];
        [_homeCollectionView registerClass:[HomePageHotSpotCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageHotSpotCell class])];
        [_homeCollectionView registerClass:[HomePagePicturewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePagePicturewCell class])];
        [_homeCollectionView registerClass:[HomePageSecondKillCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillCell class])];
        [_homeCollectionView registerClass:[HomePageCategoryCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageCategoryCell class])];
        [_homeCollectionView registerClass:[HomePageCategoryGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageCategoryGoodsCell class])];
        [_homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        _homeCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    return _homeCollectionView;
}

#pragma mark - 刷新
- (void)refresh {
    [self homepageDataRequest];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homePlateTypeArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_search: {
            return 1;
        } break;
        case HomePageStyle_banner: {
            if (self.bannerImageArray.count) {
                return 1;
            }
        } break;
        case HomePageStyle_function: {
            if (self.resultModel.menu.count) {
                return 1;
            }
        } break;
        case HomePageStyle_hotSport: {
            if (self.resultModel.notice) {
                return 1;
            }
        } break;
        case HomePageStyle_picturew: {
            if (self.resultModel.picturew.count) {
                return 1;
            }
        } break;
        case HomePageStyle_secondKill: {
            if (self.resultModel.seckillgroup) {
                return 1;
            }
        } break;
        case HomePageStyle_recommendGoods: {
            if (self.resultModel.goods.count) {
                return self.resultModel.goods.count;
            }
        } break;
        case HomePageStyle_guessYouLike: {
            return self.resultModel.like.list.count;
        } break;
        default: {
            return 0;
        } break;
    }
    return 0;
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    CGFloat collectionViewWidth = collectionView.frame.size.width;
    switch (style) {
        case HomePageStyle_search: {
            return CGSizeMake(collectionViewWidth, 45);
        } break;
        case HomePageStyle_banner: {
            if (self.bannerImageArray) {
                return CGSizeMake(collectionViewWidth, 146 * KScreenRatio);
            } return CGSizeZero;
        } break;
        case HomePageStyle_function: {
            if (self.resultModel.menu) {
                return CGSizeMake(collectionViewWidth, 200);
            } return CGSizeZero;
        } break;
        case HomePageStyle_hotSport: {
            if (self.resultModel.notice) {
                return CGSizeMake(collectionViewWidth, 40);
            } return CGSizeZero;
        } break;
        case HomePageStyle_picturew: {
            if (self.resultModel.picturew) {
                return CGSizeMake(collectionViewWidth, 180*KScreenRatio);
            } return CGSizeZero;
        } break;
        case HomePageStyle_secondKill: {
            if (self.resultModel.seckillgroup) {
                return CGSizeMake(collectionViewWidth, 170);
            } return CGSizeZero;
        } break;
        case HomePageStyle_recommendGoods: {
            if ([self.resultModel.goods count] > 0) {
                return CGSizeMake(collectionViewWidth, 100*KScreenRatio + 125*KScreenRatio + 90);
            } return CGSizeZero;
        } break;
        case HomePageStyle_guessYouLike: {
            return CGSizeMake((collectionViewWidth - 10.0) / 3.0, (collectionViewWidth - 10.0) / 3.0 + 90);
        } break;
            
        default: {
            return CGSizeZero;
        } break;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guessYouLike: {
            return UIEdgeInsetsMake(5, 0, 5, 0);
        } break;
        default: {
            return UIEdgeInsetsZero;
        } break;
    }
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guessYouLike: {
            return 5.0;
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
    HomePageStyle style = [self.homePlateTypeArray[section] integerValue];
    switch (style) {
        case HomePageStyle_guessYouLike: {
            if ([self.resultModel.like.picture firstObject]) {
                return CGSizeMake(KMAINSIZE.width, 45);
            } return CGSizeZero;
        } break;
        default: {
            return CGSizeZero;
        } break;
    }
}

#pragma mark - 指定头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
        switch (style) {
            case HomePageStyle_guessYouLike: {
                HomePageLikeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HomePageLikeHeaderView class]) forIndexPath:indexPath];
                if ([self.resultModel.like.picture count] > 0) {
                    headerView.pictureModel = [self.resultModel.like.picture firstObject];
                }
                return headerView;
            } break;
            default:
                break;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    switch (style) {
        case HomePageStyle_search: {
            HomePageSearchCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageSearchCell class]) forIndexPath:indexPath];
            return cell;
        } break;
        case HomePageStyle_banner: {
            if (self.bannerImageArray) {
                UICollectionViewCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageBannerCellID" forIndexPath:indexPath];
                self.bannerScrollView.imageURLStringsGroup = self.bannerImageArray;
                [bannerCell.contentView addSubview:self.bannerScrollView];
                return bannerCell;
            }
        } break;
        case HomePageStyle_function: {
            if (self.resultModel.menu) {
                HomePageFunctionCell *functionCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageFunctionCell class]) forIndexPath:indexPath];
                functionCell.delegate = self;
                return functionCell;
            }
        } break;
        case HomePageStyle_hotSport: {
            if (self.resultModel.notice) {
                HomePageHotSpotCell * hotSpotCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageHotSpotCell class]) forIndexPath:indexPath];
                return hotSpotCell;
            }
        } break;
        case HomePageStyle_picturew: {
            if (self.resultModel.picturew) {
                HomePagePicturewCell *picturewCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePagePicturewCell class]) forIndexPath:indexPath];
                picturewCell.delegate = self;
                return picturewCell;
            }
        } break;
        case HomePageStyle_secondKill: {
            if (self.resultModel.seckillgroup) {
                HomePageSecondKillCell *secKillCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillCell class]) forIndexPath:indexPath];
                secKillCell.delegate = self;
                return secKillCell;
            }
        } break;
        case HomePageStyle_recommendGoods: {
            if ([self.resultModel.goods count] > 0) {
                HomePageCategoryCell *categoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageCategoryCell class]) forIndexPath:indexPath];
                categoryCell.delegate = self;
                return categoryCell;
            }
        } break;
        case HomePageStyle_guessYouLike: {
            if ([self.resultModel.like.list count] > 0) {
                HomePageCategoryGoodsCell *likeCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageCategoryGoodsCell class]) forIndexPath:indexPath];
                likeCell.delegate = self;
                return likeCell;
            }
        } break;
            
        default:
            break;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    switch (style) {
        case HomePageStyle_search: {
            HomePageSearchCell * searchCell = (HomePageSearchCell *)cell;
            searchCell.searchTextField.delegate = self;
        } break;
        case HomePageStyle_function: {
            HomePageFunctionCell *functionCell = (HomePageFunctionCell *)cell;
            if (self.resultModel.menu) {
                functionCell.menuDataArray = self.resultModel.menu;
            }
        } break;
        case HomePageStyle_hotSport: {
            HomePageHotSpotCell * hotSpotCell = (HomePageHotSpotCell *)cell;
            if (self.resultModel.notice) {
                hotSpotCell.noticeDataModel = self.resultModel.notice;
            }
        } break;
        case HomePageStyle_picturew: {
            HomePagePicturewCell * picturCell = (HomePagePicturewCell *)cell;
            if (self.resultModel.picturew) {
                picturCell.pictureArray = self.resultModel.picturew;
            }
        } break;
        case HomePageStyle_secondKill: {
            HomePageSecondKillCell *secKillCell = (HomePageSecondKillCell *)cell;
            if (self.resultModel.seckillgroup) {
                secKillCell.secondKillModel = self.resultModel.seckillgroup;
            }
        } break;
        case HomePageStyle_recommendGoods: {
            HomePageCategoryCell *categoryCell = (HomePageCategoryCell *)cell;
            if ([self.resultModel.goods count] > 0) {
                categoryCell.resultGoodsModel = self.resultModel.goods[indexPath.item];
            }
        } break;
        case HomePageStyle_guessYouLike: {
            HomePageCategoryGoodsCell *likeCell = (HomePageCategoryGoodsCell *)cell;
            if ([self.resultModel.like.list count]) {
                likeCell.categoryGoodsModel = self.resultModel.like.list[indexPath.item];
            }
        } break;
            
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageStyle style = [self.homePlateTypeArray[indexPath.section] integerValue];
    switch (style) {
        case HomePageStyle_guessYouLike: {
            HomepageResultCommodityModel *commodityModel = self.resultModel.like.list[indexPath.item];
            GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            VC.goodsID = commodityModel.goodsID;
            [self.navigationController pushViewController:VC animated:YES];
        } break;
            
        default:
            break;
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    if (textField.text.length > 0) {
        GoodsListViewController *listVC = [[GoodsListViewController alloc] init];
        listVC.searchKeywords = textField.text;
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:YES];
    } else {
        [DBHUD ShowInView:self.view withTitle:@"请输入搜索关键词"];
    }
    return YES;
}

#pragma mark - 今日秒杀更多按钮被点击
- (void)HomePageSecondKillCell:(HomePageSecondKillCell *)cell didClickMoreButton:(HomepageResultSeckillgroupModel *)secondKillModel {
    SecondsKillViewController *vc = [[SecondsKillViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 今日秒杀商品被选择
- (void)HomePageSecondKillCell:(HomePageSecondKillCell *)cell didSelectGoodsItemWith:(HomepageResultCommodityModel *)secondKillGoodsModel {
    SecondsKillViewController *vc = [[SecondsKillViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 分类商品被点击
- (void)HomePageCategoryCell:(HomePageCategoryCell *)cell didSelectGoodsItemWith:(HomepageResultCommodityModel *)goodsDataModel {
    GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.goodsID = goodsDataModel.goodsID;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 猜你喜欢购物车按钮被点击
- (void)HomePageCategoryGoodsCell:(HomePageCategoryGoodsCell *)cell didSelectShoppingCartWith:(HomepageResultCommodityModel *)goodsDataModel {
    GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.goodsID = goodsDataModel.goodsID;
    [self.navigationController pushViewController:VC animated:YES];
}


// MARK: picturerew 图片点击
- (void)HomePagePicturewCell:(HomePagePicturewCell *)cell didSelectPicturerwItemWith:(HomepageResultPictureModel *)functionItemModel {
    NSString *jumpURLString = [functionItemModel.linkurl stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/ttp://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@""];
    if ([jumpURLString isEqualToString:@"35"]) {
        //店主专区
        NSString *jumpURLString = [functionItemModel.linkurl stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/ttp://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id="];
        FreshViewController *vc = [[FreshViewController alloc]init];
        vc.urlStr = jumpURLString;
        vc.typeColor = @"red";
        vc.title = @"店主专区";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([jumpURLString isEqualToString:@"139"]) {
        //京东优选
        NSString *urlStr = [functionItemModel.linkurl stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/ttp://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id="];
        JingDongViewController *vc = [[JingDongViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.urlStr = urlStr;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([jumpURLString isEqualToString:@"https://xyk.richwealth.cn/apply/banklist/sign/79aa96b9be292b0c/extra/1000000438"]) {
        //生活服务
        WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
        webVC.jumpURL = jumpURLString;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    } else if ([jumpURLString isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=commission.qrcode"]) {
        PromotionPosterViewController * VC = [[PromotionPosterViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([jumpURLString isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=395"]) {
        UnionMerchantViewController *VC = [[UnionMerchantViewController alloc] init];
        VC.requestURL = jumpURLString;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        //[DBHUD ShowInView:self.view withTitle:@"暂未开通"];
    }
}

#pragma mark all delegate
// MARK: 10个功能区点击
- (void)HomePageFunctionCell:(HomePageFunctionCell *)cell didSelectFunctiomItemWith:(HomepageResultPictureModel *)functionItemModel {
    HomePageFunctionJumpType jumpType = [ShareManager getHomePageFunctionJumpTypeWithMenuDataModel:functionItemModel];
    switch (jumpType) {
        case FunctionJumpWebView: {
            /** 跳转至网页 */
            WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
            webVC.jumpURL = functionItemModel.linkurl;
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        case FunctionJumpAllGoods: {
            /** 跳转至全部商品页 */
            GoodsListViewController *vc = [[GoodsListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.categatoryId = functionItemModel.linkurl;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case FunctionJumpSecondKill: {
            /** 跳转今日秒杀 */
            SecondsKillViewController *vc = [[SecondsKillViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case FunctionJumpSpellGroup: {
            /** 跳转至拼团福利 */
            SpellBarViewController *spellGroupVC = [[SpellBarViewController alloc]init];
            spellGroupVC.hidesBottomBarWhenPushed = YES;
            self.navigationController.navigationBar.hidden = YES;
            [self.navigationController pushViewController:spellGroupVC animated:NO];
            
        } break;
        case FunctionJumpCloudPhone: {
            /** 跳转至云电话 */
            PhoneViewController *vc = [[PhoneViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case FunctionJumpArticleList: {
            /** 跳转至赏金文章 */
            ArticleListBaseViewController *articleVC = [[ArticleListBaseViewController alloc] init];
            articleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:articleVC animated:YES];
        } break;
        case FunctionJumpBusiness: {
            /**  联盟商户 - 跳转至浏览器 */
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:functionItemModel.linkurl]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:functionItemModel.linkurl]];
            }
        } break;
        case FunctionJumpSignIn: {
            /** 签到领奖 */
            if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                SignInViewController *VC = [[SignInViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                [self presentLoginViewControllerWithSuccessBlock:^{
                } WithFailureBlock:^{
                }];
            }
        } break;
        case FunctionJumpShareCircle: {
            /** 分享圈子 */
            WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
            webVC.jumpURL = [NSString stringWithFormat:@"%@&footerMenus=1",functionItemModel.linkurl];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        case IntegralExchange: {
            /** 积分兑换 */
            if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                IntegralBaseViewController *VC = [[IntegralBaseViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                [self presentLoginViewControllerWithSuccessBlock:^{
                } WithFailureBlock:^{
                }];
            }
        } break;
        case AllCategoryGoods: {
            [self.tabBarController setSelectedIndex:1];
        } break;
        default:
            break;
    }
}

#pragma mark - 轮播图被点击
- (void)bannerItemDidClicked:(NSInteger)index {
    [self.view endEditing:YES];
    
    HomepageResultPictureModel *bannerModel = self.resultModel.banner[index];
    HomePageBannerJumpType jumpStyle = [ShareManager getHomePageBannerJumpTypeWithBannerDataModel:bannerModel];
    switch (jumpStyle) {
        case BannerJumpWebView: {
            WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
            webVC.jumpURL = bannerModel.linkurl;
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        case BannerJumpSpellGroup: {
            
            SpellBarViewController *spellGroupVC = [[SpellBarViewController alloc]init];
            spellGroupVC.hidesBottomBarWhenPushed = YES;
            self.navigationController.navigationBar.hidden = YES;
            [self.navigationController pushViewController:spellGroupVC animated:NO];
            
        } break;
        case BannerJumpFreshSupermarket: {
            NSString *jumpURLString = [bannerModel.linkurl stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id="];
            FreshViewController *vc = [[FreshViewController alloc]init];
            vc.urlStr = jumpURLString;
            vc.typeColor = @"blue";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case BannerJumpJingDongOptimization: {
            NSString *jumpURLString = [bannerModel.linkurl stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id="];
            JingDongViewController *vc = [[JingDongViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.urlStr = jumpURLString;
            [self.navigationController pushViewController:vc animated:YES];
            
        } break;
        case BannerJumpGoodsDetails: {
            NSString *jumpURLString = [bannerModel.linkurl stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=goods.detail&id=" withString:@""];
            GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            VC.goodsID = jumpURLString;
            [self.navigationController pushViewController:VC animated:YES];
        } break;
        case BannerJumpExchangeStore: {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                IntegralBaseViewController *VC = [[IntegralBaseViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                [self presentLoginViewControllerWithSuccessBlock:^{
                } WithFailureBlock:^{
                }];
            }
        } break;
        default:
            break;
    }
}

/** 把功能按顺序放在数组里面 */
- (NSArray *)homePlateTypeArray {
    if (!_homePlateTypeArray) {
        _homePlateTypeArray = @[@(HomePageStyle_search),
                                @(HomePageStyle_banner),
                                @(HomePageStyle_function),
                                @(HomePageStyle_hotSport),
                                @(HomePageStyle_picturew),
                                @(HomePageStyle_secondKill),
                                @(HomePageStyle_recommendGoods),
                                @(HomePageStyle_guessYouLike)];
        // 或者把数组里面放模型
        //_homePlateTypeArray = @[@{@"platType":@(HomePageStyle_banner)},@{@"platType":@(HomePageStyle_function)}];
    }
    return _homePlateTypeArray;
}

- (SDCycleScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 146*KScreenRatio) delegate:self placeholderImage:nil];
        _bannerScrollView.backgroundColor = self.homeCollectionView.backgroundColor;
        MJWeakSelf
        [_bannerScrollView setClickItemOperationBlock:^(NSInteger currentIndex) {
            [weakSelf bannerItemDidClicked:currentIndex];
        }];
    }
    return _bannerScrollView;
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
