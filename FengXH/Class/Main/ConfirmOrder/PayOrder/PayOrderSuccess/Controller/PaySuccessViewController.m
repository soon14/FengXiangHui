//
//  PaySuccessViewController.m
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "PaySuccessResultModel.h"
#import "PaySuccessStatusCell.h"
#import "PaySuccessAddressCell.h"
#import "PaySuccessPriceCell.h"
#import "ShopCartViewController.h"
#import "PersonalViewController.h"
#import "NHomepageViewController.h"
#import "AllGoodsViewController.h"
#import "PaySuccessFooterCell.h"
#import "SpellHomeViewController.h"
#import "SpellGroupDetailsViewController.h"
#import "GroupOperatingViewController.h"
#import "CreateGroupOrderViewController.h"
#import "PayOrderViewController.h"
#import "SpellActivityViewController.h"
#import "SpellOrderBaseViewController.h"
#import "SpellOrderDetailViewController.h"
#import "GoodsDetailViewController.h"
#import "ConfirmOrderViewController.h"
#import "SpellOrderListModel.h"
#import "OrderDetailsViewController.h"

@interface PaySuccessViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *payTableview;
/** model */
@property(nonatomic , strong)PaySuccessResultModel *resultModel;

@end

@implementation PaySuccessViewController

#pragma mark - 在这个方法里将中间的控制器销毁掉
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController.viewControllers count] >= 3) {
        NSMutableArray *VCArray = self.navigationController.viewControllers.mutableCopy;
        NSMutableArray *arrRemove = [NSMutableArray array];
        for (UIViewController *VC in VCArray) {
            if ([VC isKindOfClass:[SpellGroupDetailsViewController class]] || [VC isKindOfClass:[GroupOperatingViewController class]] || [VC isKindOfClass:[CreateGroupOrderViewController class]] || [VC isKindOfClass:[PayOrderViewController class]] || [VC isKindOfClass:[GoodsDetailViewController class]] || [VC isKindOfClass:[ConfirmOrderViewController class]]) {
                [arrRemove addObject:VC];
            }
        }
        if (arrRemove.count) {
            [VCArray removeObjectsInArray:arrRemove];
            [self.navigationController setViewControllers:VCArray animated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    
    [self.view addSubview:self.payTableview];
    [self paySuccessRequest];
}

#pragma mark - 订单详情、返回按钮
- (void)paySuccessFooterAction:(NSInteger)index {
    switch (index) {
        case 0: {//跳转至订单详情
            if (_teamID) {//跳转至拼团订单详情
                SpellOrderListDataModel *dataModel = [[SpellOrderListDataModel alloc] init];
                dataModel.orderId = _orderID;
                dataModel.teamid = _teamID;
                SpellOrderDetailViewController *VC = [[SpellOrderDetailViewController alloc] initWithType:0];
                VC.controllerType = 0;
                VC.listDataModel = dataModel;
                [self.navigationController pushViewController:VC animated:YES];
            } else {//跳转普通商品订单详情
                OrderDetailsViewController *VC = [[OrderDetailsViewController alloc] init];
                VC.orderID = _orderID;
                [self.navigationController pushViewController:VC animated:YES];
            }
        } break;
        case 1: {//pop
            [self.navigationController popViewControllerAnimated:YES];
        } break;
        default:
            break;
    }
}

#pragma mark - tableView
- (UITableView *)payTableview {
    if (!_payTableview) {
        _payTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) style:UITableViewStylePlain];
        _payTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTableview.backgroundColor = KTableBackgroundColor;
        _payTableview.showsVerticalScrollIndicator = NO;
        _payTableview.dataSource = self;
        _payTableview.delegate = self;
        _payTableview.estimatedRowHeight = 0;
        _payTableview.estimatedSectionHeaderHeight = 0;
        _payTableview.estimatedSectionFooterHeight = 0;
        [_payTableview registerClass:[PaySuccessStatusCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessStatusCell class])];
        [_payTableview registerClass:[PaySuccessAddressCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessAddressCell class])];
        [_payTableview registerClass:[PaySuccessPriceCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessPriceCell class])];
        [_payTableview registerClass:[PaySuccessFooterCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessFooterCell class])];
        [_payTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _payTableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultModel) {
        return 4;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return 70; break;
        case 1: return 90; break;
        case 2: return 40; break;
        case 3: return 90; break;
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
    if (self.resultModel) {
        switch (indexPath.section) {
            case 0: {
                PaySuccessStatusCell *statusCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PaySuccessStatusCell class])];
                return statusCell;
            } break;
            case 1: {
                PaySuccessAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PaySuccessAddressCell class])];
                addressCell.successAddressModel = self.resultModel.data.address;
                return addressCell;
            } break;
            case 2: {
                PaySuccessPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PaySuccessPriceCell class])];
                priceCell.successDataModel = self.resultModel.data;
                return priceCell;
            } break;
            case 3: {
                PaySuccessFooterCell *footerCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PaySuccessFooterCell class])];
                MJWeakSelf
                footerCell.backBlock = ^(NSInteger index) {
                    [weakSelf paySuccessFooterAction:index];
                };
                return footerCell;
            } break;
            default: {
                UITableViewCell *notingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
                return notingCell;
            } break;
        }
    }
    UITableViewCell *notingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return notingCell;
}


#pragma mark - 订单支付成功查询
- (void)paySuccessRequest {
    NSString *url = @"r=apply.order.pay.complete";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _orderID,@"orderid",
                              _payType,@"type", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [PaySuccessResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self.payTableview reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"后台繁忙"];
        }
    } WithFailureBlock:^(NSError *error) {
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
