//
//  PersonalMessageViewController.m
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalMessageViewController.h"

@interface PersonalMessageViewController ()

{
    UIImage *selectImage;//记录选择的头像
}

@property(nonatomic,strong)UIImageView *headImgView;

@property(nonatomic,strong)UITextField *nickNameTextField;

@end

@implementation PersonalMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"头像/昵称";
    
    [self createUI];
}
-(void)createUI
{
    //头像部分view
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, KMAINSIZE.width, 80)];
    headView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHead)];
    [headView addGestureRecognizer:ges];
    [self.view addSubview:headView];
    
    UILabel *headLab=[[UILabel alloc]init];
    headLab.font=KFont(16);
    headLab.textColor=KUIColorFromHex(0x333333);
    headLab.text=@"修改头像";
    [headView addSubview:headLab];
    [headLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(headView.mas_centerY);
    }];
    
    _headImgView=[[UIImageView alloc]init];
    [_headImgView setYy_imageURL:[NSURL URLWithString:_headUrlStr]];
    [headView addSubview:_headImgView];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.width.mas_offset(60);
        make.centerY.mas_equalTo(headView.mas_centerY);
    }];
    
    //修改昵称部分view
    UIView *nickNameView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, KMAINSIZE.width, 40)];
    nickNameView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:nickNameView];
    
    UILabel *nickNameLab=[[UILabel alloc]init];
    nickNameLab.font=KFont(16);
    nickNameLab.textColor=KUIColorFromHex(0x333333);
    nickNameLab.text=@"修改昵称";
    [nickNameView addSubview:nickNameLab];
    [nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(nickNameView.mas_centerY);
    }];
    
    _nickNameTextField=[[UITextField alloc]init];
    _nickNameTextField.font=KFont(16);
    _nickNameTextField.textColor=KUIColorFromHex(0x333333);
    _nickNameTextField.text=_nickName;
    _nickNameTextField.borderStyle=UITextBorderStyleNone;
    [nickNameView addSubview:_nickNameTextField];
    [_nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nickNameLab.mas_right).offset(5);
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(nickNameView.mas_centerY);
    }];
    
    //保存按钮
    UIButton *saveBtn=[[UIButton alloc]init];
    saveBtn.backgroundColor=KRedColor;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=4;
    saveBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    saveBtn.layer.shouldRasterize = YES;
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(40);
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.mas_equalTo(nickNameView.mas_bottom).offset(30);
    }];
    
}
#pragma mark----弹出相机相册选择照片
-(void)selectHead
{
    MJWeakSelf
    [[PhotoHelper sharedInstance] showPhotoActionViewWithController:self andWithBlock:^(id returnValue) {
        
        if (returnValue!=nil) {
            weakSelf.headImgView.image=returnValue;
            selectImage=returnValue;
        }
        
    }];
}
#pragma mark-----保存设置
-(void)saveAction
{
    [self.view endEditing:YES];
    
    if (selectImage!=nil) {
        [self upLoadHeadImageAndChangeNickName];
    }
    else
    {
        [self saveSettingWithImageName:_headUrlStr];
    }
    
}
-(void)upLoadHeadImageAndChangeNickName
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString * urlString = [NSString stringWithFormat:@"r=apply.util.uploader&file=file-avatar"];
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [[HBNetWork sharedManager] requestWithPath:path WithParams:@{@"token":tokenStr} WithImageName:@"file-avatar" WithImage:self.headImgView.image WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self saveSettingWithImageName:responseDic[@"result"][@"url"]];
            
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
-(void)saveSettingWithImageName:(NSString *)imgStr
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString * urlString = @"r=apply.personal.info.face";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    NSDictionary *paramsDic=@{@"token":tokenStr,@"avatar":imgStr,@"nickname":_nickNameTextField.text};
    
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"保存成功"];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
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
