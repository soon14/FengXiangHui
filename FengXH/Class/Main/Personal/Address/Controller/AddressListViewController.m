//
//  AddressListViewController.m
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressResultModel.h"
#import "AddressListCell.h"
#import "AddressAddBottomView.h"
#import "AddressCreatEditViewController.h"

@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 地址Model */
@property(nonatomic , strong)AddressResultModel *addressResultModel;
/** tableView */
@property(nonatomic , strong)UITableView *addressTableView;
/** 新建地址 */
@property(nonatomic , strong)AddressAddBottomView *addBottomView;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    
    [self.view addSubview:self.addBottomView];
    [self.view addSubview:self.addressTableView];
    
    [self myAddressListRequest];
    
}

#pragma mark - 新建地址按钮
- (AddressAddBottomView *)addBottomView {
    if (!_addBottomView) {
        _addBottomView = [[AddressAddBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        MJWeakSelf
        _addBottomView.addBlock = ^(UIButton *sender) {
            [weakSelf addAddressButtonDidClicked];
        };
    }
    return _addBottomView;
}

#pragma mark - tableView
- (UITableView *)addressTableView {
    if (!_addressTableView) {
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) style:UITableViewStylePlain];
        _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _addressTableView.backgroundColor = KTableBackgroundColor;
        _addressTableView.showsVerticalScrollIndicator = NO;
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        _addressTableView.estimatedRowHeight = 0;
        _addressTableView.estimatedSectionHeaderHeight = 0;
        _addressTableView.estimatedSectionFooterHeight = 0;
    }
    return _addressTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressResultModel.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return 10; break;
        default: return CGFLOAT_MIN; break;
    }
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
    AddressListCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressListCell class])];
    if (!addressCell) {
        addressCell = [[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AddressListCell class])];
        addressCell.clickBlock = ^(NSInteger index, AddressResultListModel *addressModel) {
            [self cellClickAction:index addressResultListModel:addressModel];
        };
    }
    addressCell.addressModel = self.addressResultModel.list[indexPath.section];
    return addressCell;
}

#pragma mark - cell 点击事件
- (void)cellClickAction:(NSInteger)index addressResultListModel:(AddressResultListModel *)addressModel {
    switch (index) {
        case 0: {//设为默认
            [self setAddressDefaaultRequestWithAddressModel:addressModel];
        } break;
        case 1: {//编辑
            AddressCreatEditViewController *VC = [[AddressCreatEditViewController alloc] init];
            VC.title = @"编辑地址";
            VC.editAddressModel = addressModel;
            MJWeakSelf
            VC.savcSuccessBlock = ^(NSInteger index) {
                [weakSelf myAddressListRequest];
            };
            [self.navigationController pushViewController:VC animated:YES];
        } break;
        case 2: {//删除
            [JHSysAlertUtil presentAlertViewWithTitle:@"提示" message:@"确定删除地址？" cancelTitle:@"取消" defaultTitle:@"确定" distinct:NO cancel:nil confirm:^{
                [self deleteAddressRequestWithAddressModel:addressModel];
            }];
        } break;
        default:
            break;
    }
}

#pragma mark - 新建地址按钮被点击
- (void)addAddressButtonDidClicked {
    AddressCreatEditViewController *VC = [[AddressCreatEditViewController alloc] init];
    VC.title = @"新建地址";
    MJWeakSelf
    VC.savcSuccessBlock = ^(NSInteger index) {
        [weakSelf myAddressListRequest];
    };
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 删除地址请求
- (void)deleteAddressRequestWithAddressModel:(AddressResultListModel *)addressModel {
    NSString *url = @"r=apply.member.address_setdefault";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              addressModel.addressID,@"id",
                              @"1",@"delete", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:@"删除地址成功"];
            
            [self.addressResultModel.list removeObject:addressModel];
            
            [self.addressTableView reloadData];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 地址设为默认请求
- (void)setAddressDefaaultRequestWithAddressModel:(AddressResultListModel *)addressModel {
    NSString *url = @"r=apply.member.address_setdefault";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                                                         addressModel.addressID,@"id",
                                                                           @"1",@"isdefault", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:@"设置默认收货地址成功"];
            for (AddressResultListModel *listModel in self.addressResultModel.list) {
                listModel.isdefault = 0;
            }
            addressModel.isdefault = 1;

            [self.addressTableView reloadData];
//            [self myAddressListRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 我的地址列表请求
- (void)myAddressListRequest {
    NSString *url = @"r=apply.member.address";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.addressResultModel = [AddressResultModel yy_modelWithDictionary:responseDic[@"result"]];
            
            [self.addressTableView reloadData];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
