//
//  PersonalBindingPhoneNumberViewController.m
//  FengXH
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalBindingPhoneNumberViewController.h"
#import "PersonalSettingMessageCell.h"
#import "NSObject+CountDown.h"


@interface PersonalBindingPhoneNumberViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *titleArr;//标题数组
    
    NSArray *placeholderArr;//placeholder数组
}

@property(nonatomic,strong)UITableView *phoneNumberTableView;

@end

@implementation PersonalBindingPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"绑定手机号";
    
    titleArr=@[@"手机号",@"短信验证码",@"登录密码",@"确认密码"];
    
    placeholderArr=@[@"请输入手机号",@"5位验证码",@"请输入登录密码",@"请输入确认密码"];
    
    [self.view addSubview:self.phoneNumberTableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGFLOAT_MIN;
    } return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 70;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] init];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, KMAINSIZE.width-20, 40)];
    btn.backgroundColor=KRedColor;
    [btn setTitle:@"绑定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bindingAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=4;
    btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    btn.layer.shouldRasterize = YES;
    [view addSubview:btn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PersonalSettingMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSettingMessageCell class])];
    if (!messageCell) {
        messageCell = [[PersonalSettingMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSettingMessageCell class])];
    }
    UIButton *btn=[messageCell viewWithTag:100];
    if (indexPath.row==1) {
        if (!btn) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [btn.titleLabel setFont:KFont(16)];
            btn.tag=100;
            btn.titleLabel.textAlignment=NSTextAlignmentRight;
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            btn.titleLabel.adjustsFontSizeToFitWidth=YES;
            [btn addTarget:self action:@selector(getSmsCodeAction:) forControlEvents:UIControlEventTouchUpInside];
            [messageCell addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-10);
                make.width.mas_offset(150);
                make.height.mas_offset(20);
                make.centerY.mas_equalTo(messageCell.contentView.mas_centerY);
            }];
        }
        else
        {
            btn.hidden=NO;
        }
        
    }
    else
    {
        btn.hidden=YES;
        
    }
    messageCell.titleLab.text=titleArr[indexPath.row];
 messageCell.contentTextField.placeholder=placeholderArr[indexPath.row];
    if (indexPath.row==0) {
        messageCell.contentTextField.text=_phoneNum;
    }
    else
    {
        messageCell.contentTextField.text=@"";
    }
    
    
    return messageCell;
}
#pragma mark----绑定请求
-(void)bindingAction
{
    [self.view endEditing:YES];
    PersonalSettingMessageCell *phoneCell=[self.phoneNumberTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PersonalSettingMessageCell *codeCell=[self.phoneNumberTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    PersonalSettingMessageCell *passwordCell1=[self.phoneNumberTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    PersonalSettingMessageCell *passwordCell2=[self.phoneNumberTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if (codeCell.contentTextField.text.length<5) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的验证码"];
        return;
    }
    
    if (passwordCell1.contentTextField.text.length<6||passwordCell1.contentTextField.text.length>16) {
        [DBHUD ShowInView:self.view withTitle:@"密码要在6-16位之间"];
        return;
    }
    
    if (![passwordCell1.contentTextField.text isEqualToString:passwordCell2.contentTextField.text]) {
        [DBHUD ShowInView:self.view withTitle:@"两次密码输入不一致"];
        return;
    }
    
    
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString * urlString = @"r=apply.personal.bind";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    NSDictionary *paramsDic=@{@"token":tokenStr,@"mobile":phoneCell.contentTextField.text,@"verifycode":codeCell.contentTextField.text,@"pwd":passwordCell1.contentTextField.text};
    
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"绑定成功"];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark----获取短信验证码
- (void)getSmsCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    PersonalSettingMessageCell *phoneCell=[self.phoneNumberTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([phoneCell.contentTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
        return;
    }
    
    [self getSmsCodeRequestWithPhoneNum:phoneCell.contentTextField.text];
}
- (void)getSmsCodeRequestWithPhoneNum:(NSString *)phoneStr {
    PersonalSettingMessageCell *codeCell=[self.phoneNumberTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UIButton *codeBtn=[codeCell viewWithTag:100];
    NSString * urlString = @"r=apply.account.verifycode2";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     phoneStr,@"mobile",
                                     @"sms_reg",@"temp",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
            [codeBtn countDownTime:60 countDownBlock:^(NSUInteger timer) {
                [codeBtn setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
                [codeBtn setTitle:[NSString stringWithFormat:@"%zd (s)后重发", (long)timer] forState:UIControlStateNormal];
                codeBtn.enabled = NO;
            } outTimeBlock:^{
                [codeBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
                [codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                codeBtn.enabled = YES;
            }];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

-(UITableView *)phoneNumberTableView
{
    if (!_phoneNumberTableView) {
        _phoneNumberTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStyleGrouped];
        _phoneNumberTableView.backgroundColor=KTableBackgroundColor;
        _phoneNumberTableView.delegate=self;
        _phoneNumberTableView.dataSource=self;
        _phoneNumberTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _phoneNumberTableView;
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
