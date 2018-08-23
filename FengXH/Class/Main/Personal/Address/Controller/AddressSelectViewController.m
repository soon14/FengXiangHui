//
//  AddressSelectViewController.m
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressSelectViewController.h"
#import "AddressAddBottomView.h"
#import "AddressSelectCell.h"
#import "AddressCreatEditViewController.h"

@interface AddressSelectViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 地址Model */
@property(nonatomic , strong)AddressResultModel *addressResultModel;
/** tableView */
@property(nonatomic , strong)UITableView *addressTableView;
/** 新建地址 */
@property(nonatomic , strong)AddressAddBottomView *addBottomView;

@end

@implementation AddressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址选择";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        _addressTableView.backgroundColor = [UIColor whiteColor];
        _addressTableView.showsVerticalScrollIndicator = NO;
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        [_addressTableView registerClass:[AddressSelectCell class] forCellReuseIdentifier:NSStringFromClass([AddressSelectCell class])];
    }
    return _addressTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressResultModel.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressSelectCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressSelectCell class])];
    addressCell.editBlock = ^(AddressResultListModel *addressModel) {
        [self editButtonDidClicked:addressModel];
    };
    addressCell.addressModel = self.addressResultModel.list[indexPath.row];
    return addressCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.addressSelectBlock) {
        self.addressSelectBlock(self.addressResultModel.list[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 地址编辑被点击
- (void)editButtonDidClicked:(AddressResultListModel *)addressModel {
    AddressCreatEditViewController *VC = [[AddressCreatEditViewController alloc] init];
    VC.title = @"编辑地址";
    VC.editAddressModel = addressModel;
    MJWeakSelf
    VC.savcSuccessBlock = ^(NSInteger index) {
        [weakSelf myAddressListRequest];
    };
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 新建地址按钮被点击
- (void)addAddressButtonDidClicked {
    AddressCreatEditViewController *VC = [[AddressCreatEditViewController alloc] init];
    MJWeakSelf
    VC.savcSuccessBlock = ^(NSInteger index) {
        [weakSelf myAddressListRequest];
    };
    [self.navigationController pushViewController:VC animated:YES];
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
            
            //被选中判断
            for (AddressResultListModel *listModel in self.addressResultModel.list) {
                if ([self.selectAddressModel.addressID isEqualToString:listModel.addressID]) {
                    listModel.selected = YES;
                    break;
                }
            }
            
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
