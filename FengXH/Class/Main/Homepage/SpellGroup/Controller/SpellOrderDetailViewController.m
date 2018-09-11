//
//  SpellOrderDetailViewController.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailViewController.h"
#import "SpellOrderDetailModel.h"
#import "SpellOrderDetailBottomView.h"
#import "SpellOrderDetailTopCell.h"
#import "SpellOrderDetailAddressCell.h"
#import "SpellOrderDetailGoodsCell.h"
#import "SpellOrderDetailPriceCell.h"
#import "SpellOrderDetailMessageCell.h"
#import "SpellOrderCommentViewController.h"
#import "SpellOrderAfterSaleViewController.h"
#import "PayOrderViewController.h"
#import "SpellOrderListModel.h"
#import "PaySuccessViewController.h"


#define orderTopCell @"topCell"
#define orderAddressCell @"addressCell"
#define orderGoodsCell @"goodsCell"
#define orderPriceCell @"priceCell"
#define orderMessageCell @"messageCell"

@interface SpellOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *priceArr;//费用那部分的数组
    NSArray *messageArr;//底部信息部分数组
}

@property(nonatomic,strong)UITableView *orderDetailTableView;

@property(nonatomic,assign)NSInteger orderDetailType;

@property(nonatomic,strong)SpellOrderDetailModel *dataModel;

@property(nonatomic,strong)SpellOrderDetailBottomView *bottomView;

@end

@implementation SpellOrderDetailViewController

- (instancetype)initWithType:(NSInteger)type
{
    if (self = [super init]) {
        _orderDetailType = type;
    }
    return self;
}

#pragma mark - 在这个方法里将中间的控制器销毁掉
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController.viewControllers count] >= 3) {
        NSMutableArray *VCArray = self.navigationController.viewControllers.mutableCopy;
        NSMutableArray *arrRemove = [NSMutableArray array];
        for (UIViewController *VC in VCArray) {
            if ([VC isKindOfClass:[PaySuccessViewController class]]) {
                [arrRemove addObject:VC];
            }
        }
        if (arrRemove.count) {
            [VCArray removeObjectsInArray:arrRemove];
            [self.navigationController setViewControllers:VCArray animated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"订单详情";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self orderDetailRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateUI) name:@"applyAfterSaleSuccess" object:nil];
    
}
-(void)upDateUI
{
    [_bottomView removeFromSuperview];
    
    [self orderDetailRequest];
}
-(void)orderDetailRequest {
    
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_listDataModel.orderId,@"teamid":_listDataModel.teamid};
    
    NSString * urlString = @"r=apply.groups.orders.detail";
    
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            self.dataModel = [SpellOrderDetailModel yy_modelWithDictionary:responseDic[@"result"]];
            
            [self upDateData];
            
            if (!_orderDetailTableView) {
                [self.view addSubview:self.orderDetailTableView];

            }
            else
            {
                [self.orderDetailTableView reloadData];
            }
            
            [self createBottomView];


        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        if (_orderDetailType==0||_orderDetailType==-1) {
            return 1;
        }
        return 2;
    }
    else if (section==3)
    {
        return 4;
    }
    else if (section==4)
    {
        if (_orderDetailType==0||_orderDetailType==-1) {
            return 2;
        }
        return 3;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        return 70;
    }
    else if (indexPath.section==1)
    {
        return 70;
    }
    else if (indexPath.section==2)
    {
        return 130;
    }
    
    return 40;
    
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
    if (indexPath.section==0) {
        SpellOrderDetailTopCell *topCell=[tableView dequeueReusableCellWithIdentifier:orderTopCell];
        if (!topCell) {
            topCell=[[SpellOrderDetailTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderTopCell];
        }
        if (_dataModel.refundstate>0) {
            if (_orderDetailType==1) {
                topCell.statusLab.text=[NSString stringWithFormat:@"%@(退款中)",_dataModel.status];
            }
            else
            {
                topCell.statusLab.text=[NSString stringWithFormat:@"%@(售后中)",_dataModel.status];
            }
        }
        else
        {
            topCell.statusLab.text=_dataModel.status;
        }
        
        topCell.orderPriceLab.text=[NSString stringWithFormat:@"订单金额（含运费）：¥%@",_dataModel.price];
        return topCell;
    }
    else if (indexPath.section==1)
    {
        SpellOrderDetailAddressCell *addressCell=[tableView dequeueReusableCellWithIdentifier:orderAddressCell];
        if (!addressCell) {
            addressCell=[[SpellOrderDetailAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderAddressCell];
        }
        if (_orderDetailType==0||_orderDetailType==-1) {
            addressCell.type=1;
            addressCell.dataModel=_dataModel.address;
        }
        else
        {
            addressCell.type=indexPath.row;
            if (indexPath.row==1) {
                addressCell.dataModel=_dataModel.address;
            }
        }
        return addressCell;
    }
    else if (indexPath.section==2)
    {
        SpellOrderDetailGoodsCell *goodsCell=[tableView dequeueReusableCellWithIdentifier:orderGoodsCell];
        if (!goodsCell) {
            goodsCell=[[SpellOrderDetailGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderGoodsCell];
        }
        goodsCell.dataModel=_dataModel.goods;
        return goodsCell;
    }
    else if (indexPath.section==3)
    {
        SpellOrderDetailPriceCell *priceCell=[tableView dequeueReusableCellWithIdentifier:orderPriceCell];
        if (!priceCell) {
            priceCell=[[SpellOrderDetailPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderPriceCell];
        }
        priceCell.dataDic=priceArr[indexPath.row];
        if (indexPath.row==3) {
            priceCell.priceLab.textColor=KRedColor;
        }
        return priceCell;
    }
    else
    {
        SpellOrderDetailMessageCell *messageCell=[tableView dequeueReusableCellWithIdentifier:orderMessageCell];
        if (!messageCell) {
            messageCell=[[SpellOrderDetailMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderMessageCell];
        }
        NSString *str=messageArr[indexPath.row][@"title"];
        NSString *str1=[str componentsSeparatedByString:@" "][0];
        NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc] initWithString:str];
        [attStr setAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0xb2b2b2)} range:[str rangeOfString:str1]];
        messageCell.contentLab.attributedText=attStr;
        return messageCell;
    }
   
    
    
}
#pragma mark----整理数据
-(void)upDateData
{
    NSString *title=@"title";
    NSString *price=@"price";
    priceArr=@[@{title:@"商品小计",price:[NSString stringWithFormat:@"¥%@",_dataModel.maprice]},@{title:@"运费",price:[NSString stringWithFormat:@"¥%@",_dataModel.freight]},@{title:@"团长优惠",price:[NSString stringWithFormat:@"¥%@",_dataModel.discount]},@{title:@"实付费（含运费）",price:[NSString stringWithFormat:@"¥%@",_dataModel.price_cc]}];
    
    if (_orderDetailType==-1||_orderDetailType==0) {
        messageArr=@[@{title:[NSString stringWithFormat:@"订单编号  %@",_dataModel.orderno]},@{title:[NSString stringWithFormat:@"创建时间  %@",_dataModel.createtime]}];
    }
    else
    {
        messageArr=@[@{title:[NSString stringWithFormat:@"订单编号  %@",_dataModel.orderno]},@{title:[NSString stringWithFormat:@"创建时间  %@",_dataModel.createtime]},@{title:[NSString stringWithFormat:@"支付时间  %@",_dataModel.paytime]}];
    }
    
    
}

-(UITableView *)orderDetailTableView
{
    if (!_orderDetailTableView) {
        _orderDetailTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50)];
        _orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderDetailTableView.backgroundColor = KTableBackgroundColor;
        _orderDetailTableView.dataSource = self;
        _orderDetailTableView.delegate = self;
    }
    
    return _orderDetailTableView;
}
-(void)createBottomView
{
    MJWeakSelf;
    NSInteger type;
    if (_orderDetailType==3) {
        if (_dataModel.refundstate>0) {
            type=3;//已申请售后
        }
        else
        {
            type=4;//未申请售后
        }
    }
    else if (_orderDetailType==1)
    {
        if (_dataModel.refundstate>0) {
            type=5;//已申请退款
        }
        else
        {
            type=1;//未申请退款
        }
    }
    else
    {
        type=_orderDetailType;
    }
    
    _bottomView=[[SpellOrderDetailBottomView alloc]initWithType: type andFrame:CGRectMake(0, KMAINSIZE.height-KBottomHeight-50-KNaviHeight, KMAINSIZE.width, 50)];
    
    switch (type) {
        case 0:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf goToPay];
                        break;
                    case 1:
                        [weakSelf cancelOrder];
                        break;
                    default:
                        break;
                }
            };
        }
            break;
        case 1:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf applyAfterSaleWithTitle:@"申请退款"];
                        break;
                    default:
                        break;
                }
            };
            
        }
            break;
        case 2:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf sureReceive];
                        break;
                    default:
                        break;
                }
            };
        }
            break;
        case 3:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf cancelApply];
                        break;
                    case 1:
                        [weakSelf checkAfterSaleScheduleWithTitle:@"售后详情"];
                        break;
                    case 2:
                        [weakSelf deleteOrder];
                        break;
                    default:
                        break;
                }
            };
        }
            break;
        case 4:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf applyAfterSaleWithTitle:@"申请售后"];
                        break;
                    case 1:
                        [weakSelf deleteOrder];
                        break;
                    default:
                        break;
                }
            };
        }
            break;
        case 5:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf cancelApply];
                        break;
                    case 1:
                        [weakSelf checkAfterSaleScheduleWithTitle:@"退款详情"];
                        break;
                    default:
                        break;
                }
            };
        }
            break;
        case -1:
        {
            _bottomView.btnBlock = ^(NSInteger index) {
                switch (index) {
                    case 0:
                        [weakSelf deleteOrder];
                        break;
                    default:
                        break;
                }
            };
        }
            break;
        default:
            break;
    }
    
    
    [self.view addSubview:_bottomView];
        
        
}


#pragma mark----取消订单
-(void)cancelOrder
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_listDataModel.orderId};
    NSString * urlString = @"r=apply.groups.orders.cancel";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"取消成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SpellOrderUpdateData" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:_selectSectionIndex],@"type":[NSNumber numberWithInteger:_controllerType]}];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark----确认收货
-(void)sureReceive
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_listDataModel.orderId};
    NSString * urlString = @"r=apply.groups.orders.finish";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"确认收货成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SpellOrderUpdateData" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:_selectSectionIndex],@"type":[NSNumber numberWithInteger:_controllerType]}];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark----申请售后
-(void)applyAfterSaleWithTitle:(NSString *)titleStr
{
    SpellOrderAfterSaleViewController *vc=[[SpellOrderAfterSaleViewController alloc]initWithType:0];
    vc.orderId=_listDataModel.orderId;
    vc.teamId=_listDataModel.teamid;
    vc.title=titleStr;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark----取消申请
-(void)cancelApply
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_listDataModel.orderId};
    NSString * urlString = @"r=apply.groups.refund.cancel";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"取消申请成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark----查看售后进度
-(void)checkAfterSaleScheduleWithTitle:(NSString *)titleStr
{
    SpellOrderAfterSaleViewController *vc=[[SpellOrderAfterSaleViewController alloc]initWithType:1];
    vc.orderId=_listDataModel.orderId;
    vc.teamId=_listDataModel.teamid;
    vc.title=titleStr;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark----支付订单(需完善)
-(void)goToPay {
 
    PayOrderViewController *vc = [[PayOrderViewController alloc]init];
    vc.orderID = _listDataModel.orderId;
    vc.teamID = _listDataModel.teamid;
    vc.orderNum = _listDataModel.orderno;
    vc.price = [NSString stringWithFormat:@"%ld",(long)[_listDataModel.price integerValue] + [_listDataModel.freight integerValue]];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark----评价
-(void)commentOrder
{
    SpellOrderCommentViewController *vc=[[SpellOrderCommentViewController alloc]init];
    vc.orderId=_listDataModel.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark----删除订单
-(void)deleteOrder
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_listDataModel.orderId};
    NSString * urlString = @"r=apply.groups.orders.delete";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"删除成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SpellOrderUpdateData" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:_selectSectionIndex],@"type":[NSNumber numberWithInteger:_controllerType]}];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
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
