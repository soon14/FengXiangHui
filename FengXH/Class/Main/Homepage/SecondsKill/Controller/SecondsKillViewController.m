//
//  SecondsKillViewController.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SecondsKillViewController.h"
#import "KillTableViewHeaderView.h"
#import "ZQCountDownView.h"
#import "KillTableViewCell.h"
#import "SecondsKillModel.h"
#import "GoodsDetailViewController.h"
@interface SecondsKillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) KillTableViewHeaderView *killheaderView;
@property (nonatomic ,strong) SecondsKillModel *secondsKillModel;
//倒计时
@property (nonatomic ,strong) ZQCountDownView *countDownView;
@property(nonatomic , strong)NSArray *dataDic;
@property(nonatomic , strong)NSArray *dataArr;
@end

@implementation SecondsKillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日秒杀";
    
    [self secondsKillDataRequest];

    
    _countDownView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(280*KScreenRatio, 65, 85, 20)];
    _countDownView.themeColor = [UIColor blackColor];
    _countDownView.textColor = [UIColor whiteColor];
    _countDownView.textFont = KFont(12);

    [self tableView];
    
}

- (KillTableViewHeaderView *)killheaderView{
    if(!_killheaderView){
        _killheaderView = [[KillTableViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 100)];
    }
    return _killheaderView;
}

- (void)secondsKillDataRequest {
    NSString * urlString = @"r=apply.seckill";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            self.dataArr = [[responseDic objectForKey:@"result"] objectForKey:@"data"];
            _dataDic = [_dataArr[0] objectForKey:@"goods"];
            NSDictionary *dic = [_dataArr[0] objectForKey:@"time"];
            
            NSDate *datenow = [NSDate date];
            NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
            NSInteger integer = [[dic objectForKey:@"endtime"] integerValue] - timeSp;
            _countDownView.countDownTimeInterval = integer;

            [self.killheaderView setdata:[NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]]];
            
            [self.killheaderView addSubview:_countDownView];
            

            self.tableView.tableHeaderView = self.killheaderView;
            [self.tableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
    
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = KTableBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[KillTableViewCell class] forCellReuseIdentifier:NSStringFromClass([KillTableViewCell class])];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataDic.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
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

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KillTableViewCell *tabViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KillTableViewCell class])];
    tabViewCell.secondsKillModel = [SecondsKillModel yy_modelWithDictionary:_dataDic[indexPath.section]];
    return tabViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.secondsKillModel = [SecondsKillModel yy_modelWithDictionary:self.dataDic[indexPath.section]];
    //NSLog(@"id = %@|goodsid = %@",_secondsKillModel.categoryID,_secondsKillModel.goodsid);
    GoodsDetailViewController *VC = [[GoodsDetailViewController alloc]init];
    VC.goodsID = _secondsKillModel.goodsid;
    [self.navigationController pushViewController:VC animated:YES];
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
