//
//  RefundChangeViewController.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "RefundChangeViewController.h"
#import "OrderNumberTypeHeaderView.h"
#import "OrderDefaultCell.h"
#import "MyOrderResultModel.h"
#import "OrderDetailsViewController.h"
#import "OrderSectionFooterView.h"

@interface RefundChangeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    NSMutableArray *orderModelArray;
}
/** tableView */
@property(nonatomic , strong)UITableView *orderTableView;

@end

@implementation RefundChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退换货订单";
    [self.view addSubview:self.orderTableView];
    
    orderModelArray = [NSMutableArray array];
    requestPage = 1;
    [self myOrderRequest:requestPage];
}

#pragma mark - tableView
- (UITableView *)orderTableView {
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-42-KNaviHeight) style:UITableViewStyleGrouped];
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.backgroundColor = KTableBackgroundColor;
        _orderTableView.showsVerticalScrollIndicator = NO;
        _orderTableView.dataSource = self;
        _orderTableView.delegate = self;
        _orderTableView.estimatedRowHeight = 0;
        _orderTableView.estimatedSectionHeaderHeight = 0;
        _orderTableView.estimatedSectionFooterHeight = 0;
        [_orderTableView registerClass:[OrderNumberTypeHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([OrderNumberTypeHeaderView class])];
        [_orderTableView registerClass:[OrderSectionFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([OrderSectionFooterView class])];
        [_orderTableView registerClass:[OrderDefaultCell class] forCellReuseIdentifier:NSStringFromClass([OrderDefaultCell class])];
        _orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _orderTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _orderTableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_orderTableView.mj_footer.isRefreshing) {
        requestPage = 1;
        [self myOrderRequest:requestPage];
    }
}

#pragma mark - 上拉加载
- (void)loadmore {
    if(!_orderTableView.mj_header.isRefreshing){
        requestPage ++;
        [self myOrderRequest:requestPage];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (orderModelArray.count > 0) {
        return orderModelArray.count;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MyOrderResultListModel *orderListModel = orderModelArray[section];
    return orderListModel.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderNumberTypeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderNumberTypeHeaderView class])];
    if (orderModelArray.count > 0) {
        headerView.orderModel = orderModelArray[section];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (orderModelArray.count > 0) {
        return 40;
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderSectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderSectionFooterView class])];
    if (orderModelArray.count > 0) {
        footerView.orderModel = orderModelArray[section];
    }
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDefaultCell *orderCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDefaultCell class])];
    if (orderModelArray.count > 0) {
        MyOrderResultListModel *orderListModel = orderModelArray[indexPath.section];
        orderCell.orderGoodsModel = orderListModel.goods[indexPath.row];
    }
    return orderCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderResultListModel *orderListModel = orderModelArray[indexPath.section];
    OrderDetailsViewController *VC = [[OrderDetailsViewController alloc] init];
    VC.orderID = orderListModel.order_id;
    VC.requestSuccessBlock = ^{
        [self refresh];
    };
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark - 订单数据请求
- (void)myOrderRequest:(NSInteger)page {
    NSString *url = @"r=apply.order.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    [paramDic setObject:[NSString stringWithFormat:@"%d",KPageSize] forKey:@"pagesize"];
    [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
        [paramDic setObject:[NSString stringWithFormat:@"4"] forKey:@"status"];
    
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (page == 1) {
            [orderModelArray removeAllObjects];
        }
        [self.orderTableView.mj_header endRefreshing];
        [self.orderTableView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            MyOrderResultModel *resultModel = [MyOrderResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [orderModelArray addObjectsFromArray:resultModel.list];
            
            if ([resultModel.list count] < KPageSize) {
                [self.orderTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.orderTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.orderTableView.mj_header.isRefreshing == YES) {
            [self.orderTableView.mj_header endRefreshing];
        }
        if ([self.orderTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.orderTableView.mj_footer endRefreshing];
        }
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
