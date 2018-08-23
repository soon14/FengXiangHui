//
//  PhoneTopUpViewController.m
//  FengXH
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneTopUpViewController.h"
#import "PhoneTopUpTableViewCell.h"
@interface PhoneTopUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NSDictionary *dataDic;
@end

@implementation PhoneTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
}
- (void)request{
    NSString *url = @"r=apply.hlapi.change";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":token,@"Birthday":@"1"} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            _dataDic = [responseDic objectForKey:@"result"];
            [self tableView];
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataDic.count-1;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 220;
    
}
    
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"titleCell";
    [tableView registerClass:[PhoneTopUpTableViewCell class] forCellReuseIdentifier:cellID];
    PhoneTopUpTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [titleCell setTitle:[_dataArr[indexPath.row] objectForKey:@"phoneNum"] andTime:[_dataArr[indexPath.row] objectForKey:@"time"]];
    
    NSString *str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSDictionary *dic = [_dataDic objectForKey:str];
    [titleCell setTitle:[dic objectForKey:@"Content"] andTime:[dic objectForKey:@"CreateTime"] andDateStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"DateStatus"]]];
    
    
    return titleCell;
    
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
