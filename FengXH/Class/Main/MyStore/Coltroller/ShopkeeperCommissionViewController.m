//
//  ShopkeeperCommissionViewController.m
//  FengXH
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShopkeeperCommissionViewController.h"
#import "ShopkeeperTopTableViewCell.h"
#import "CommissionCell.h"
#import "ShopkeeperModel.h"
#import "ShopBottomCell.h"

@interface ShopkeeperCommissionViewController ()<UITableViewDelegate,UITableViewDataSource>
//tableview
@property(nonatomic , strong)UITableView *shopkeeperTableView;
//请求回来的数据放在模型里
@property(nonatomic,strong)ShopkeeperModel *dataModel;
//整理好的数据数组
@property(nonatomic,strong)NSArray *dataArr;
//底部提现按钮
@property(nonatomic,strong)UIButton *bottomBtn;

@end

@implementation ShopkeeperCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"店主佣金";
    
    [self shopkeeperDataRequest];
}
#pragma mark - 数据请求
- (void)shopkeeperDataRequest {
    NSString * urlString = @"r=apply.commission.withdraw";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            self.dataModel = [ShopkeeperModel yy_modelWithDictionary:responseDic[@"result"]];
            [self clearUpData];
            [self.view addSubview:self.shopkeeperTableView];
            [self.view addSubview:self.bottomBtn];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) {
        return 4;
    }
    else if (section==3)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGFLOAT_MIN;
    } return 10;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 130;
    }
    else if (indexPath.section==4) {
        return 120;
    }
    else
    {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ShopkeeperTopTableViewCell *topCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopkeeperTopTableViewCell class])];
        if (!topCell) {
            topCell = [[ShopkeeperTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ShopkeeperTopTableViewCell class])];
        }
        topCell.commissionLab.text=[NSString stringWithFormat:@"%@元",_dataArr[indexPath.section][indexPath.row][@"commission"]];
        return topCell;
    }
    else if (indexPath.section==4)
    {
        ShopBottomCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopBottomCell class])];
        if (!bottomCell) {
            bottomCell = [[ShopBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ShopBottomCell class])];
        }
        return bottomCell;
    }
    else
    {
        CommissionCell *commissionCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommissionCell class])];
        if (!commissionCell) {
            commissionCell = [[CommissionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CommissionCell class])];
        }
        commissionCell.commissionData=_dataArr[indexPath.section][indexPath.row];
        return commissionCell;
    }
}

#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)withdrawAction
{
    //type  提现类型 0 余额 1 微信钱包 2 支付宝 3 银行卡 （目前只支持微信钱包）
    NSString * urlString = @"r=apply.commission.apply";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"type":@1} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            KAlert(responseDic[@"message"]);
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

//整理数据
-(void)clearUpData
{
    //改变底部按钮状态
    if (_dataModel.cansettle) {
        _bottomBtn.backgroundColor=KUIColorFromHex(0xE9852B);
        _bottomBtn.userInteractionEnabled=YES;
    }
    
    //cell数据
    NSString *title=@"title";
    NSString *commission=@"commission";
    NSArray *firstArr=@[@{commission:_dataModel.commission_total}];
    NSArray *secondArr=@[@{title:@"可提现佣金",commission:_dataModel.commission_ok}];
    NSArray *thirdArr=@[@{title:@"已申请佣金",commission:_dataModel.commission_apply},@{title:@"待打款佣金",commission:_dataModel.commission_check},@{title:@"无效佣金",commission:_dataModel.commission_fail},@{title:@"成功提现佣金",commission:_dataModel.commission_pay}];
    NSArray *fourthArr=@[@{title:@"待收货佣金",commission:_dataModel.commission_wait},@{title:@"未结算佣金",commission:_dataModel.commission_lock}];
    
    self.dataArr=@[firstArr,secondArr,thirdArr,fourthArr];
    
}

#pragma mark---懒加载
- (UITableView *)shopkeeperTableView {
    if (!_shopkeeperTableView) {
        _shopkeeperTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-50-KBottomHeight) style:UITableViewStylePlain];
        _shopkeeperTableView.backgroundColor = KTableBackgroundColor;
        _shopkeeperTableView.dataSource = self;
        _shopkeeperTableView.delegate = self;
        _shopkeeperTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    }
    return _shopkeeperTableView;
}
-(UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame=CGRectMake(0, KMAINSIZE.height-50-KNaviHeight-KBottomHeight, KMAINSIZE.width, 50) ;
        _bottomBtn.backgroundColor=KUIColorFromHex(0x919191);
        _bottomBtn.userInteractionEnabled=NO;
        _bottomBtn.titleLabel.font=KFont(16);
        [_bottomBtn setTitle:@"我要提现" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(withdrawAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
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
