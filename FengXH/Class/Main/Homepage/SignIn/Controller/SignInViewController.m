//
//  SignInViewController.m
//  FengXH
//
//  Created by sun on 2018/10/8.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInDetailViewController.h"
#import "SignInResultModel.h"
#import "SignInHeaderCollectionReusableView.h"
#import "SignInFooterCollectionReusableView.h"
#import "SignInDayCollectionViewCell.h"
#import "SignInCanDrawCollectionViewCell.h"
#import "IntegralBaseViewController.h"

@interface SignInViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** 导航栏右按钮 */
@property(nonatomic , strong)UIButton *detailButton;
/** collectionView */
@property(nonatomic , strong)UICollectionView *signInCollectionView;
/** model */
@property(nonatomic , strong)SignInResultModel *resultModel;

@end

@implementation SignInViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置导航栏右边按钮
    [self.navigationController.navigationBar addSubview:self.detailButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.detailButton) {
        [self.detailButton removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到领奖";
    
    [self.view addSubview:self.signInCollectionView];
    [self signInDataRequest];
    
}

#pragma mark - 签到数据请求
- (void)signInDataRequest {
    NSString * urlString = @"r=apply.sign";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [SignInResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self.signInCollectionView reloadData];
            
        } else if ([responseDic[@"status"] integerValue] == 401) {
            [self presentLoginViewControllerWithSuccessBlock:^{
                [self signInDataRequest];
            } WithFailureBlock:^{
                
            }];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - collectionView
- (UICollectionView *)signInCollectionView {
    if (!_signInCollectionView) {
        UICollectionViewFlowLayout *_customLayout = [[UICollectionViewFlowLayout alloc]init];
        _signInCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) collectionViewLayout:_customLayout];
        _customLayout.minimumLineSpacing = CGFLOAT_MIN;
        _customLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        _signInCollectionView.backgroundColor = [UIColor whiteColor];
        _signInCollectionView.delegate = self;
        _signInCollectionView.dataSource = self;
        _signInCollectionView.showsVerticalScrollIndicator = NO;
        _signInCollectionView.alwaysBounceVertical = YES;
        [_signInCollectionView registerClass:[SignInHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SignInHeaderCollectionReusableView class])];
        [_signInCollectionView registerClass:[SignInFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([SignInFooterCollectionReusableView class])];
        [_signInCollectionView registerClass:[SignInDayCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SignInDayCollectionViewCell class])];
        [_signInCollectionView registerClass:[SignInCanDrawCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SignInCanDrawCollectionViewCell class])];
        [_signInCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _signInCollectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            NSInteger item = ([ShareManager convertDateToTotalDays:[NSDate date]] + [ShareManager convertDateToFirstWeekDay:[NSDate date]]);
            return ([self getRowCount:item]*7);
        } break;
        case 1: return 1; break;
        default: return 0; break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            return CGSizeMake(KMAINSIZE.width/7, KMAINSIZE.width/7);
        } break;
        case 1: {
            return CGSizeMake(KMAINSIZE.width, 240);
        } break;
        default: return CGSizeZero; break;
    }
}

#pragma mark - sectionHeader 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return CGSizeMake(KMAINSIZE.width, 240);
        } break;
        default: return CGSizeZero; break;
    }
}

#pragma mark - sectionFooter 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return CGSizeMake(KMAINSIZE.width, 40);
        } break;
        default: return CGSizeZero; break;
    }
}

#pragma mark - 指定头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                SignInHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SignInHeaderCollectionReusableView class]) forIndexPath:indexPath];
                headerView.headerResultModel = self.resultModel;
                MJWeakSelf
                headerView.signInHeaderBlock = ^(NSInteger index) {
                    [weakSelf headerViewAction:index];
                };
                return headerView;
            } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
                SignInFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([SignInFooterCollectionReusableView class]) forIndexPath:indexPath];
                return footerView;
            }
        } break;
        default:
            break;
    }
    return [[UICollectionReusableView alloc] init];
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            SignInDayCollectionViewCell *dayCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SignInDayCollectionViewCell class]) forIndexPath:indexPath];
            return dayCell;
        } break;
        case 1: {
            SignInCanDrawCollectionViewCell *canDrawCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SignInCanDrawCollectionViewCell class]) forIndexPath:indexPath];
            MJWeakSelf
            canDrawCell.rewordBlock = ^(NSString * _Nonnull dayString) {
                [weakSelf signInRewordRequestWith:dayString];
            };
            return canDrawCell;
        } break;
        default:
            break;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            SignInDayCollectionViewCell *dayCell = (SignInDayCollectionViewCell *)cell;            
            dayCell.dateString = [NSString stringWithFormat:@"%ld",(long)((indexPath.row + 1) - [ShareManager convertDateToFirstWeekDay:[NSDate date]])];
            dayCell.signedArray = self.resultModel.calendar;
            MJWeakSelf
            dayCell.signInDayBlock = ^(NSString *dateString) {
                [weakSelf signInWithDate:dateString];
            };
        } break;
        case 1: {
            SignInCanDrawCollectionViewCell *canDrawCell = (SignInCanDrawCollectionViewCell *)cell;
            canDrawCell.canDrawArray = self.resultModel.advaward.order;
        } break;
        default:
            break;
    }
}

#pragma mark - 领取签到奖励
- (void)signInRewordRequestWith:(NSString *)day {
    NSString *url = @"r=apply.sign.doreward";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              day,@"day",
                              @"1",@"type", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:responseDic[@"result"][@"message"]];
            [self signInDataRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 签到与补签到方法
- (void)signInWithDate:(NSString *)date {
    if (date <= [ShareManager getNowTimeDaystamp]) {
        //小于等于当天日期才可签到
        [self signInRequestWithDateString:[NSString stringWithFormat:@"%@-%@",[ShareManager getNowTimeYearMonthstamp],date]];
    }
}

#pragma mark - 头视图点击触发方法
- (void)headerViewAction:(NSInteger)index {
    switch (index) {
        case 0: {//点击签到
            [self signInRequestWithDateString:nil];
        } break;
        case 1: {//跳转积分商城
            IntegralBaseViewController *VC = [[IntegralBaseViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        } break;
            
        default:
            break;
    }
}

#pragma mark - 签到请求
- (void)signInRequestWithDateString:(NSString *)dateString {
    NSString *url = @"r=apply.sign.dosign";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    if (dateString) {
        [paramDic setObject:dateString forKey:@"date"];
    }
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:responseDic[@"result"][@"message"]];
            [self signInDataRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
    
}

#pragma mark - 详细记录按钮被点击
- (void)detailButtonDidClicked:(UIButton *)sender {
    SignInDetailViewController *VC = [[SignInDetailViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 详细记录按钮
- (UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.frame = CGRectMake(KMAINSIZE.width-70, 0, 64, 44);
        [_detailButton setTitle:@"详细记录" forState:UIControlStateNormal];
        [_detailButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_detailButton.titleLabel setFont:KFont(15)];
        [_detailButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [_detailButton setShowsTouchWhenHighlighted:YES];
        [_detailButton addTarget:self action:@selector(detailButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailButton;
}

#pragma mark - 根据每月天数返回行数
- (NSInteger)getRowCount:(NSInteger)item {
    NSInteger mor = item%7;
    return item/7 + (mor>0?1:0);
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
