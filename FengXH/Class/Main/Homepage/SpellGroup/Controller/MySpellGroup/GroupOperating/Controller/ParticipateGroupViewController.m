//
//  ParticipateGroupViewController.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ParticipateGroupViewController.h"
#import "ParticipateHeaderView.h"
#import "GroupOperatingModel.h"
#import "ParticipateTableViewCell.h"
#import "ParticipateModel.h"
#import "CreateGroupOrderViewController.h"
@interface ParticipateGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic , strong) NSDictionary *dataDic;
@property (nonatomic , strong) NSArray *dataGoodsDic;
@property (nonatomic , strong) ParticipateHeaderView *headerView;

@end

@implementation ParticipateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"拼团操作";
    self.tableView.tableHeaderView = self.headerView;
    [self request];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)request{
    NSString * urlString = @"r=apply.groups.goods.fightGroups";
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [DBHUD Hiden:YES fromView:self.view];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"id":self.goodsId} WithSuccessBlock:^(NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 1) {
            
            _dataDic = [[responseDic objectForKey:@"result"] objectForKey:@"goods"];
            _dataGoodsDic = [[responseDic objectForKey:@"result"] objectForKey:@"teams"];
            self.headerView.groupOperatingModel = [GroupOperatingModel yy_modelWithDictionary:_dataDic];
            
            [self.tableView reloadData];

            
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataGoodsDic.count<1){
        return 30;
    }else{
        return 65;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_dataGoodsDic.count<1){
        return 1;
    }else{
        return _dataGoodsDic.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"groupTCell";
        if (_dataGoodsDic.count<1) {
            static NSString *ID = @"noCell";
            // 根据标识去缓存池找cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.textLabel.text = @"暂无相关团购";
            cell.textLabel.font = KFont(14);
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
            
        }else{
            [tableView registerClass:[ParticipateTableViewCell class] forCellReuseIdentifier:cellID];
            ParticipateTableViewCell *groupTCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            groupTCell.selectionStyle = UITableViewCellSelectionStyleNone;
            groupTCell.participateModel = [ParticipateModel yy_modelWithDictionary:_dataGoodsDic[indexPath.row]];
            return groupTCell;
;
        }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataGoodsDic.count > 0) {

        CreateGroupOrderViewController *vc = [[CreateGroupOrderViewController alloc]init];
        vc.type = @"groups";
        vc.goodsId = [_dataDic objectForKey:@"id"];
        vc.heads = @"";
        vc.teamid = [_dataGoodsDic[indexPath.row] objectForKey:@"teamid"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
- (ParticipateHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ParticipateHeaderView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 130)];
    }
    return _headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
