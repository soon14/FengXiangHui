//
//  IntegralCreatOrderViewController.m
//  FengXH
//
//  Created by sun on 2018/8/21.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "IntegralCreatOrderViewController.h"
#import "AddressResultModel.h"
#import "ConfirmOrderStoreHeaderView.h"
#import "IntegralCreatOrderGoodsCell.h"
#import "ConfirmOrderAddressCell.h"
#import "IntegralCreatOrderResultModel.h"
#import "IntegralCreatOrderGoodsCell.h"
#import "IntegralCreatOrderPriceCell.h"
#import "AddressSelectViewController.h"
#import "IntegralCreatOrderBottomView.h"
#import "IntegralPayOrderViewController.h"

@interface IntegralCreatOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 底部 View */
@property(nonatomic , strong)IntegralCreatOrderBottomView *bottomView;
/** tableView */
@property(nonatomic , strong)UITableView *confirmTableView;
/** 默认的地址模型 */
@property(nonatomic , strong)AddressResultListModel *addressModel;
/** 创建订单 model */
@property(nonatomic , strong)IntegralCreatOrderResultModel *resultModel;

@end

@implementation IntegralCreatOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"创建订单";
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.confirmTableView];
    
    [self creditshopOrderCreatRequest];
}

#pragma mark - 底部 View
- (IntegralCreatOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[IntegralCreatOrderBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        MJWeakSelf
        _bottomView.integralPayBlock = ^(UIButton *sender) {
            [weakSelf payButtonDidClicked];
        };
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)confirmTableView {
    if (!_confirmTableView) {
        _confirmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) style:UITableViewStylePlain];
        _confirmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _confirmTableView.backgroundColor = KTableBackgroundColor;
        _confirmTableView.showsVerticalScrollIndicator = NO;
        _confirmTableView.dataSource = self;
        _confirmTableView.delegate = self;
        _confirmTableView.estimatedRowHeight = 0;
        _confirmTableView.estimatedSectionHeaderHeight = 0;
        _confirmTableView.estimatedSectionFooterHeight = 0;
        [_confirmTableView registerClass:[ConfirmOrderAddressCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderAddressCell class])];
        [_confirmTableView registerClass:[IntegralCreatOrderGoodsCell class] forCellReuseIdentifier:NSStringFromClass([IntegralCreatOrderGoodsCell class])];
        [_confirmTableView registerClass:[IntegralCreatOrderPriceCell class] forCellReuseIdentifier:NSStringFromClass([IntegralCreatOrderPriceCell class])];
        [_confirmTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nothingCell"];
    }
    return _confirmTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //地址
        return 90;
    } else if (indexPath.section == 1) {
        //商品
        return 155;
    } else if (indexPath.section == 2) {
        //商品小计+运费
        return 90;
    } return CGFLOAT_MIN;
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
    if (indexPath.section == 0) {
        // 地址栏
        ConfirmOrderAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderAddressCell class])];
        addressCell.addressModel = self. addressModel;
        return addressCell;
    } else if (indexPath.section == 1) {
        //商品栏
        IntegralCreatOrderGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralCreatOrderGoodsCell class])];
        goodsCell.resultModel = self.resultModel;
        return goodsCell;
    } else if (indexPath.section == 2) {
        //价格栏
        IntegralCreatOrderPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralCreatOrderPriceCell class])];
        priceCell.resultModel = self.resultModel;
        return priceCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nothingCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //地址选择
        AddressSelectViewController *VC = [[AddressSelectViewController alloc] init];
        VC.selectAddressModel = self.addressModel;
        MJWeakSelf
        VC.addressSelectBlock = ^(AddressResultListModel *addressModel) {
            weakSelf.addressModel = addressModel;
            //选择地址成功再次请求
            [self.confirmTableView reloadData];
        };
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - 支付按钮被点击
- (void)payButtonDidClicked {
    if (self.addressModel) {
        IntegralPayOrderViewController *VC = [[IntegralPayOrderViewController alloc] init];
        VC.addressModel = self.addressModel;
        VC.integralResultModel = self.resultModel;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        [DBHUD ShowInView:self.view withTitle:@"请选择地址"];
    }
}



#pragma mark - 创建积分商品订单
- (void)creditshopOrderCreatRequest {
    NSString *url = @"r=apply.creditshop.create";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _goodsID,@"id", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            //NSLog(@"%@",responseDic);
            self.resultModel = [IntegralCreatOrderResultModel yy_modelWithDictionary:responseDic[@"result"]];
            self.bottomView.resultModel = self.resultModel;
            
            [self.confirmTableView reloadData];
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
