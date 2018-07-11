//
//  HomepageViewController.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageViewController.h"
#import "HomepageFirstCell.h"
#import "SXScrPageView.h"
#import "HomepageThirdCell.h"
#import "HomepageFourthCell.h"
#import "HomepageFifthCell.h"
#import "HomepageSixthCell.h"
#import "HomepageSeventhView.h"
#import "HomepageEighthCell.h"
#import "HomepageNinthView.h"
#import "HomepageTenthCell.h"
#import "HomepageDataModel.h"
#import "HomepageBannerJumpViewController.h"

@interface HomepageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic , strong)UICollectionViewFlowLayout *customLayout;
@property(nonatomic , strong)UICollectionView *homeCollectionView;
/** 数据模型 */
@property(nonatomic , strong)HomepageDataModel *dataModel;
/** 滚动广告的图片数组 */
@property(nonatomic , strong)NSMutableArray *bannerImageArray;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"疯享汇全球优选商城";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self homepageDateRequest];
    
    //添加 collectionView
    [self.view addSubview:self.homeCollectionView];
}

#pragma mark - collectionView
- (UICollectionView *)homeCollectionView {
    if (!_homeCollectionView) {
        _customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) collectionViewLayout:_customLayout];
        _homeCollectionView.backgroundColor = KTableBackgroundColor;
        _homeCollectionView.delegate = self;
        _homeCollectionView.dataSource = self;
        _homeCollectionView.showsVerticalScrollIndicator = NO;
        _homeCollectionView.alwaysBounceVertical = YES;
        _homeCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _homeCollectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 23;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==22) {
        return 8;
    } return 1;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        //搜索框
        return (CGSize){KMAINSIZE.width, 48};
    } else if (indexPath.section==1) {
        //滚动广告
        return (CGSize){KMAINSIZE.width, 146*KScreenRatio};
    } else if (indexPath.section==2) {
        //10个专区-1
        if ([self.dataModel.M1471835886075.data count] > 0) {
            return (CGSize){KMAINSIZE.width, ([self.dataModel.M1471835886075.data count]/5)*100};
        } return (CGSize){KMAINSIZE.width, CGFLOAT_MIN};
    }  else if (indexPath.section==3) {
        //10个专区-2
        if ([self.dataModel.M1471835886075.data count] > 0) {
            return (CGSize){KMAINSIZE.width, ([self.dataModel.M1529474107640.data count]/5)*100};
        } return (CGSize){KMAINSIZE.width, CGFLOAT_MIN};
    } else if (indexPath.section==4) {
        //热点
        return (CGSize){KMAINSIZE.width, 40};
    } else if (indexPath.section==5) {
        //店主礼包、京东优选、店主专区
        return (CGSize){KMAINSIZE.width, 160*KScreenRatio};
    } else if (indexPath.section==6) {
        //整点秒杀倒计时
        return (CGSize){KMAINSIZE.width, 40};
    } else if (indexPath.section==7) {
        //整点秒杀商品
        return (CGSize){KMAINSIZE.width, 130};
    } else if (indexPath.section==8) {
        //类目精选图片
        return (CGSize){KMAINSIZE.width, 60};
    } else if (indexPath.section==9) {
        //吃货联盟图片
        return (CGSize){KMAINSIZE.width, 147*KScreenRatio};
    } else if (indexPath.section==10) {
        //吃货联盟商品
        return (CGSize){KMAINSIZE.width, 227*KScreenRatio};
    } else if (indexPath.section==11) {
        //爱在护肤图片
        return (CGSize){KMAINSIZE.width, 147*KScreenRatio};
    } else if (indexPath.section==12) {
        //爱在护肤商品
        return (CGSize){KMAINSIZE.width, 227*KScreenRatio};
    } else if (indexPath.section==13) {
        //美时美刻图片
        return (CGSize){KMAINSIZE.width, 147*KScreenRatio};
    } else if (indexPath.section==14) {
        //美时美刻商品
        return (CGSize){KMAINSIZE.width, 227*KScreenRatio};
    } else if (indexPath.section==15) {
        //安家落户图片
        return (CGSize){KMAINSIZE.width, 147*KScreenRatio};
    } else if (indexPath.section==16) {
        //安家落户商品
        return (CGSize){KMAINSIZE.width, 227*KScreenRatio};
    } else if (indexPath.section==17) {
        //咿呀学语图片
        return (CGSize){KMAINSIZE.width, 147*KScreenRatio};
    } else if (indexPath.section==18) {
        //咿呀学语商品
        return (CGSize){KMAINSIZE.width, 227*KScreenRatio};
    } else if (indexPath.section==19) {
        //强身健体图片
        return (CGSize){KMAINSIZE.width, 147*KScreenRatio};
    } else if (indexPath.section==20) {
        //强身健体商品
        return (CGSize){KMAINSIZE.width, 227*KScreenRatio};
    } else if (indexPath.section==21) {
        //猜你喜欢图片
        return (CGSize){KMAINSIZE.width, 45};
    } else if (indexPath.section==22) {
        //猜你喜欢的商品
        return (CGSize){(KMAINSIZE.width-20)/3, 207*KScreenRatio};
    }
    return (CGSize){KMAINSIZE.width, CGFLOAT_MIN};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==22) {
        //猜你喜欢商品
        return UIEdgeInsetsMake(5, 5, 5, 5);
    } return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==22) {
        //猜你喜欢商品
        return 5;
    } return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

#pragma mark - sectionHeader 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (CGSize){KMAINSIZE.width, CGFLOAT_MIN};
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        //搜索框
        [collectionView registerClass:[HomepageFirstCell class] forCellWithReuseIdentifier:@"HomepageFirstCellID"];
        HomepageFirstCell *firstCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageFirstCellID" forIndexPath:indexPath];
        return firstCell;
    } else if (indexPath.section==1) {
        //滚动广告
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomePageSecondCellID"];
        UICollectionViewCell * secondCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageSecondCellID" forIndexPath:indexPath];
        return secondCell;
    } else if (indexPath.section==2) {
        //10个专区-1
        [collectionView registerClass:[HomepageThirdCell class] forCellWithReuseIdentifier:@"HomePageThirdCellID"];
        HomepageThirdCell * thirdCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageThirdCellID" forIndexPath:indexPath];
        return thirdCell;
    } else if (indexPath.section==3) {
        //10个专区-2
        [collectionView registerClass:[HomepageThirdCell class] forCellWithReuseIdentifier:@"HomePageThirdSecCellID"];
        HomepageThirdCell * thirdSecCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageThirdSecCellID" forIndexPath:indexPath];
        return thirdSecCell;
    } else if (indexPath.section==4) {
        //热点
        [collectionView registerClass:[HomepageFourthCell class] forCellWithReuseIdentifier:@"HomepageFourthCellID"];
        HomepageFourthCell * fourthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageFourthCellID" forIndexPath:indexPath];
        return fourthCell;
    } else if (indexPath.section==5) {
        //店主礼包、京东优选、店主专区
        [collectionView registerClass:[HomepageFifthCell class] forCellWithReuseIdentifier:@"HomepageFifthCellID"];
        HomepageFifthCell * fifthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageFifthCellID" forIndexPath:indexPath];
        return fifthCell;
    } else if (indexPath.section==6) {
        //整点秒杀倒计时
        [collectionView registerClass:[HomepageSixthCell class] forCellWithReuseIdentifier:@"HomepageSixthCellID"];
        HomepageSixthCell * sixthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageSixthCellID" forIndexPath:indexPath];
        return sixthCell;
    } else if (indexPath.section==7) {
        //整点秒杀商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageSeventhCellID"];
        UICollectionViewCell * seventhCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageSeventhCellID" forIndexPath:indexPath];
        return seventhCell;
    } else if (indexPath.section==8) {
        //类目精选图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageEighthCellID"];
        HomepageEighthCell * eighthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageEighthCellID" forIndexPath:indexPath];
        return eighthCell;
    } else if (indexPath.section==9) {
        //吃货联盟图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageNinthCellID"];
        HomepageEighthCell * ninthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageNinthCellID" forIndexPath:indexPath];
        return ninthCell;
    } else if (indexPath.section==10) {
        //吃货联盟商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageTenthCellID"];
        UICollectionViewCell * tenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageTenthCellID" forIndexPath:indexPath];
        return tenthCell;
    } else if (indexPath.section==11) {
        //爱在护肤图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageEleventhCellID"];
        HomepageEighthCell * eleventhCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageEleventhCellID" forIndexPath:indexPath];
        return eleventhCell;
    } else if (indexPath.section==12) {
        //爱在护肤商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageTwelfthCellID"];
        UICollectionViewCell * twelfthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageTwelfthCellID" forIndexPath:indexPath];
        return twelfthCell;
    } else if (indexPath.section==13) {
        //美时美刻图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageThirteenthCellID"];
        HomepageEighthCell * thirteenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageThirteenthCellID" forIndexPath:indexPath];
        return thirteenthCell;
    } else if (indexPath.section==14) {
        //美时美刻商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageFourteenthCellID"];
        UICollectionViewCell * fourteenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageFourteenthCellID" forIndexPath:indexPath];
        return fourteenthCell;
    } else if (indexPath.section==15) {
        //安家落户图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageFifteenthCellID"];
        HomepageEighthCell * fifteenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageFifteenthCellID" forIndexPath:indexPath];
        return fifteenthCell;
    } else if (indexPath.section==16) {
        //安家落户商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageSixteenthCellID"];
        UICollectionViewCell * sixteenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageSixteenthCellID" forIndexPath:indexPath];
        return sixteenthCell;
    } else if (indexPath.section==17) {
        //咿呀学语图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageSeventeenthCellID"];
        HomepageEighthCell * seventeenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageSeventeenthCellID" forIndexPath:indexPath];
        return seventeenthCell;
    } else if (indexPath.section==18) {
        //咿呀学语商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageEighteenthCellID"];
        UICollectionViewCell * eighteenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageEighteenthCellID" forIndexPath:indexPath];
        return eighteenthCell;
    } else if (indexPath.section==19) {
        //强身健体图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepageNinteenthCellID"];
        HomepageEighthCell * ninteenthCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageNinteenthCellID" forIndexPath:indexPath];
        return ninteenthCell;
    } else if (indexPath.section==20) {
        //强身健体商品
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageTwentiethCellID"];
        UICollectionViewCell * twentiethCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageTwentiethCellID" forIndexPath:indexPath];
        return twentiethCell;
    } else if (indexPath.section==21) {
        //猜你喜欢图片
        [collectionView registerClass:[HomepageEighthCell class] forCellWithReuseIdentifier:@"HomepagetwentyFirstCellID"];
        HomepageEighthCell * twentyFirstCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepagetwentyFirstCellID" forIndexPath:indexPath];
        return twentyFirstCell;
    } else if (indexPath.section==22) {
        //猜你喜欢商品
        [collectionView registerClass:[HomepageTenthCell class] forCellWithReuseIdentifier:@"HomepagetwentySecondCellID"];
        HomepageTenthCell * twentySecondCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepagetwentySecondCellID" forIndexPath:indexPath];
        return twentySecondCell;
    }
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomepageGuessCellID"];
    UICollectionViewCell *guessCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageGuessCellID" forIndexPath:indexPath];
    return guessCell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    MJWeakSelf
    if (indexPath.section==1) {
        //滚动广告
        if (_bannerImageArray) {
            UICollectionViewCell * secondCell = (UICollectionViewCell *)cell;
            SXScrPageView * sxView =   [SXScrPageView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 146*KScreenRatio) ImageArr:_bannerImageArray AndImageClickBlock:^(NSInteger index) {
                [weakSelf bannerDidClicked:index];
            }];
            [secondCell.contentView addSubview:sxView];
        }
    } else if (indexPath.section==2) {
        //10个专区-1
        if ([self.dataModel.M1471835886075.data count] > 0) {
            HomepageThirdCell * thirdCell = (HomepageThirdCell *)cell;
            thirdCell.menuDataArray = self.dataModel.M1471835886075.data;
            thirdCell.thirdCellBlock = ^(NSInteger index) {
                [weakSelf menuFirstDidClicked:index];
            };
        }
    }  else if (indexPath.section==3) {
        //10个专区-2
        if ([self.dataModel.M1471835886075.data count] > 0) {
            HomepageThirdCell * thirdCell = (HomepageThirdCell *)cell;
            thirdCell.menuDataArray = self.dataModel.M1529474107640.data;
            thirdCell.thirdCellBlock = ^(NSInteger index) {
                [weakSelf menuSecondDidClicked:index];
            };
        }
    } else if (indexPath.section==4) {
        //热点图片
        HomepageFourthCell *fourthCell = (HomepageFourthCell *)cell;
        fourthCell.noticeDataModel = self.dataModel.M1482809676486.data;
    } else if (indexPath.section==5) {
        //热点内容
        HomepageFifthCell *fifthCell = (HomepageFifthCell *)cell;
        fifthCell.fifthCellBlock = ^(NSInteger index) {
            NSLog(@"%ld",index);
        };
    } else if (indexPath.section==6) {
        //整点秒杀倒计时
        HomepageSixthCell *sixthCell = (HomepageSixthCell *)cell;
        [sixthCell.countDownLabel setText:@"20点场  距开始10:30:43"];
        sixthCell.sixthCellBlock = ^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:@"更多..."];
        };
    } else if (indexPath.section==7) {
        //整点秒杀商品
        UICollectionViewCell *seventhCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageSeventhView *seventhView = [HomepageSeventhView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 130) GoodsInfoArray:goodsArray SeventhBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个",index]];
        }];
        [seventhCell.contentView addSubview:seventhView];
    } else if (indexPath.section==8) {
        //类目精选图片
        HomepageEighthCell *eighthCell = (HomepageEighthCell *)cell;
        eighthCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//05//b7ZP5aGq5117cqQksK1gk5QCa12Z86.png";
    } else if (indexPath.section==9) {
        //吃货联盟图片
        HomepageEighthCell *ninthCell = (HomepageEighthCell *)cell;
        ninthCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//aDPztDzGKkVVu7GavdkddAk7zG8wD4.png";
    } else if (indexPath.section==10) {
        //吃货联盟商品
        UICollectionViewCell *tenthCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageNinthView *tenthView = [HomepageNinthView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 227*KScreenRatio) GoodsInfoArray:goodsArray NinthBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",index]];
        } CartClickBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",index]];
        }];
        [tenthCell.contentView addSubview:tenthView];
    } else if (indexPath.section==11) {
        //爱在护肤图片
        HomepageEighthCell *eleventh = (HomepageEighthCell *)cell;
        eleventh.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//aDPztDzGKkVVu7GavdkddAk7zG8wD4.png";
    } else if (indexPath.section==12) {
        //爱在护肤商品
        UICollectionViewCell *twelfthCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageNinthView *twelfthView = [HomepageNinthView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 227*KScreenRatio) GoodsInfoArray:goodsArray NinthBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",index]];
        } CartClickBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",index]];
        }];
        [twelfthCell.contentView addSubview:twelfthView];
    } else if (indexPath.section==13) {
        //美时美刻图片
        HomepageEighthCell *thirteenthCell = (HomepageEighthCell *)cell;
        thirteenthCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//aDPztDzGKkVVu7GavdkddAk7zG8wD4.png";
    } else if (indexPath.section==14) {
        //美时美刻商品
        UICollectionViewCell *fourteenthCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageNinthView *fourteenthView = [HomepageNinthView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 227*KScreenRatio) GoodsInfoArray:goodsArray NinthBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",index]];
        } CartClickBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",index]];
        }];
        [fourteenthCell.contentView addSubview:fourteenthView];
    } else if (indexPath.section==15) {
        //安家落户图片
        HomepageEighthCell *fifteenthCell = (HomepageEighthCell *)cell;
        fifteenthCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//aDPztDzGKkVVu7GavdkddAk7zG8wD4.png";
    } else if (indexPath.section==16) {
        //安家落户商品
        UICollectionViewCell *sixteenthCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageNinthView *sixteenthView = [HomepageNinthView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 227*KScreenRatio) GoodsInfoArray:goodsArray NinthBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",index]];
        } CartClickBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",index]];
        }];
        [sixteenthCell.contentView addSubview:sixteenthView];
    } else if (indexPath.section==17) {
        //咿呀学语图片
        HomepageEighthCell *seventeenthCell = (HomepageEighthCell *)cell;
        seventeenthCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//aDPztDzGKkVVu7GavdkddAk7zG8wD4.png";
    } else if (indexPath.section==18) {
        //咿呀学语商品
        UICollectionViewCell *eighteenthCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageNinthView *eighteenthView = [HomepageNinthView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 227*KScreenRatio) GoodsInfoArray:goodsArray NinthBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",index]];
        } CartClickBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",index]];
        }];
        [eighteenthCell.contentView addSubview:eighteenthView];
    } else if (indexPath.section==19) {
        //强身健体图片
        HomepageEighthCell *ninteenthCell = (HomepageEighthCell *)cell;
        ninteenthCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//aDPztDzGKkVVu7GavdkddAk7zG8wD4.png";
    } else if (indexPath.section==20) {
        //强身健体商品
        UICollectionViewCell *twentiethCell = (UICollectionViewCell *)cell;
        NSArray *goodsArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        HomepageNinthView *twentiethView = [HomepageNinthView direcWithtFrame:CGRectMake(0, 0, KMAINSIZE.width, 227*KScreenRatio) GoodsInfoArray:goodsArray NinthBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",index]];
        } CartClickBlock:^(NSInteger index) {
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",index]];
        }];
        [twentiethCell.contentView addSubview:twentiethView];
    } else if (indexPath.section==21) {
        //猜你喜欢图片
        HomepageEighthCell *twentyFirstCell = (HomepageEighthCell *)cell;
        twentyFirstCell.pictureURL = @"https://img.vipfxh.com//images//7//2018//07//ZU4chI8fFfXH558XU45544592R3V58.jpg";
    } else if (indexPath.section==22) {
        HomepageTenthCell *twentySecondCell = (HomepageTenthCell *)cell;
        twentySecondCell.cellCartBlock = ^{
            [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个加入购物车",indexPath.item]];
        };
    }
}

#pragma mark - didSelectItemAtIndexPath
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==22) {
        [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"第%ld个被点击",indexPath.item]];
    }
}

#pragma mark - 滚动广告跳转
- (void)bannerDidClicked:(NSInteger)index {
    HomepageDataBannerDataModel *bannerModel = self.dataModel.M1471835880921.data[index];
    HomepageBannerJumpViewController *bannerJumpVC = [[HomepageBannerJumpViewController alloc] init];
    bannerJumpVC.jumpURL = bannerModel.linkurl;
    bannerJumpVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bannerJumpVC animated:YES];
}

#pragma mark - 10个专区-1 被点击
- (void)menuFirstDidClicked:(NSInteger)index {
    HomepageDataMenuDataModel *menuModel = self.dataModel.M1471835886075.data[index];
    [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"linkurl:%@",menuModel.linkurl]];
}

#pragma mark - 10个专区-1 被点击
- (void)menuSecondDidClicked:(NSInteger)index {
    HomepageDataMenuDataModel *menuModel = self.dataModel.M1529474107640.data[index];
    [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"linkurl:%@",menuModel.linkurl]];
}

#pragma mark - 首页数据请求
- (void)homepageDateRequest {
    NSString * urlString = @"r=apply";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] isEqualToString:@"1"]) {
            
            self.dataModel = [HomepageDataModel yy_modelWithDictionary:responseDic[@"result"]];
            //滚动广告图片数组
            _bannerImageArray = [NSMutableArray array];
            if ([self.dataModel.M1471835880921.data count] > 0) {
                for (HomepageDataBannerDataModel *bannerModel in self.dataModel.M1471835880921.data) {
                    [_bannerImageArray addObject:bannerModel.imgurl];
                }
            }
            
            [self.homeCollectionView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
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
