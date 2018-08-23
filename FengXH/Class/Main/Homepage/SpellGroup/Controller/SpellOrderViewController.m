//
//  SpellOrderViewController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderViewController.h"
#import "SpellOrderListModel.h"
#import "SpellOrderObligationCell.h"
#import "SpellOrderOverhangCell.h"
#import "SpellOrderWaitReceiveCell.h"
#import "SpellOrderCompletedCell.h"
#import "SpellOrderCanceledCell.h"
#import "SpellOrderDetailViewController.h"
#import "SpellOrderCommentViewController.h"
#import "PayOrderViewController.h"


#define orderCanceled @"canceledCell"
#define orderObligation @"obligationCell"
#define orderOverhang @"overhangCell"
#define orderCompleted @"completedCell"
#define orderWaitReceive @"waitReceiveCell"

@interface SpellOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSInteger currentPageInteger;//记录当前页
    NSInteger currentSectionInteger;//记录当前操作的区
}
// 类型
@property(nonatomic , assign)NSInteger orderType;
// tableView
@property(nonatomic , strong)UITableView *orderTableView;

@property(nonatomic,strong)NSMutableArray  *dataArr;

@end

@implementation SpellOrderViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _orderType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData:) name:@"updateData" object:nil];
    
    _dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self.view addSubview:self.orderTableView];
    
    currentPageInteger=1;
    
    [self orderRequestWithStatus:_orderType];
    
}
-(void)updateData:(NSNotification *)noti
{
    NSDictionary *dic=noti.userInfo;
    
    if (_orderType==[dic[@"type"] integerValue]) {
        
        [_dataArr removeObjectAtIndex:[dic[@"index"] integerValue]];
        
        [_orderTableView reloadData];
    }
    
}
-(void)orderRequestWithStatus:(NSInteger)statusInteger
{
    //   状态    1待付款  2待发货（已付款） 3待收货 4已完成
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
        paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentPageInteger]};
    }
    else
    {
        paramsDic=@{@"token":tokenStr,@"page":[NSNumber numberWithInteger:currentPageInteger],@"status":statusNum};
    }
    
    NSString * urlString = @"r=apply.groups.orders";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.orderTableView.mj_header.isRefreshing == YES) {
            [self.orderTableView.mj_header endRefreshing];
        }
        if (self.orderTableView.mj_footer.isRefreshing==YES) {
            [self.orderTableView.mj_footer endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            SpellOrderListModel *model = [SpellOrderListModel yy_modelWithDictionary:responseDic[@"result"]];
            if (currentPageInteger==1) {
                [_dataArr removeAllObjects];
                if (model.list.count>0) {
                    [_dataArr addObjectsFromArray:model.list];
                    currentPageInteger++;
                }
                else
                {
                    [DBHUD ShowInView:self.view withTitle:@"暂无数据"];
                }
                [_orderTableView reloadData];
            }
            else
            {
                [_dataArr addObjectsFromArray:model.list];
                currentPageInteger++;
                [_orderTableView reloadData];

            }
            
            if (currentPageInteger*model.pagesize>=model.total) {
                [self.orderTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.orderTableView.mj_header.isRefreshing == YES) {
            [self.orderTableView.mj_header endRefreshing];
        }
        if (self.orderTableView.mj_footer.isRefreshing==YES) {
            [self.orderTableView.mj_footer endRefreshing];
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
    
    if (_orderType==0) {
        SpellOrderListDataModel *model=_dataArr[indexPath.section];
        if (model.status==1) {
            return 150;
        }
        return 200;
    }
    else if (_orderType==2)
    {
        return 150;
    }
    return 200;
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
    
    MJWeakSelf;

    if (_orderType==0) {
        //全部  -1已取消  0待付款  1待发货（已付款） 3已完成
        
        SpellOrderListDataModel *model=_dataArr[indexPath.section];

        if (model.status==-1) {
            SpellOrderCanceledCell *canceledCell = [tableView dequeueReusableCellWithIdentifier:orderCanceled];
            if (!canceledCell) {
                canceledCell = [[SpellOrderCanceledCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCanceled];
                
            }
            canceledCell.dataModel=_dataArr[indexPath.section];
            canceledCell.btnClickBlock = ^{
                [weakSelf deleteOrderWithIndex:indexPath.section];
            };
            return canceledCell;
        }
        else if (model.status==0)
        {
            SpellOrderObligationCell *obligationCell = [tableView dequeueReusableCellWithIdentifier:orderObligation];
            if (!obligationCell) {
                obligationCell = [[SpellOrderObligationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderObligation];
                
            }
            obligationCell.dataModel=_dataArr[indexPath.section];
            obligationCell.btnClickBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf goToPayWithIndex:indexPath.section];
                        break;
                    case 1:
                        [weakSelf cancelOrderWithIndex:indexPath.section];
                        break;
                    default:
                        break;
                }
            };
            return obligationCell;
        }
        else if (model.status==1)
        {
            SpellOrderOverhangCell *overhangCell = [tableView dequeueReusableCellWithIdentifier:orderOverhang];
            if (!overhangCell) {
                overhangCell = [[SpellOrderOverhangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderOverhang];
                
            }
            overhangCell.dataModel=_dataArr[indexPath.section];
            return overhangCell;
        }
        else if (model.status==3)
        {
            SpellOrderCompletedCell *completedCell = [tableView dequeueReusableCellWithIdentifier:orderCompleted];
            if (!completedCell) {
                completedCell = [[SpellOrderCompletedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCompleted];
                
            }
            completedCell.dataModel=_dataArr[indexPath.section];
            completedCell.btnClickBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf commentOrderWithOrderId:model.orderId];
                        break;
                    case 1:
                        [weakSelf deleteOrderWithIndex:indexPath.section];
                        break;
                    case 2:
//                        [weakSelf checkLogisticsWithOrderId:model.orderId];
                        break;
                    default:
                        break;
                }
            };
            return completedCell;
        }
        else
        {
            SpellOrderWaitReceiveCell *waitReceiveCell = [tableView dequeueReusableCellWithIdentifier:orderWaitReceive];
            if (!waitReceiveCell) {
                waitReceiveCell = [[SpellOrderWaitReceiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderWaitReceive];
                
            }
            waitReceiveCell.dataModel=_dataArr[indexPath.section];
            waitReceiveCell.btnClickBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf sureReceiveWithIndex:indexPath.section];
                        break;
                    case 1:
//                        [weakSelf checkLogisticsWithOrderId:model.orderId];
                        break;
                    default:
                        break;
                }
            };
            return waitReceiveCell;
        }
        
    }
    else if (_orderType==1)
    {
        //SpellOrderListDataModel *model=_dataArr[indexPath.section];
        //待付款
        SpellOrderObligationCell *obligationCell = [tableView dequeueReusableCellWithIdentifier:orderObligation];
        if (!obligationCell) {
            obligationCell = [[SpellOrderObligationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderObligation];
            
        }
        obligationCell.dataModel=_dataArr[indexPath.section];
        obligationCell.btnClickBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                    [weakSelf goToPayWithIndex:indexPath.section];
                    break;
                case 1:
                    [weakSelf cancelOrderWithIndex:indexPath.section];
                    break;
                default:
                    break;
            }
        };
        return obligationCell;
    }
    else if (_orderType==2)
    {
        //待发货
        SpellOrderOverhangCell *overhangCell = [tableView dequeueReusableCellWithIdentifier:orderOverhang];
        if (!overhangCell) {
            overhangCell = [[SpellOrderOverhangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderOverhang];
            
        }
        overhangCell.dataModel=_dataArr[indexPath.section];
        return overhangCell;
    }
    else if (_orderType==3)
    {
//        SpellOrderListDataModel *model=_dataArr[indexPath.section];
        //待收货
        SpellOrderWaitReceiveCell *waitReceiveCell = [tableView dequeueReusableCellWithIdentifier:orderWaitReceive];
        if (!waitReceiveCell) {
            waitReceiveCell = [[SpellOrderWaitReceiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderWaitReceive];
            
        }
        waitReceiveCell.dataModel=_dataArr[indexPath.section];
        waitReceiveCell.btnClickBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                    [weakSelf sureReceiveWithIndex:indexPath.section];
                    break;
                case 1:
//                    [weakSelf checkLogisticsWithOrderId:model.orderId];
                    break;
                default:
                    break;
            }
        };
        return waitReceiveCell;
    }
    else
    {
        SpellOrderListDataModel *model=_dataArr[indexPath.section];
        //已完成
        SpellOrderCompletedCell *completedCell = [tableView dequeueReusableCellWithIdentifier:orderCompleted];
        if (!completedCell) {
            completedCell = [[SpellOrderCompletedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCompleted];
            
        }
        completedCell.dataModel=_dataArr[indexPath.section];
        completedCell.btnClickBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                    [weakSelf commentOrderWithOrderId:model.orderId];
                    break;
                case 1:
                    [weakSelf deleteOrderWithIndex:indexPath.section];
                    break;
                case 2:
//                    [weakSelf checkLogisticsWithOrderId:model.orderId];
                    break;
                default:
                    break;
            }
        };
        return completedCell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpellOrderListDataModel *model=_dataArr[indexPath.section];
    NSInteger type;
    if (_orderType==0) {
        type=model.status;
    }
    else
    {
        type=_orderType-1;
    }
    SpellOrderDetailViewController *vc=[[SpellOrderDetailViewController alloc]initWithType:type];
    vc.selectSectionIndex=indexPath.section;
    vc.orderId=model.orderId;
    vc.teamId=model.teamid;
    vc.controllerType=_orderType;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark----tableview 上拉加载 下拉刷新
-(void)headRefresh
{
    currentPageInteger=1;
    [self orderRequestWithStatus:_orderType];
    [self.orderTableView.mj_footer resetNoMoreData];
}
-(void)footRefresh
{
    
    [self orderRequestWithStatus:_orderType];
}
#pragma mark-------删除订单
-(void)deleteOrderWithIndex:(NSInteger)sectionIndex
{
    currentSectionInteger=sectionIndex;
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"确认删除订单吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag=100;
    [alertView show];
}
-(void)deleteOrderRequest
{
    
    SpellOrderListDataModel *model=_dataArr[currentSectionInteger];

    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":model.orderId};
    NSString * urlString = @"r=apply.groups.orders.delete";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"删除成功"];
            [_dataArr removeObjectAtIndex:currentSectionInteger];
            [self.orderTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark------取消订单
-(void)cancelOrderWithIndex:(NSInteger)sectionIndex
{
    currentSectionInteger=sectionIndex;
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"确认取消订单吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag=200;
    [alertView show];
}
-(void)cancelOrderRequest
{
    SpellOrderListDataModel *model=_dataArr[currentSectionInteger];

    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":model.orderId};
    NSString * urlString = @"r=apply.groups.orders.cancel";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"取消成功"];
            [_dataArr removeObjectAtIndex:currentSectionInteger];
            [self.orderTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark------去付款(需完善)
-(void)goToPayWithIndex:(NSInteger)sectionIndex
{
    NSLog(@"去付款");
    SpellOrderListDataModel *model=_dataArr[sectionIndex];
//    model.orderId  订单id
//    model.teamid    参团id
    PayOrderViewController *vc = [[PayOrderViewController alloc]init];
    vc.orderID = model.orderId;
    vc.teamID = model.teamid;
    vc.orderNum = model.orderno;
    vc.price = [NSString stringWithFormat:@"%ld",[model.price integerValue] + [model.freight integerValue]];
    [self.navigationController pushViewController:vc animated:YES];

    
}
#pragma mark------评论
-(void)commentOrderWithOrderId:(NSString *)orderId
{
    SpellOrderCommentViewController *vc=[[SpellOrderCommentViewController alloc] init];
    vc.orderId=orderId;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//#pragma mark-----查看物流
//-(void)checkLogisticsWithOrderId:(NSString *)orderId
//{
//    NSLog(@"查看物流");
//}
#pragma mark-----确认收货
-(void)sureReceiveWithIndex:(NSInteger)sectionIndex
{
    SpellOrderListDataModel *model=_dataArr[sectionIndex];

    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":model.orderId};
    NSString * urlString = @"r=apply.groups.orders.finish";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"确认收货成功"];
            [_dataArr removeObjectAtIndex:sectionIndex];
            [self.orderTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark-----UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (alertView.tag==100) {
            //删除订单
            [self deleteOrderRequest];
        }
        else if (alertView.tag==200)
        {
            [self cancelOrderRequest];
        }
    }
    
}
#pragma mark-------懒加载
-(UITableView *)orderTableView
{
    if (!_orderTableView) {
        _orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-42)];
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.backgroundColor = KTableBackgroundColor;
        _orderTableView.dataSource = self;
        _orderTableView.delegate = self;
        _orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        _orderTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    }
    return _orderTableView;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
