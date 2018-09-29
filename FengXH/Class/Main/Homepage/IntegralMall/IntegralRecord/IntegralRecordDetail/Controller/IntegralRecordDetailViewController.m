//
//  IntegralRecordDetailViewController.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordDetailViewController.h"
#import "IntegralRecordDetailStatusCell.h"
#import "IntegralRecordDetailAddressCell.h"
#import "IntegralRecordDetailGoodsCell.h"
#import "IntegralRecordDetailPriceCell.h"
#import "IntegralRecordDetailTimeCell.h"
#import "IntegralRecordDetailResultModel.h"

@interface IntegralRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *detailTableView;
/** model */
@property(nonatomic , strong)IntegralRecordDetailResultModel *resultModel;

@end

@implementation IntegralRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self.view addSubview:self.detailTableView];
    [self integralRecordDetailRequest];
    
}


#pragma mark - 订单详情数据请求
- (void)integralRecordDetailRequest {
    NSString *url = @"r=apply.creditshop.logDetail";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              _orderID,@"id", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [IntegralRecordDetailResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self.detailTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
    
}

#pragma mark - tableView
- (UITableView *)detailTableView {
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) style:UITableViewStylePlain];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = KTableBackgroundColor;
        _detailTableView.showsVerticalScrollIndicator = NO;
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        _detailTableView.estimatedRowHeight = 0;
        _detailTableView.estimatedSectionHeaderHeight = 0;
        _detailTableView.estimatedSectionFooterHeight = 0;
        [_detailTableView registerClass:[IntegralRecordDetailStatusCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRecordDetailStatusCell class])];
        [_detailTableView registerClass:[IntegralRecordDetailAddressCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRecordDetailAddressCell class])];
        [_detailTableView registerClass:[IntegralRecordDetailGoodsCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRecordDetailGoodsCell class])];
        [_detailTableView registerClass:[IntegralRecordDetailPriceCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRecordDetailPriceCell class])];
        [_detailTableView registerClass:[IntegralRecordDetailTimeCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRecordDetailTimeCell class])];
        [_detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _detailTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultModel) {
        return 5;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return 85; break;
        case 1: return 90; break;
        case 2: return 80; break;
        case 3: return 100; break;
        case 4: return 95; break;
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
            IntegralRecordDetailStatusCell *statusCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRecordDetailStatusCell class])];
            return statusCell;
        } break;
        case 1: {
            IntegralRecordDetailAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRecordDetailAddressCell class])];
            return addressCell;
        } break;
        case 2: {
            IntegralRecordDetailGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRecordDetailGoodsCell class])];
            return goodsCell;
        } break;
        case 3: {
            IntegralRecordDetailPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRecordDetailPriceCell class])];
            return priceCell;
        } break;
        case 4: {
            IntegralRecordDetailTimeCell *timeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRecordDetailTimeCell class])];
            return timeCell;
        } break;
            
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.resultModel) {
        switch (indexPath.section) {
            case 0: {
                IntegralRecordDetailStatusCell *statusCell = (IntegralRecordDetailStatusCell *)cell;
                statusCell.statusModel = self.resultModel;
            } break;
            case 1: {
                IntegralRecordDetailAddressCell *addressCell = (IntegralRecordDetailAddressCell *)cell;
                addressCell.addressModel = self.resultModel.address;
            } break;
            case 2: {
                IntegralRecordDetailGoodsCell *goodsCell = (IntegralRecordDetailGoodsCell *)cell;
                goodsCell.detailResultModel = self.resultModel;
            } break;
            case 3: {
                IntegralRecordDetailPriceCell *priceCell = (IntegralRecordDetailPriceCell *)cell;
                priceCell.detailResultModel = self.resultModel;
            } break;
            case 4: {
                IntegralRecordDetailTimeCell *timeCell = (IntegralRecordDetailTimeCell *)cell;
                timeCell.detailResultModel = self.resultModel;
            } break;
                
            default:
                break;
        }
    }
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
