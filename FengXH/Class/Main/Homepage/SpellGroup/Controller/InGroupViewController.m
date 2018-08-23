//
//  InGroupViewController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "InGroupViewController.h"
#import "SpellMyTableViewCell.h"
#import "MyGroupModel.h"
#import "GroupDetailsViewController.h"//团详情
#import "SpellGroupDetailsViewController.h"//商品详情
@interface InGroupViewController ()<UITableViewDelegate,UITableViewDataSource,SpellMyCellDelegate>
/** 类型 */
//0 组团中 1成功 -1失败
@property(nonatomic , assign)NSInteger spellType;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataArr;
@end

@implementation InGroupViewController
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _spellType = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self groupRequest];
}
- (void)groupRequest{
    NSString * urlString = @"r=apply.groups.team";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"page":@"",@"success":[NSString stringWithFormat:@"%ld", (long)self.spellType]} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            _dataArr = [[responseDic objectForKey:@"result"] objectForKey:@"list"];
            [self tableView];
        }
        
        
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight-42) style:UITableViewStylePlain];
        _tableView.backgroundColor = KTableBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[SpellMyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SpellMyTableViewCell class])];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpellMyTableViewCell *tabViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SpellMyTableViewCell class])];
    tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tabViewCell setType:self.spellType];
    tabViewCell.myGroupModel = [MyGroupModel yy_modelWithDictionary:_dataArr[indexPath.row]];
    tabViewCell.delegate = self;
    
    return tabViewCell;
}
- (void)onItemClick:(UIButton *)btn{
    
    UIView *contentView = [btn superview];
    SpellMyTableViewCell *cell = (SpellMyTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (btn.tag == 50) {
        //再来一单
        SpellGroupDetailsViewController *vc = [[SpellGroupDetailsViewController alloc]init];
        vc.goodsId = [_dataArr[indexPath.row] objectForKey:@"goodid"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //详情
        GroupDetailsViewController *vc = [[GroupDetailsViewController alloc]init];
        [vc setType:self.spellType];
        vc.teamId = [_dataArr[indexPath.row] objectForKey:@"teamid"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupDetailsViewController *vc = [[GroupDetailsViewController alloc]init];
    vc.teamId = [_dataArr[indexPath.row] objectForKey:@"teamid"];
    [vc setType:self.spellType];
    [self.navigationController pushViewController:vc animated:YES];
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
