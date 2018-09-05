//
//  MyOrderViewController.m
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderDefaultCell.h"
#import "OrderNumberTypeHeaderView.h"
#import "OrderSectionFooterView.h"
#import "MyOrderResultModel.h"
#import "OrderDetailsViewController.h"
#import "PayOrderViewController.h"
#import "CheckLogisticsViewController.h"
#import "EvaluateViewController.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderSectionFooterViewDelegate>
{
    NSInteger requestPage;
    NSMutableArray *orderModelArray;
}
/** 订单类型 */
@property(nonatomic , assign)NSInteger orderType;
/** tableView */
@property(nonatomic , strong)UITableView *orderTableView;

@end

static NSString *notingCellID = @"notingCellID";

@implementation MyOrderViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _orderType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.orderTableView];
    
    orderModelArray = [NSMutableArray array];
    requestPage = 1;
    [self myOrderRequest:requestPage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"PersonalOrderPaySuccessNotification" object:nil];
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
        MyOrderResultListModel *orderListModel = orderModelArray[section];
        if ([orderListModel.status integerValue] == 1) {
            //待发货
            return 40;
        } return 88;
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderSectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderSectionFooterView class])];
    footerView.delegate = self;
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

#pragma mark - 确认收货按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view confirmOrderButtonDidClick:(MyOrderResultListModel *)orderModel {
    [self confirmOrderRequest:orderModel];
}

#pragma mark - 支付订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view payButtonDidClick:(MyOrderResultListModel *)orderModel {
    [self payOrderRequest:orderModel];
}

#pragma mark - 取消订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view cancelButtonDidClick:(MyOrderResultListModel *)orderModel {
    [self cancelOrderRequest:orderModel];
}

#pragma mark - 删除订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view deleteButtonDidClick:(MyOrderResultListModel *)orderModel {
    [self deleteOrderRequest:orderModel];
}

#pragma mark -  评价订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view evaluateButtonDidClick:(MyOrderResultListModel *)orderModel {
    EvaluateViewController *VC = [[EvaluateViewController alloc] init];
    VC.jumpURL = [NSString stringWithFormat:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=order.comment&id=%@",orderModel.order_id];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 查看物流按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view logisticsButtonDidClick:(MyOrderResultListModel *)orderModel {
    CheckLogisticsViewController *VC = [[CheckLogisticsViewController alloc] init];
    VC.jumpURL = [NSString stringWithFormat:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=order.express&id=%@",orderModel.order_id];
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark - 删除订单请求
- (void)deleteOrderRequest:(MyOrderResultListModel *)model {
    NSString *url = @"r=apply.order.op.delete";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              model.order_id,@"orderid",
                              @"1",@"userdeleted", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [orderModelArray removeObject:model];
            [self.orderTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 确认收货请求
- (void)confirmOrderRequest:(MyOrderResultListModel *)model {
    NSString *url = @"r=apply.order.op.finish";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              model.order_id,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
            [self refresh];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 支付订单请求
- (void)payOrderRequest:(MyOrderResultListModel *)model {
    NSString *url = @"r=apply.order.pay";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              model.order_id,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            PayOrderViewController *VC = [[PayOrderViewController alloc] init];
            VC.orderID = responseDic[@"result"][@"orderid"];
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 取消订单请求
- (void)cancelOrderRequest:(MyOrderResultListModel *)model {
    NSString *url = @"r=apply.order.op.cancel";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                        [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              model.order_id,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self refresh];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 订单数据请求
- (void)myOrderRequest:(NSInteger)page {
    NSString *url = @"r=apply.order.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    [paramDic setObject:[NSString stringWithFormat:@"%d",KPageSize] forKey:@"pagesize"];
    [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    if (_orderType != 400) {
        [paramDic setObject:[NSString stringWithFormat:@"%ld",(long)_orderType] forKey:@"status"];
    }
    
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
