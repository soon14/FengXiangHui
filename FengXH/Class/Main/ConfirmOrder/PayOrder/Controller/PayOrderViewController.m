//
//  PayOrderViewController.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PayOrderViewController.h"
#import "PayOrderOrderInfoCell.h"
#import "PayOrderResultModel.h"
#import "PayOrderMethodCell.h"
#import "WechatPayManager.h"
#import "PaySuccessViewController.h"


@interface PayOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *payTableView;
/** model */
@property(nonatomic , strong)PayOrderResultModel *orderResultModel;

@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收银台";
    
    [self.view addSubview:self.payTableView];
    if (_teamID) {
        NSDictionary *responseDic = @{@"price":_price,@"ordersn":_orderNum};
        self.orderResultModel = [PayOrderResultModel yy_modelWithDictionary:responseDic];
        [self.payTableView reloadData];
    } else {
        [self orderNumberRequest];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WechatPayInfoAction:) name:@"WechatPayInfo" object:nil];
}

#pragma mark -  微信支付信息回调监听
- (void)WechatPayInfoAction:(NSNotification *)notification {
    NSInteger infoCode = [notification.object[@"info"] integerValue];
    switch (infoCode) {
        case 0: {
           
            PaySuccessViewController *VC = [[PaySuccessViewController alloc] init];
            VC.payType = @"wechat";
            VC.orderID = _orderID;
            if (_teamID) {
                VC.teamID = _teamID;
            }
            [self.navigationController pushViewController:VC animated:YES];
            
        } break;
        default: {//失败
            [DBHUD ShowInView:self.view withTitle:@"支付失败"];
        } break;
    }
}

#pragma mark - tableView
- (UITableView *)payTableView {
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) style:UITableViewStylePlain];
        _payTableView.separatorColor = KLineColor;
        _payTableView.backgroundColor = KTableBackgroundColor;
        _payTableView.showsVerticalScrollIndicator = NO;
        _payTableView.dataSource = self;
        _payTableView.delegate = self;
        _payTableView.estimatedRowHeight = 0;
        _payTableView.estimatedSectionHeaderHeight = 0;
        _payTableView.estimatedSectionFooterHeight = 0;
        _payTableView.tableFooterView = [[UIView alloc] init];
        [_payTableView registerClass:[PayOrderOrderInfoCell class] forCellReuseIdentifier:NSStringFromClass([PayOrderOrderInfoCell class])];
        [_payTableView registerClass:[PayOrderMethodCell class] forCellReuseIdentifier:NSStringFromClass([PayOrderMethodCell class])];
        [_payTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _payTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.orderResultModel) {
        return 2;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section)
    {
        case 0: return 90; break;
        case 1: return 70; break;
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
        case 0: {
            PayOrderOrderInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PayOrderOrderInfoCell class])];
            infoCell.orderResultModel = self.orderResultModel;
            return infoCell;
        } break;
        case 1: {
            PayOrderMethodCell *methodCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PayOrderMethodCell class])];
            MJWeakSelf
            methodCell.payMethodBlock = ^(NSInteger index) {
                [weakSelf payMethodSelected:index];
            };
            return methodCell;
        } break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

#pragma mark - 支付方式被选择
- (void)payMethodSelected:(NSInteger)index {
    switch (index) {
        case 0: {
            if (_teamID) {
                [self groupsWechatPayRequest];
            } else {
                [self wechatPayRequest];
            }
        } break;
        case 1: {
            [DBHUD ShowInView:self.view withTitle:@"支付宝支付"];
        } break;
        case 2: {
            [DBHUD ShowInView:self.view withTitle:@"京东支付"];
        } break;
            
        default:
            break;
    }
}


#pragma mark - 拼团商品微信支付请求
- (void)groupsWechatPayRequest {
    NSString *url = @"r=apply.groups.pay.submit";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _orderID,@"orderid",
                              _teamID,@"teamid",
                              @"wechat",@"type", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            NSDictionary *wxPayDic = responseDic[@"result"];
            
            [WechatPayManager WXPayWithAppid:wxPayDic[@"appId"] noncestr:wxPayDic[@"nonceStr"] package:@"Sign=WXPay" partnerid:wxPayDic[@"partnerid"] prepayid:wxPayDic[@"prepay_id"] timestamp:[ShareManager getNowTimeTimestamp] key:@"daup4t4cs1xj1jjrj50de4dknx4bcnsm"];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"后台繁忙"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 普通商品微信支付请求
- (void)wechatPayRequest {
    NSString *url = @"r=apply.order.pay.submit";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _orderID,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            //NSLog(@"微信支付：\n%@",responseDic);
            NSDictionary *wxPayDic = responseDic[@"result"];
            
            [WechatPayManager WXPayWithAppid:wxPayDic[@"appId"] noncestr:wxPayDic[@"nonceStr"] package:@"Sign=WXPay" partnerid:wxPayDic[@"partnerid"] prepayid:wxPayDic[@"prepay_id"] timestamp:[ShareManager getNowTimeTimestamp] key:@"daup4t4cs1xj1jjrj50de4dknx4bcnsm"];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"后台繁忙"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 请求普通商品订单号
- (void)orderNumberRequest {
    NSString *url = @"r=apply.order.pay";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _orderID,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            if ([responseDic[@"result"][@"price"] doubleValue] == 0) {
                PaySuccessViewController *VC = [[PaySuccessViewController alloc] init];
                VC.payType = @"credit";
                VC.orderID = responseDic[@"result"][@"orderid"];
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                self.orderResultModel = [PayOrderResultModel yy_modelWithDictionary:responseDic[@"result"]];
                [self.payTableView reloadData];
            }
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"获取订单号失败"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //移除通知
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
