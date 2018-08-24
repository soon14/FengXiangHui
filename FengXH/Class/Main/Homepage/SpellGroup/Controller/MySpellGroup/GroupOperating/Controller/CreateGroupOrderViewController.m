//
//  CreateGroupOrderViewController.m
//  FengXH
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CreateGroupOrderViewController.h"
#import "OrdorFootView.h"
#import "GroupGoodsTableViewCell.h"
#import "GroupOperatingModel.h"
#import "GroupAddressTableViewCell.h"
#import "AddressBtnTableViewCell.h"
#import "GroupMessageTableViewCell.h"
#import "GroupPriceTableViewCell.h"
#import "AddressSelectViewController.h"//地址列表
#import "AddressResultModel.h"
#import "PayOrderViewController.h"

@interface CreateGroupOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrdorFootViewDelegate>

@property (nonatomic ,strong) OrdorFootView *footView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSDictionary *dataDic;
@property (nonatomic ,copy) NSString *freight;
/** 默认的地址模型 */
@property(nonatomic , strong)AddressResultListModel *addressModel;

@end

@implementation CreateGroupOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self myAddressListRequest];
}

#pragma mark - 我的地址请求
- (void)myAddressListRequest {
    NSString *url = @"r=apply.member.address";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {

            AddressResultModel *addressResultModel = [AddressResultModel yy_modelWithDictionary:responseDic[@"result"]];
            for (AddressResultListModel *listModel in addressResultModel.list) {
                if (listModel.isdefault == 1) {
                    self.addressModel = listModel;
                    break;
                }
            }
            
            [self operatingRequest];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
- (void)operatingRequest{
    NSString * urlString = @"r=apply.groups.orders.confirm";

    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [DBHUD Hiden:YES fromView:self.view];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"id":self.goodsId,@"type":self.type,@"heads":self.heads} WithSuccessBlock:^(NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 1) {
            
            _dataDic = [[responseDic objectForKey:@"result"] objectForKey:@"goods"];
            _freight = [[responseDic objectForKey:@"result"] objectForKey:@"freight"];
            //判断是否是单独购买
            if ([self.type  isEqual:@"single"]) {
               [self.footView setTitle:[_dataDic objectForKey:@"title"] setPrice:[_dataDic objectForKey:@"singleprice"] setFreight:[[responseDic objectForKey:@"result"] objectForKey:@"freight"] setNum:[_dataDic objectForKey:@"goodsnum"]];
            }else{
               [self.footView setTitle:[_dataDic objectForKey:@"title"] setPrice:[_dataDic objectForKey:@"groupsprice"] setFreight:[[responseDic objectForKey:@"result"] objectForKey:@"freight"] setNum:[_dataDic objectForKey:@"goodsnum"]];
            }
            [self tableView];
            [self.tableView reloadData];
            
            
        }else{
            
            [DBHUD ShowInView:self.view withTitle:[responseDic objectForKey:@"message"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 2.0秒后异步追加任务代码到主队列，并开始执行
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-50-KBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 80;
    }else if(indexPath.row == 1){
        return 130;
    }else if(indexPath.row == 2){
        return 65;
    }else{
        return 40;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = nil;
    if (indexPath.row == 0) {
        cellID = @"addressCell";
    }else if (indexPath.row == 1) {
        cellID = @"goodsCell";
    }else if (indexPath.row == 2){
        cellID = @"messageCell";
    }else{
        cellID = @"priceCell";
    }
    if (indexPath.row == 0) {
        if (!self.addressModel) {
            [tableView registerClass:[AddressBtnTableViewCell class] forCellReuseIdentifier:cellID];
            AddressBtnTableViewCell *addressCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return addressCell;
            
        }else{
            
            [tableView registerClass:[GroupAddressTableViewCell class] forCellReuseIdentifier:cellID];
            GroupAddressTableViewCell *addressCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
            addressCell.addressResultListModel = self.addressModel;
            
            return addressCell;
        }
    
        
    }else if (indexPath.row == 1){
        [tableView registerClass:[GroupGoodsTableViewCell class] forCellReuseIdentifier:cellID];
        GroupGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        goodsCell.type = self.type;
        goodsCell.groupOperatingModel = [GroupOperatingModel yy_modelWithDictionary:_dataDic];
        
        return goodsCell;
    }else if (indexPath.row == 2){
        [tableView registerClass:[GroupMessageTableViewCell class] forCellReuseIdentifier:cellID];
        GroupMessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return messageCell;
    }else{
        [tableView registerClass:[GroupPriceTableViewCell class] forCellReuseIdentifier:cellID];
        GroupPriceTableViewCell *priceCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        priceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"商品小计",@"运费"];
        NSArray *arr1;
        if ([self.type  isEqual:@"single"]){
            arr1 = @[[_dataDic objectForKey:@"singleprice"],_freight];
        }else{
            arr1 = @[[_dataDic objectForKey:@"groupsprice"],_freight];
        }
        [priceCell setTitle:arr[indexPath.row-3] setPrice:arr1[indexPath.row-3]];


        return priceCell;
    }
    
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //NSLog(@"选择地址");
        AddressSelectViewController *VC = [[AddressSelectViewController alloc] init];
        VC.selectAddressModel = self.addressModel;
        MJWeakSelf
        VC.addressSelectBlock = ^(AddressResultListModel *addressModel) {
            weakSelf.addressModel = addressModel;
            //选择地址成功再次请求
            [self operatingRequest];
        };
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}
- (OrdorFootView *)footView{
    if (!_footView) {
        _footView = [[OrdorFootView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-50-KNaviHeight-KBottomHeight, KMAINSIZE.width, 50+KBottomHeight)];
        _footView.fdelegate = self;
        [self.view addSubview:_footView];
    }
    return _footView;
}
#pragma mark -------支付按钮
- (void)onItemClicks{
    if (self.addressModel) {
        [self groupsOrderConfirmRequest];
    } else {
        [DBHUD ShowInView:self.view withTitle:@"请添加收货地址"];
    }
}

#pragma mark - 拼团订单提交请求
- (void)groupsOrderConfirmRequest {
    NSString *url = @"r=apply.groups.orders.confirm";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              self.goodsId,@"id",
                              _type,@"type",
                              _heads,@"heads",
                              _teamid,@"teamid",
                              self.addressModel.addressID,@"aid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            PayOrderViewController *VC = [[PayOrderViewController alloc] init];
            VC.orderID = responseDic[@"result"][@"order"][@"id"];
            VC.teamID = responseDic[@"result"][@"teamid"];
            VC.orderNum = responseDic[@"result"][@"order"][@"openid"];
            VC.price = responseDic[@"result"][@"order"][@"price"];
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
            
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
