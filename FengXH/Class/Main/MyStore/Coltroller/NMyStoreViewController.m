//
//  NMyStoreViewController.m
//  FengXH
//
//  Created by sun on 2018/8/29.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "NMyStoreViewController.h"
#import "MyStoreNavigationView.h"
#import "MyStoreHeaderCell.h"
#import "MyStoreCustomCell.h"
#import "MyStoreResultModel.h"
#import "ShopkeeperCommissionViewController.h"
#import "DetailBaseViewController.h"
#import "MyTeamBaseViewController.h"
#import "PromotionPosterViewController.h"

@interface NMyStoreViewController ()<UITableViewDelegate,UITableViewDataSource>

/** collectionView */
@property(nonatomic , strong)UITableView *storeTableView;
/** navi */
@property(nonatomic , strong)MyStoreNavigationView *navigationView;
/** model */
@property(nonatomic , strong)MyStoreResultModel *resultModel;

@end

@implementation NMyStoreViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self myStoreDataRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.storeTableView];
    [self.view addSubview:self.navigationView];
    
}

#pragma mark - 数据请求
- (void)myStoreDataRequest {
    NSString * urlString = @"r=apply.commission";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr} WithSuccessBlock:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue] == 1) {
            //NSLog(@"%@",responseDic);
            
            self.resultModel = [MyStoreResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self.storeTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - tableView
- (UITableView *)storeTableView {
    if (!_storeTableView) {
        _storeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KTabbarHeight) style:UITableViewStylePlain];
        _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _storeTableView.backgroundColor = [UIColor whiteColor];
        _storeTableView.showsVerticalScrollIndicator = NO;
        _storeTableView.dataSource = self;
        _storeTableView.delegate = self;
        _storeTableView.estimatedRowHeight = 0;
        _storeTableView.estimatedSectionHeaderHeight = 0;
        _storeTableView.estimatedSectionFooterHeight = 0;
        [_storeTableView registerClass:[MyStoreHeaderCell class] forCellReuseIdentifier:NSStringFromClass([MyStoreHeaderCell class])];
        [_storeTableView registerClass:[MyStoreCustomCell class] forCellReuseIdentifier:NSStringFromClass([MyStoreCustomCell class])];
        [_storeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _storeTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultModel) {
        return 2;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return [ShareManager getImageHeight:@"MyToreHeader"]+180; break;
        case 1: return (KMAINSIZE.width/3)*3; break;
        default: return CGFLOAT_MIN; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            MyStoreHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyStoreHeaderCell class])];
            headerCell.resultModel = self.resultModel;
            MJWeakSelf
            headerCell.withdrawBlock = ^(UIButton *sender) {
                [weakSelf customCellDidClicked:0];
            };
            return headerCell;
        } break;
        case 1: {
            MyStoreCustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyStoreCustomCell class])];
            customCell.resultModel = self.resultModel;
            MJWeakSelf
            customCell.itemClickBlock = ^(NSInteger index) {
                [weakSelf customCellDidClicked:index];
            };
            return customCell;
        } break;
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } break;
    }
}


#pragma mark - 点击事件
- (void)customCellDidClicked:(NSInteger)index {
    switch (index) {
        case 0: {
            //店主佣金
            ShopkeeperCommissionViewController *VC = [[ShopkeeperCommissionViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        } break;
        case 1: {
            //佣金明细
            DetailBaseViewController *VC = [[DetailBaseViewController alloc] initWithType:0];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        } break;
        case 2: {
            //提现明细
            DetailBaseViewController *VC = [[DetailBaseViewController alloc] initWithType:1];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        } break;
        case 3: {
            //我的团队
            MyTeamBaseViewController *VC = [[MyTeamBaseViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        } break;
        case 4: {
            //推广海报
            PromotionPosterViewController *VC = [[PromotionPosterViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        } break;
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.storeTableView) {
        CGFloat scale = self.storeTableView.contentOffset.y;
        if (scale<120 && scale>0) {
            CGFloat nav_alptha = scale/120;
            self.navigationView.alpha = nav_alptha;
        } else if (scale>120) {
            self.navigationView.alpha = 1.0;
        } else if (scale<0) {
            self.navigationView.alpha = 0.0;
        }
    }
}

#pragma mark - 懒加载
- (MyStoreNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[MyStoreNavigationView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KNaviHeight)];
        [_navigationView setAlpha:0.0f];
    }
    return _navigationView;
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
