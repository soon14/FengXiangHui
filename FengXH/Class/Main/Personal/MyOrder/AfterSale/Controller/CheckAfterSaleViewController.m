//
//  CheckAfterSaleViewController.m
//  FengXH
//
//  Created by sun on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CheckAfterSaleViewController.h"
#import "CheckAfterSaleCell.h"
#import "CheckAfterSaleResultModel.h"
#import "CheckAfterSaleBottomView.h"
#import "OrderAfterSaleViewController.h"

@interface CheckAfterSaleViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *checkTableView;
/** model */
@property(nonatomic , strong)CheckAfterSaleResultModel *resultModel;
/** bottomView */
@property(nonatomic , strong)CheckAfterSaleBottomView *bottomView;

@end

@implementation CheckAfterSaleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self checkRefundDetailRequest:_orderID];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看进度";
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.checkTableView];
}

- (CheckAfterSaleBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CheckAfterSaleBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        MJWeakSelf
        _bottomView.viewBlock = ^(NSInteger index) {
            [weakSelf bottomViewAction:index];
        };
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)checkTableView {
    if (!_checkTableView) {
        _checkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) style:UITableViewStylePlain];
        _checkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _checkTableView.backgroundColor = KTableBackgroundColor;
        _checkTableView.showsVerticalScrollIndicator = NO;
        _checkTableView.dataSource = self;
        _checkTableView.delegate = self;
        _checkTableView.estimatedRowHeight = 0;
        _checkTableView.estimatedSectionHeaderHeight = 0;
        _checkTableView.estimatedSectionFooterHeight = 0;
        [_checkTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_checkTableView registerClass:[CheckAfterSaleCell class] forCellReuseIdentifier:NSStringFromClass([CheckAfterSaleCell class])];
    }
    return _checkTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.resultModel) {
        return [tableView cellHeightForIndexPath:indexPath model:self.resultModel keyPath:@"checkAfterSaleResultModel" cellClass:[CheckAfterSaleCell class] contentViewWidth:KMAINSIZE.width];;
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
    if (self.resultModel) {
        CheckAfterSaleCell *checkCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CheckAfterSaleCell class])];
        checkCell.checkAfterSaleResultModel = self.resultModel;
        return checkCell;
    }
    
    UITableViewCell *nothingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return nothingCell;
}

#pragma mark - 底部按钮被点击
- (void)bottomViewAction:(NSInteger)index {
    switch (index) {
        case 0: {//取消
            [self cancelRefundRequest:_orderID];
        } break;
        case 1: {//修改
            OrderAfterSaleViewController *VC = [[OrderAfterSaleViewController alloc] initWithType:0];
            VC.orderId = _orderID;
            VC.title = @"申请售后";
            [self.navigationController pushViewController:VC animated:YES];
        } break;
        default:
            break;
    }
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
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 查看进度请求
- (void)checkRefundDetailRequest:(NSString *)orderID {
    NSString *url = @"r=apply.order.refund";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              orderID,@"orderid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
//            NSLog(@"%@",responseDic[@"result"]);
            self.resultModel = [CheckAfterSaleResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self.checkTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
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
