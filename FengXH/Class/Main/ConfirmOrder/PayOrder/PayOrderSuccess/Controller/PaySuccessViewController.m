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
#import "PaySuccessFooterView.h"

@interface PaySuccessViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *payTableview;
/** model */
@property(nonatomic , strong)PaySuccessResultModel *resultModel;
/** footerView */
@property(nonatomic , strong)PaySuccessFooterView *footerView;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(paySuccessBack)];
    [self.navigationItem.leftBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    
    
    [self.view addSubview:self.payTableview];
    [self paySuccessRequest];
    
}

#pragma mark - 左边返回键
- (void)paySuccessBack {
    if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[ShopCartViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    } else if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[PersonalViewController class]]) {
        NSInteger index = self.navigationController.viewControllers.count;
        [self.navigationController popToViewController:self.navigationController.viewControllers[index-3] animated:YES];
        return;
    } else if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[NHomepageViewController class]]) {
        NSInteger index = self.navigationController.viewControllers.count;
        [self.navigationController popToViewController:self.navigationController.viewControllers[index-4] animated:YES];
        return;
    } else if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[AllGoodsViewController class]]) {
        NSInteger index = self.navigationController.viewControllers.count;
        [self.navigationController popToViewController:self.navigationController.viewControllers[index-5] animated:YES];
        return;
    } else {
        NSInteger index = self.navigationController.viewControllers.count;
        [self.navigationController popToViewController:self.navigationController.viewControllers[index-4] animated:YES];
        return;
    }
}

#pragma mark - footerView
- (PaySuccessFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[PaySuccessFooterView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 80)];
        MJWeakSelf
        _footerView.backBlock = ^(UIButton *sender) {
            [weakSelf paySuccessBack];
        };
    }
    return _footerView;
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
        _payTableview.tableFooterView = self.footerView;
        [_payTableview registerClass:[PaySuccessStatusCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessStatusCell class])];
        [_payTableview registerClass:[PaySuccessAddressCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessAddressCell class])];
        [_payTableview registerClass:[PaySuccessPriceCell class] forCellReuseIdentifier:NSStringFromClass([PaySuccessPriceCell class])];
        [_payTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _payTableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultModel) {
        return 3;
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
                statusCell.successDataModel = self.resultModel.data;
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
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
            
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
