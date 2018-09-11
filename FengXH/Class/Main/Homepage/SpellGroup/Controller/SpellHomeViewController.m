//
//  SpellHomeViewController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellHomeViewController.h"
#import "SpellHomeTableViewCell.h"
#import "SpellHomeModel.h"
#import "LoginViewController.h"
#import "SpellGroupDetailsViewController.h"

@interface SpellHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) SpellHomeModel *spellHomeModel;
@end

@implementation SpellHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    [self setHeaderView];
    _dataArr = [NSMutableArray array];
    self.title = @"拼团首页";
    //添加返回按钮
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [backBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    [self spellHomeDataRequest];
}
- (void)backBarButtonItemAction{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}
//设置头部试图
- (void)setHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 55)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 55)];
    [img setImage:[UIImage imageNamed:@"icon_sale"]];
    [self.headerView addSubview:img];
    self.tableView.tableHeaderView = self.headerView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = KTableBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        [_tableView registerClass:[SpellHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SpellHomeTableViewCell class])];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_tableView.mj_footer.isRefreshing) {
        [self spellHomeDataRequest];
    }
}

- (void)spellHomeDataRequest {
    NSString * urlString = @"r=apply.groups";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.tableView.mj_header.isRefreshing) {
            [_dataArr removeAllObjects];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseDic[@"status"] integerValue] == 1) {
            NSArray *arr = [[responseDic objectForKey:@"result"] objectForKey:@"list"];
            
            [_dataArr addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }
        
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpellHomeTableViewCell *tabViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SpellHomeTableViewCell class])];
    tabViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tabViewCell.spellHomeModel = [SpellHomeModel yy_modelWithDictionary:_dataArr[indexPath.row]];
    
    return tabViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }else{

    self.spellHomeModel = [SpellHomeModel yy_modelWithDictionary:self.dataArr[indexPath.row]];
    NSLog(@"id = %@",_spellHomeModel.categoryID);
    SpellGroupDetailsViewController *detailsVC = [[SpellGroupDetailsViewController alloc]init];
    detailsVC.goodsId = _spellHomeModel.categoryID;
    [self.navigationController pushViewController:detailsVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
