//
//  MyTeamViewController.m
//  FengXH
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyTeamViewController.h"
#import "MyTeamTableViewCell.h"
#import "MyTeamModel.h"

@interface MyTeamViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentInteger;//记录当前页
}
// 类型
@property(nonatomic , assign)NSInteger shopkeeperType;
// tableView
@property(nonatomic , strong)UITableView *myTeamTableView;
//顶部view
@property(nonatomic,strong)UIView *topBgView;

@property(nonatomic,strong)NSMutableArray  *dataArr;

@end

@implementation MyTeamViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _shopkeeperType = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    
    [self topView];
    
    _dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self.view addSubview:self.myTeamTableView];
    
    currentInteger=1;

    [self myTeamRequestWithStatus:_shopkeeperType];

    
}
-(void)topView
{
    _topBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 40)];
    _topBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_topBgView];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 40)];
    lab.text=@"⭐️代表已成为店主";
    lab.textColor=[UIColor blackColor];
    lab.font=KFont(14);
    [_topBgView addSubview:lab];
}

-(void)myTeamRequestWithStatus:(NSInteger)leaveInteger
{
    //   0/1表示一级店主  2二级店主
    NSNumber *leaveNum;
    switch (leaveInteger) {
        case 0:
            leaveNum=@1;
            break;
        case 1:
            leaveNum=@2;
            break;
        default:
            break;
    }
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentInteger],@"level":leaveNum};
    
    NSString * urlString = @"r=apply.commission.down";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.myTeamTableView.mj_header.isRefreshing == YES) {
            [self.myTeamTableView.mj_header endRefreshing];
        }
        if (self.myTeamTableView.mj_footer.isRefreshing==YES) {
            [self.myTeamTableView.mj_footer endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            MyTeamModel *model = [MyTeamModel yy_modelWithDictionary:responseDic[@"result"]];
            if (currentInteger==1) {
                [_dataArr removeAllObjects];
                if (model.list.count>0) {
                    [_dataArr addObjectsFromArray:model.list];
                    currentInteger++;
                }
                else
                {
                    [DBHUD ShowInView:self.view withTitle:@"暂无数据"];
                }
                [_myTeamTableView reloadData];
            }
            else
            {
                [_dataArr addObjectsFromArray:model.list];
                currentInteger++;
                [_myTeamTableView reloadData];

            }
            
            if (currentInteger*model.pagesize>=model.total) {
                [self.myTeamTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.myTeamTableView.mj_header.isRefreshing == YES) {
            [self.myTeamTableView.mj_header endRefreshing];
        }
        if (self.myTeamTableView.mj_footer.isRefreshing==YES) {
            [self.myTeamTableView.mj_footer endRefreshing];
        }
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
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
    
    MyTeamTableViewCell *myTeamCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!myTeamCell) {
        myTeamCell = [[MyTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    myTeamCell.dataModel=_dataArr[indexPath.section];
    return myTeamCell;
    
    
}
-(void)headRefresh
{
    currentInteger=1;
    [self myTeamRequestWithStatus:_shopkeeperType];
    [self.myTeamTableView.mj_footer resetNoMoreData];
}
-(void)footRefresh
{
    
    [self myTeamRequestWithStatus:_shopkeeperType];
}
#pragma mark-------懒加载
-(UITableView *)myTeamTableView
{
    if (!_myTeamTableView) {
        _myTeamTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-82)];
        _myTeamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTeamTableView.backgroundColor = KTableBackgroundColor;
        _myTeamTableView.dataSource = self;
        _myTeamTableView.delegate = self;
        _myTeamTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        _myTeamTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    }
    return _myTeamTableView;
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
