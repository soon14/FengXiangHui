//
//  SpellActivityViewController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellActivityViewController.h"
#import "AllGoodsSearchView.h"
#import "SpellHomeModel.h"
#import "SpellHomeTableViewCell.h"
#import "SpellGroupDetailsViewController.h"
#import "LoginViewController.h"
@interface SpellActivityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
/** 搜索框 */
@property(nonatomic , strong)AllGoodsSearchView *searchView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) SpellHomeModel *spellHomeModel;
@end

@implementation SpellActivityViewController
{
    NSInteger requestPage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动列表";
    _dataArr = [NSMutableArray array];
    [self.view addSubview:self.searchView];
    [self spellHomeDataRequest];
    [self tableView];
    //添加返回按钮
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [backBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    requestPage = 1;
}
- (void)backBarButtonItemAction{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 搜索框
- (AllGoodsSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[AllGoodsSearchView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 45)];
        _searchView.searchTextField.delegate = self;
    }
    return _searchView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight-45) style:UITableViewStylePlain];
        _tableView.backgroundColor = KTableBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
        [_tableView registerClass:[SpellHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SpellHomeTableViewCell class])];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)spellHomeDataRequest {
    NSString * urlString = @"r=apply.groups.category";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"keyword":self.searchView.searchTextField.text,@"page":[NSString stringWithFormat:@"%ld",(long)requestPage]} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (requestPage == 1) {
            [_dataArr removeAllObjects];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseDic[@"status"] integerValue] == 1) {
            NSArray *arr = [[responseDic objectForKey:@"result"] objectForKey:@"list"];
            
            [_dataArr addObjectsFromArray:arr];
            
            if ([arr count] < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.tableView reloadData];
//            self.dataArr = [[responseDic objectForKey:@"result"] objectForKey:@"list"];
//            [self.tableView.mj_footer endRefreshing];
//            [self.tableView reloadData];
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
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    if (textField.text.length > 0) {

        NSLog(@"%@",self.searchView.searchTextField.text);
        [self spellHomeDataRequest];
    } else {
        [DBHUD ShowInView:self.view withTitle:@"请输入搜索关键词"];
    }
    return YES;
}
#pragma mark - 上拉加载更多
- (void)loadmore {
    requestPage++;
    [self spellHomeDataRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
