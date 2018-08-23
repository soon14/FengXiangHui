//
//  PersonalSettingViewController.m
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalSettingViewController.h"
#import "PersonalSettingUserHeaderCell.h"
#import "PersonalSettingPhoneCell.h"
#import "PersonalSettingMessageCell.h"
#import "PersonalSettingModel.h"
#import "YNDatePickerView.h"
#import "YJLocationPicker.h"
#import "PersonalMessageViewController.h"
#import "PersonalBindingPhoneNumberViewController.h"


@interface PersonalSettingViewController ()<UITableViewDelegate,UITableViewDataSource,YNDatePickerViewDelegate>

{
    NSString *birthDate;//出生日期
    NSString *addressStr;
}

@property(nonatomic,strong)UITableView *settingTableView;

@property(nonatomic,strong)PersonalSettingModel *dataModel;

@property(nonatomic,strong)NSArray *messageDataArr;//第二个区的数据

@end

@implementation PersonalSettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self requestPersonalMessageDada];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"用户编辑";
    
}
#pragma mark - 个人信息数据请求
- (void)requestPersonalMessageDada {
    NSString * urlString = @"r=apply.personal.info";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        //        NSLog(@"%@",responseDic);
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.dataModel = [PersonalSettingModel yy_modelWithDictionary:responseDic[@"result"]];
            birthDate=[NSString stringWithFormat:@"%@-%@-%@",_dataModel.birthyear,_dataModel.birthmonth,_dataModel.birthday];
            addressStr=[NSString stringWithFormat:@"%@-%@",_dataModel.province,_dataModel.city];
            [self makeupData];
            if (!_settingTableView) {
                [self.view addSubview:self.settingTableView];
            }
            else
            {
                [self.settingTableView reloadData];
            }
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==2) {
        return 70;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section==2) {
        UIView *view=[[UIView alloc] init];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, KMAINSIZE.width-20, 40)];
        btn.backgroundColor=KRedColor;
        [btn setTitle:@"确认修改" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(saveSettingAction) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius=4;
        btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        btn.layer.shouldRasterize = YES;
        [view addSubview:btn];
        return view;
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 80;
    }
    else
    {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        PersonalSettingUserHeaderCell *topCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSettingUserHeaderCell class])];
        if (!topCell) {
            topCell = [[PersonalSettingUserHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSettingUserHeaderCell class])];
        }
        [topCell.headImgView setYy_imageURL:[NSURL URLWithString:_dataModel.avatar]];
        topCell.nameLab.text=_dataModel.nickname;
        return topCell;
    }
    else if (indexPath.section==1)
    {
        PersonalSettingPhoneCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSettingPhoneCell class])];
        if (!phoneCell) {
            phoneCell = [[PersonalSettingPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSettingPhoneCell class])];
        }
        phoneCell.phoneLab.text=_dataModel.mobile;
        return phoneCell;
    }
    else
    {
        PersonalSettingMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSettingMessageCell class])];
        if (!messageCell) {
            messageCell = [[PersonalSettingMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSettingMessageCell class])];
        }
        messageCell.dataDic=_messageDataArr[indexPath.row];
        if (indexPath.row==2||indexPath.row==3) {
            messageCell.contentTextField.enabled=NO;
        }
        else
        {
            messageCell.contentTextField.enabled=YES;
        }
        return messageCell;
    }
}

#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        //设置个人资料
        PersonalMessageViewController *vc=[[PersonalMessageViewController alloc]init];
        vc.nickName=_dataModel.nickname;
        vc.headUrlStr=_dataModel.avatar;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section==1)
    {
        //更改绑定手机号
        PersonalBindingPhoneNumberViewController *vc=[[PersonalBindingPhoneNumberViewController alloc]init];
        vc.phoneNum=_dataModel.mobile;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if(indexPath.section==2)
    {
        if (indexPath.row==2) {
            //日期选择
                [[YNDatePickerView initialize] showCustomDatePickViewWithTitle:@"选择时间" target:self datePickerViewModel:YNDatePickerViewModelYearForDay defaultDate:nil maxDate:nil minDate:[NSDate dateWithYear:1800 month:1 day:1]];
        }
        else if (indexPath.row==3)
        {
            //城市选择
            MJWeakSelf;
            YJLocationPicker *locationPicker=[[YJLocationPicker alloc] initWithSlectedLocation:^(NSArray *locationArray) {
                NSLog(@"---%@",locationArray);
                for (int i=0; i<2; i++) {
                    if (i==0) {
                        addressStr=locationArray[0];
                    }
                    else
                    {
                        addressStr=[NSString stringWithFormat:@"%@-%@",addressStr,locationArray[i]];
                    }
                }
                [weakSelf makeupData];
                [weakSelf.settingTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [locationPicker show];
        }
    }
}
#pragma mark-----YNDatePickerViewDelegate
- (void)didSelectDatePickerView:(YNDatePickerView *)datePickerView selectDate:(NSDate *)date {
    
    birthDate = [NSDate stringForDate:date dateFormatString:@"yyyy-MM-dd"];
    [self makeupData];
    [self.settingTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma mark----确认修改
-(void)saveSettingAction
{
    [self.view endEditing:YES];
    
    PersonalSettingMessageCell *nameCell=(PersonalSettingMessageCell *)[_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSString *realNameStr=nameCell.contentTextField.text;
    
    PersonalSettingMessageCell *weixinCell=(PersonalSettingMessageCell *)[_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    NSString *weixinStr=weixinCell.contentTextField.text;
    
    NSDictionary *paramDic=@{@"realname":realNameStr,@"mobile":_dataModel.mobile,@"weixin":weixinStr,@"birth":birthDate,@"city":addressStr};
    
    NSString *url = [NSString stringWithFormat:@"r=apply.personal.info.submit&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]];
    NSString *path = [HBBaseAPI appendAPIurl:url];
    
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBJSONNetWork sharedManager] requestWithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        NSLog(@"%@",responseDic);
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:@"修改成功"];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark----整理数据
-(void)makeupData
{
    NSString *titleStr=@"title";
    NSString *messageStr=@"message";
    _messageDataArr=@[@{titleStr:@"姓名",messageStr:_dataModel.realname},@{titleStr:@"微信号",messageStr:_dataModel.weixin},@{titleStr:@"出生日期",messageStr:birthDate},@{titleStr:@"所在城市",messageStr:addressStr}];
}

-(UITableView *)settingTableView
{
    if (!_settingTableView) {
        _settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStylePlain];
        _settingTableView.backgroundColor=KTableBackgroundColor;
        _settingTableView.separatorColor = KLineColor;
        _settingTableView.delegate=self;
        _settingTableView.dataSource=self;
        _settingTableView.tableFooterView = [[UIView alloc] init];
    }
    return _settingTableView;
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
