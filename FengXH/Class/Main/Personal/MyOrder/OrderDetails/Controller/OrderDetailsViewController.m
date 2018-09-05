//
//  OrderDetailsViewController.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailBottomView.h"
#import "OrderDetailStatusCell.h"
#import "OrderDetailAddressCell.h"
#import "OrderDetailGoodsCell.h"
#import "OrderDetailPriceCell.h"
#import "OrderDetailTimesCell.h"
#import "OrderDetailResultModel.h"
#import "EvaluateViewController.h"
#import "PayOrderViewController.h"
#import "OrderAfterSaleViewController.h"
#import "CheckAfterSaleViewController.h"

// 板块类型
typedef NS_ENUM(NSInteger , OrderDetailSectionStyle) {
    OrderDetailStyle_status = 0 ,
    OrderDetailStyle_address ,
    OrderDetailStyle_goods ,
    OrderDetailStyle_price ,
    OrderDetailStyle_times ,
};

@interface OrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,OrderDetailBottomViewDelegate>

/** headerView */
@property(nonatomic , strong)OrderDetailBottomView *bottomView;
/** tableView */
@property(nonatomic , strong)UITableView *detailTableView;
/** model */
@property(nonatomic , strong)OrderDetailResultModel *detailResultModel;

@end

@implementation OrderDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self orderDetailRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.detailTableView];
    
//    [self orderDetailRequest];
    
}

- (OrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[OrderDetailBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)detailTableView {
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) style:UITableViewStylePlain];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = KTableBackgroundColor;
        _detailTableView.showsVerticalScrollIndicator = NO;
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        _detailTableView.estimatedRowHeight = 0;
        _detailTableView.estimatedSectionHeaderHeight = 0;
        _detailTableView.estimatedSectionFooterHeight = 0;
        [_detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"orderDetailNotingCellID"];
        [_detailTableView registerClass:[OrderDetailStatusCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailStatusCell class])];
        [_detailTableView registerClass:[OrderDetailAddressCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailAddressCell class])];
        [_detailTableView registerClass:[OrderDetailGoodsCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailGoodsCell class])];
        [_detailTableView registerClass:[OrderDetailPriceCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailPriceCell class])];
        [_detailTableView registerClass:[OrderDetailTimesCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailTimesCell class])];
    }
    return _detailTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.detailResultModel) {
        return 5;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case OrderDetailStyle_goods: return self.detailResultModel.goods.count; break;
        default: return 1; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case OrderDetailStyle_status: return 70; break;
        case OrderDetailStyle_address: return 90; break;
        case OrderDetailStyle_goods: return 104; break;
        case OrderDetailStyle_price: return 132; break;
        case OrderDetailStyle_times: {
            return [tableView cellHeightForIndexPath:indexPath model:self.detailResultModel keyPath:@"timesDetailResultModel" cellClass:[OrderDetailTimesCell class] contentViewWidth:KMAINSIZE.width];
        }; break;
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
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case OrderDetailStyle_status: {
            OrderDetailStatusCell *statusCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailStatusCell class])];
            statusCell.statusModel = self.detailResultModel;
            return statusCell;
        } break;
        case OrderDetailStyle_address: {
            OrderDetailAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailAddressCell class])];
            addressCell.addressModel = self.detailResultModel.address;
            return addressCell;
        } break;
        case OrderDetailStyle_goods: {
            OrderDetailGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailGoodsCell class])];
            OrderDetailResultGoodsModel *orderGoodsModel = self.detailResultModel.goods[indexPath.row];
            goodsCell.goodsModel = orderGoodsModel;
            return goodsCell;
        } break;
        case OrderDetailStyle_price: {
            OrderDetailPriceCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailPriceCell class])];
            goodsCell.detailResultModel = self.detailResultModel;
            return goodsCell;
        } break;
        case OrderDetailStyle_times: {
            OrderDetailTimesCell *timesCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailTimesCell class])];
            timesCell.timesDetailResultModel = self.detailResultModel;
            return timesCell;
        } break;
            
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailNotingCellID"];
            return cell;
        } break;
    }
}

#pragma mark - 支付订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view payButtonDidClick:(OrderDetailResultModel *)orderModel {
    [self payOrderRequest:_orderID];
}

#pragma mark - 取消订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view cancelButtonDidClick:(OrderDetailResultModel *)orderModel {
    [self cancelOrderRequest:_orderID];
}

#pragma mark - 删除订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view deleteButtonDidClick:(OrderDetailResultModel *)orderModel {
    [self deleteOrderRequest:_orderID];
}

#pragma mark - 评价订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view evaluateButtonDidClick:(OrderDetailResultModel *)orderModel {
    EvaluateViewController *VC = [[EvaluateViewController alloc] init];
    VC.jumpURL = [NSString stringWithFormat:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=order.comment&id=%@",_orderID];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 申请退款按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view refundButtonDidClick:(OrderDetailResultModel *)orderModel {
    OrderAfterSaleViewController *VC = [[OrderAfterSaleViewController alloc] initWithType:0];
    VC.orderId = _orderID;
    VC.title = @"申请退款";
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 确认收货按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view confirmOrderButtonDidClick:(OrderDetailResultModel *)orderModel {
    [self confirmOrderRequest:_orderID];
}

#pragma mark - 申请售后按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view afterSaleButtonDidClick:(OrderDetailResultModel *)orderModel {
    OrderAfterSaleViewController *VC = [[OrderAfterSaleViewController alloc] initWithType:0];
    VC.orderId = _orderID;
    VC.title = @"申请售后";
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 取消申请按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view cancelRefundButtonDidClick:(OrderDetailResultModel *)orderModel {
    [self cancelRefundRequest:_orderID];
}

#pragma mark - 查看申请售后进度按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view checkAfterSaleButtonDidClick:(OrderDetailResultModel *)orderModel {
    CheckAfterSaleViewController *VC = [[CheckAfterSaleViewController alloc] init];
    VC.orderID = _orderID;
    VC.cancelAfterSaleSuccessBlock = ^{
        [self orderDetailRequest];
    };
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark - 取消申请请求
- (void)cancelRefundRequest:(NSString *)orderID {
    NSString *url = @"r=apply.order.refund.cancel";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              orderID,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self orderDetailRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 确认收货请求
- (void)confirmOrderRequest:(NSString *)orderID {
    NSString *url = @"r=apply.order.op.finish";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              orderID,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
            [self orderDetailRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 支付订单请求
- (void)payOrderRequest:(NSString *)orderID {
    NSString *url = @"r=apply.order.pay";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              orderID,@"orderid", nil];
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
- (void)cancelOrderRequest:(NSString *)orderID {
    NSString *url = @"r=apply.order.op.cancel";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              orderID,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            if (self.requestSuccessBlock) {
                self.requestSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 删除订单请求
- (void)deleteOrderRequest:(NSString *)orderID {
    NSString *url = @"r=apply.order.op.delete";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              orderID,@"orderid",
                              @"1",@"userdeleted", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            if (self.requestSuccessBlock) {
                self.requestSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}


#pragma mark - 订单详情请求
- (void)orderDetailRequest {
    NSString *url = @"r=apply.order.detail";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _orderID,@"orderid", nil];
    if (!self.detailResultModel) {
        [DBHUD ShowProgressInview:self.view Withtitle:nil];
    }
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.detailResultModel = [OrderDetailResultModel yy_modelWithDictionary:responseDic[@"result"]];
            self.bottomView.orderModel = self.detailResultModel;
            
            [self.detailTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
