//
//  IntegralRecordViewController.m
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordViewController.h"
#import "IntegralRecordCell.h"
#import "IntegralRecordResultModel.h"
#import "IntegralRecordDetailViewController.h"

@interface IntegralRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    NSMutableArray *integralRecordModelArray;
}
/** 记录类型 */
@property(nonatomic , assign)NSInteger orderType;
/** tableView */
@property(nonatomic , strong)UITableView *recordTableView;

@end

@implementation IntegralRecordViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _orderType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    integralRecordModelArray = [NSMutableArray array];
    
    [self.view addSubview:self.recordTableView];
    requestPage = 1;
    [self exchangeRecordDataRequest:requestPage];
}

#pragma mark - 我的积分数据请求
- (void)exchangeRecordDataRequest:(NSInteger)page {
    NSString *url = @"r=apply.creditshop.log";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%d",KPageSize],@"pagesize",
                              [NSString stringWithFormat:@"%ld",(long)page],@"page",
                              [NSString stringWithFormat:@"%ld",(long)_orderType],@"status", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (page == 1) {
            [integralRecordModelArray removeAllObjects];
        }
        [self.recordTableView.mj_header endRefreshing];
        [self.recordTableView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {

            IntegralRecordResultModel *resultModel = [IntegralRecordResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [integralRecordModelArray addObjectsFromArray:resultModel.list];
            [self.recordTableView reloadData];

            if ([resultModel.list count] < KPageSize) {
                [self.recordTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.recordTableView.mj_header.isRefreshing == YES) {
            [self.recordTableView.mj_header endRefreshing];
        }
        if ([self.recordTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.recordTableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - tableView
- (UITableView *)recordTableView {
    if (!_recordTableView) {
        _recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+42)) style:UITableViewStylePlain];
        _recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _recordTableView.backgroundColor = KTableBackgroundColor;
        _recordTableView.showsVerticalScrollIndicator = NO;
        _recordTableView.dataSource = self;
        _recordTableView.delegate = self;
        _recordTableView.estimatedRowHeight = 0;
        _recordTableView.estimatedSectionHeaderHeight = 0;
        _recordTableView.estimatedSectionFooterHeight = 0;
        [_recordTableView registerClass:[IntegralRecordCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRecordCell class])];
    }
    return _recordTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return integralRecordModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return 6; break;
        default: return CGFLOAT_MIN; break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralRecordCell *recordCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRecordCell class])];
    if (integralRecordModelArray.count > 0) {
        recordCell.recordListModel = integralRecordModelArray[indexPath.section];
    }
    return recordCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralRecordResultListModel *listModel = integralRecordModelArray[indexPath.section];
    IntegralRecordDetailViewController *VC = [[IntegralRecordDetailViewController alloc] init];
    VC.orderID = listModel.recordID;
    [self.navigationController pushViewController:VC animated:YES];
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
