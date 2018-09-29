//
//  IntegralExchangeViewController.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralExchangeViewController.h"
#import "IntegralExchangeResultModel.h"
#import "IntegralExchangeListCell.h"

@interface IntegralExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    NSMutableArray *exchangeModelArray;
}
/** tableView */
@property(nonatomic , strong)UITableView *exchangeTableView;

@end

@implementation IntegralExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    exchangeModelArray = [NSMutableArray array];
    
    [self.view addSubview:self.exchangeTableView];
    requestPage = 1;
    [self creditlogDataRequest:requestPage];
}

#pragma mark - 我的积分数据请求
- (void)creditlogDataRequest:(NSInteger)page {
    NSString *url = @"r=apply.creditshop.creditlog";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                    [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%d",KPageSize],@"pagesize",
                              [NSString stringWithFormat:@"%ld",(long)page],@"page", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (page == 1) {
            [exchangeModelArray removeAllObjects];
        }
        [self.exchangeTableView.mj_header endRefreshing];
        [self.exchangeTableView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            IntegralExchangeResultModel *resultModel = [IntegralExchangeResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [exchangeModelArray addObjectsFromArray:resultModel.list];
            [self.exchangeTableView reloadData];
            
            if ([resultModel.list count] < KPageSize) {
                [self.exchangeTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.exchangeTableView.mj_header.isRefreshing == YES) {
            [self.exchangeTableView.mj_header endRefreshing];
        }
        if ([self.exchangeTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.exchangeTableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - tableView
- (UITableView *)exchangeTableView {
    if (!_exchangeTableView) {
        _exchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+90)) style:UITableViewStylePlain];
        _exchangeTableView.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0);
        _exchangeTableView.separatorColor = KLineColor;
        _exchangeTableView.backgroundColor = KTableBackgroundColor;
        _exchangeTableView.showsVerticalScrollIndicator = NO;
        _exchangeTableView.dataSource = self;
        _exchangeTableView.delegate = self;
        _exchangeTableView.estimatedRowHeight = 0;
        _exchangeTableView.estimatedSectionHeaderHeight = 0;
        _exchangeTableView.estimatedSectionFooterHeight = 0;
        [_exchangeTableView registerClass:[IntegralExchangeListCell class] forCellReuseIdentifier:NSStringFromClass([IntegralExchangeListCell class])];
        _exchangeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _exchangeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _exchangeTableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_exchangeTableView.mj_footer.isRefreshing) {
        requestPage = 1;
        [self creditlogDataRequest:requestPage];
    }
}

#pragma mark - 上拉加载
- (void)loadmore {
    if(!_exchangeTableView.mj_header.isRefreshing){
        requestPage ++;
        [self creditlogDataRequest:requestPage];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return exchangeModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
    IntegralExchangeListCell *exchangeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralExchangeListCell class])];
    if (exchangeModelArray.count > 0) {
        exchangeCell.exchangeListModel = exchangeModelArray[indexPath.row];
    }
    return exchangeCell;
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
