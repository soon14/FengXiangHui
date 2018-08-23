//
//  DetailViewController.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "DetailViewController.h"
#import "CommissionDetailCell.h"
#import "CommissionDetailModel.h"
#import "WithdrawDetailModel.h"
#import "WithdrawDetailCell.h"
#import "DetailBaseViewController.h"
#import "DetailTopView.h"


@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentInteger;//记录当前页
}
// 类型
@property(nonatomic , assign)NSInteger type;
// tableView
@property(nonatomic , strong)UITableView *detailTableView;

@property(nonatomic,strong)NSMutableArray  *dataArr;

@end

@implementation DetailViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self.view addSubview:self.detailTableView];
    
    currentInteger=1;
    
    if (_detailType==0) {
        [self commissionDetailRequestWithStatus:_type];
    }
    else
    {
        [self withdrawDetailRequestWithStatus:_type];
    }
    
}

-(void)withdrawDetailRequestWithStatus:(NSInteger)statusInteger
{
    //状态status  所有/不传 1/待审核 2/待打款 3/已打款 4/无效
    NSNumber *statusNum;
    switch (statusInteger) {
        case 0:
            statusNum=nil;
            break;
        case 1:
            statusNum=@1;
            break;
        case 2:
            statusNum=@2;
            break;
        case 3:
            statusNum=@3;
            break;
        case 4:
            statusNum=@4;
            break;
        default:
            break;
    }
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSDictionary *paramsDic;
    if (!statusNum) {
        paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentInteger]};
    }
    else
    {
        paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentInteger],@"status":statusNum};
    }
    NSString * urlString = @"r=apply.commission.log";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.detailTableView.mj_header.isRefreshing == YES) {
            [self.detailTableView.mj_header endRefreshing];
        }
        if (self.detailTableView.mj_footer.isRefreshing==YES) {
            [self.detailTableView.mj_footer endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            WithdrawDetailModel *model = [WithdrawDetailModel yy_modelWithDictionary:responseDic[@"result"]];
            if (currentInteger==1) {
                [_dataArr removeAllObjects];
                DetailBaseViewController *parentVC=(DetailBaseViewController *)self.parentViewController;
                parentVC.topButtonView.commissionLab.text=[NSString stringWithFormat:@"佣金：%@元",model.commissioncount];
                if (model.list.count>0) {
                    [_dataArr addObjectsFromArray:model.list];
                    currentInteger++;
                }
                else
                {
                    [DBHUD ShowInView:self.view withTitle:@"暂无数据"];
                }
                [_detailTableView reloadData];
            }
            else
            {
                
                [_dataArr addObjectsFromArray:model.list];
                currentInteger++;
                [_detailTableView reloadData];

            }
            
            if (currentInteger*model.pagesize>=model.total) {
                [self.detailTableView.mj_footer endRefreshingWithNoMoreData];
            }

            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.detailTableView.mj_header.isRefreshing == YES) {
            [self.detailTableView.mj_header endRefreshing];
        }
        if (self.detailTableView.mj_footer.isRefreshing==YES) {
            [self.detailTableView.mj_footer endRefreshing];
        }
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

-(void)commissionDetailRequestWithStatus:(NSInteger)statusInteger
{
    //状态status 所有/不传 0/待付款 1/已付款 3/已完成
    NSNumber *statusNum;
    switch (statusInteger) {
        case 0:
            statusNum=nil;
            break;
        case 1:
            statusNum=@0;
            break;
        case 2:
            statusNum=@1;
            break;
        case 3:
            statusNum=@3;
            break;
        default:
            break;
    }
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSDictionary *paramsDic;
    if (!statusNum) {
        paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentInteger]};
    }
    else
    {
        paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentInteger],@"status":statusNum};
    }
    NSString * urlString = @"r=apply.commission.order";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.detailTableView.mj_header.isRefreshing == YES) {
            [self.detailTableView.mj_header endRefreshing];
        }
        if (self.detailTableView.mj_footer.isRefreshing==YES) {
            [self.detailTableView.mj_footer endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            CommissionDetailModel *model = [CommissionDetailModel yy_modelWithDictionary:responseDic[@"result"]];
            if (currentInteger==1) {
                [_dataArr removeAllObjects];
                DetailBaseViewController *parentVC=(DetailBaseViewController *)self.parentViewController;
                parentVC.topButtonView.commissionLab.text=[NSString stringWithFormat:@"佣金：%@元",model.commission_total];
                if (model.list.count>0) {
                    [_dataArr addObjectsFromArray:model.list];
                    currentInteger++;
                }
                else
                {
                    [DBHUD ShowInView:self.view withTitle:@"暂无数据"];
                }
                [_detailTableView reloadData];
            }
            else
            {
                [_dataArr addObjectsFromArray:model.list];
                currentInteger++;
                [_detailTableView reloadData];
          
            }
            
            if (currentInteger*model.pagesize>=model.totalcount) {
                [self.detailTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.detailTableView.mj_header.isRefreshing == YES) {
            [self.detailTableView.mj_header endRefreshing];
        }
        if (self.detailTableView.mj_footer.isRefreshing==YES) {
            [self.detailTableView.mj_footer endRefreshing];
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
    if (_detailType==0) {
        CommissionDetailListModel *model=_dataArr[indexPath.section];
        return 60*model.order_goods.count+205;
    }
    return 180;
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
    if (_detailType==0) {
        CommissionDetailCell *commissionCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!commissionCell) {
            commissionCell = [[CommissionDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        commissionCell.dataModel=_dataArr[indexPath.section];
        return commissionCell;
    }
    else
    {
        WithdrawDetailCell *withdrawCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!withdrawCell) {
            withdrawCell = [[WithdrawDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        withdrawCell.dataModel=_dataArr[indexPath.section];
        return withdrawCell;
    }
   
    
    
}
-(void)headRefresh
{
    currentInteger=1;
    if (_detailType==0) {
        [self commissionDetailRequestWithStatus:_type];
    }
    else
    {
        [self withdrawDetailRequestWithStatus:_type];
    }
    [self.detailTableView.mj_footer resetNoMoreData];
}
-(void)footRefresh
{
    if (_detailType==0) {
        [self commissionDetailRequestWithStatus:_type];
    }
    else
    {
        [self withdrawDetailRequestWithStatus:_type];
    }
}
#pragma mark-------懒加载
-(UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-82)];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = KTableBackgroundColor;
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        _detailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        _detailTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    }
    return _detailTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
