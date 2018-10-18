//
//  SignInDetailViewController.m
//  FengXH
//
//  Created by sun on 2018/10/8.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInDetailViewController.h"
#import "SignInDetailResultModel.h"
#import "SignInDetailCell.h"

@interface SignInDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    NSMutableArray *listArray;
}
/** tableView */
@property(nonatomic , strong)UITableView *signInDetailTableView;

@end

@implementation SignInDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细记录";
    
    listArray = [NSMutableArray array];
    requestPage = 1;
    [self signInDetailRequestWithPage:requestPage];
    [self.view addSubview:self.signInDetailTableView];
}

#pragma mark - 签到详细记录请求
- (void)signInDetailRequestWithPage:(NSInteger)page {
    NSString * urlString = @"r=apply.sign.records";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%d",KPageSize],@"pageSize",
                              [NSString stringWithFormat:@"%ld",(long)requestPage],@"page", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (page == 1) {
            [listArray removeAllObjects];
        }
        [self.signInDetailTableView.mj_header endRefreshing];
        [self.signInDetailTableView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            SignInDetailResultModel *resultModel = [SignInDetailResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [listArray addObjectsFromArray:resultModel.list];
            
            if ([resultModel.list count] < KPageSize) {
                [self.signInDetailTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.signInDetailTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.signInDetailTableView.mj_header.isRefreshing == YES) {
            [self.signInDetailTableView.mj_header endRefreshing];
        }
        if ([self.signInDetailTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.signInDetailTableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - tableView
- (UITableView *)signInDetailTableView {
    if (!_signInDetailTableView) {
        _signInDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) style:UITableViewStylePlain];
        _signInDetailTableView.separatorColor = KLineColor;
        _signInDetailTableView.backgroundColor = KTableBackgroundColor;
        _signInDetailTableView.showsVerticalScrollIndicator = NO;
        _signInDetailTableView.dataSource = self;
        _signInDetailTableView.delegate = self;
        _signInDetailTableView.estimatedRowHeight = 0;
        _signInDetailTableView.estimatedSectionHeaderHeight = 0;
        _signInDetailTableView.estimatedSectionFooterHeight = 0;
        [_signInDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_signInDetailTableView registerClass:[SignInDetailCell class] forCellReuseIdentifier:NSStringFromClass([SignInDetailCell class])];
        _signInDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _signInDetailTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _signInDetailTableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_signInDetailTableView.mj_footer.isRefreshing) {
        requestPage = 1;
        [self signInDetailRequestWithPage:requestPage];
    }
}

#pragma mark - 上拉加载
- (void)loadmore {
    if(!_signInDetailTableView.mj_header.isRefreshing){
        requestPage ++;
        [self signInDetailRequestWithPage:requestPage];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (listArray.count > 0) {
        return 85;
    } return CGFLOAT_MIN;
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
    if (listArray.count > 0) {
        SignInDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SignInDetailCell class])];
        detailCell.signInDetailModel = listArray[indexPath.row];
        return detailCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
