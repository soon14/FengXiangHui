//
//  AddressCreatEditViewController.m
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressCreatEditViewController.h"
#import "AddressResultModel.h"
#import "ZHFAddTitleAddressView.h"
#import "AddressNavigationView.h"

@interface AddressCreatEditViewController ()<UITextFieldDelegate,ZHFAddTitleAddressViewDelegate,AddressNavigationViewDelegate>

/** navigationView */
@property(nonatomic , strong)AddressNavigationView *navigationView;
/** 收货人 */
@property(nonatomic , strong)UITextField *nameTextField;
/** 联系电话 */
@property(nonatomic , strong)UITextField *phoneTextField;
/** 所在省市区 */
@property(nonatomic , strong)UITextField *areaTextField;
/** 详细地址 */
@property(nonatomic , strong)UITextField *detailsTextField;
/** 是否默认 */
@property(nonatomic , strong)UISwitch *defaultSwitch;
/** 保存按钮 */
@property(nonatomic , strong)UIButton *saveButton;
/** 京东四级地址选择 */
@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;


@end

@implementation AddressCreatEditViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    if (_editAddressModel) {
        [self.nameTextField setText:_editAddressModel.realname];
        [self.phoneTextField setText:_editAddressModel.mobile];
        [self.areaTextField setText:[NSString stringWithFormat:@"%@ %@ %@ %@",_editAddressModel.province,_editAddressModel.city,_editAddressModel.area,_editAddressModel.town]];
        [self.detailsTextField setText:_editAddressModel.address];
        [self.defaultSwitch setOn:_editAddressModel.isdefault];
    }
}

#pragma mark - initUI
- (void)initUI {
    CGFloat LabelWidth = 90;
    CGFloat LabelHeight = 50;
    
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(KNaviHeight);
    }];
    
    UIView *backView = [[UIView alloc] init];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(KNaviHeight);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(LabelHeight*5);
    }];
    
    UILabel *label_1 = [[UILabel alloc] init];
    [label_1 setText:@"收货人"];
    [label_1 setFont:KFont(14)];
    [label_1 setTextColor:KUIColorFromHex(0x333333)];
    [backView addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(12);
        make.width.mas_equalTo(LabelWidth);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [backView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_1.mas_right);
        make.right.mas_offset(-12);
        make.top.mas_offset(0);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    UILabel *label_2 = [[UILabel alloc] init];
    [label_2 setText:@"联系电话"];
    [label_2 setFont:KFont(14)];
    [label_2 setTextColor:KUIColorFromHex(0x333333)];
    [backView addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_1.mas_bottom).offset(0);
        make.left.mas_equalTo(label_1.mas_left);
        make.width.mas_equalTo(LabelWidth);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [backView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_1.mas_right);
        make.right.mas_equalTo(_nameTextField.mas_right);
        make.top.mas_equalTo(label_2.mas_top);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    UILabel *label_3 = [[UILabel alloc] init];
    [label_3 setText:@"所在地区"];
    [label_3 setFont:KFont(14)];
    [label_3 setTextColor:KUIColorFromHex(0x333333)];
    [backView addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_2.mas_bottom).offset(0);
        make.left.mas_equalTo(label_1.mas_left);
        make.width.mas_equalTo(LabelWidth);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [backView addSubview:self.areaTextField];
    [self.areaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_1.mas_right);
        make.right.mas_equalTo(_nameTextField.mas_right);
        make.top.mas_equalTo(label_3.mas_top);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    UILabel *label_4 = [[UILabel alloc] init];
    [label_4 setText:@"详细地址"];
    [label_4 setFont:KFont(14)];
    [label_4 setTextColor:KUIColorFromHex(0x333333)];
    [backView addSubview:label_4];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_3.mas_bottom).offset(0);
        make.left.mas_equalTo(label_1.mas_left);
        make.width.mas_equalTo(LabelWidth);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [backView addSubview:self.detailsTextField];
    [self.detailsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_1.mas_right);
        make.right.mas_equalTo(_nameTextField.mas_right);
        make.top.mas_equalTo(label_4.mas_top);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    UILabel *label_5 = [[UILabel alloc] init];
    [label_5 setText:@"设置默认地址"];
    [label_5 setFont:KFont(14)];
    [label_5 setTextColor:KUIColorFromHex(0x333333)];
    [backView addSubview:label_5];
    [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_4.mas_bottom).offset(0);
        make.left.mas_equalTo(label_1.mas_left);
        make.width.mas_equalTo(LabelWidth);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [backView addSubview:self.defaultSwitch];
    [self.defaultSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nameTextField.mas_right);
        make.centerY.mas_equalTo(label_5.mas_centerY);
    }];
    
    for (NSInteger i=0; i<4; i++) {
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(LabelHeight*(i+1));
        }];
    }
    
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(20);
        make.left.mas_offset(16);
        make.right.mas_offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
}


#pragma mark - 保存按钮被点击
- (void)saveButtonAction:(UIButton *)sender {
    if (self.nameTextField.text.length == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请输入收货人姓名"];
        return;
    }
    if ([self.nameTextField.text containsString:@" "]) {
        [DBHUD ShowInView:self.view withTitle:@"收货人姓名不能含有空格"];
        return;
    }
    if (self.phoneTextField.text.length == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请输入联系电话"];
        return;
    }
    if (self.areaTextField.text.length == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请选择所在地区"];
        return;
    }
    if (self.detailsTextField.text.length == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请填写详细街道地址"];
        return;
    }
    
    [self saveAddressRequest];
}

#pragma mark - 收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 保存地址请求
- (void)saveAddressRequest {
    NSString *url = @"r=apply.member.address_submit";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    [paramDic setObject:self.nameTextField.text forKey:@"realname"];
    [paramDic setObject:self.phoneTextField.text forKey:@"mobile"];
    [paramDic setObject:self.areaTextField.text forKey:@"areas"];
    [paramDic setObject:self.detailsTextField.text forKey:@"address"];
    [paramDic setObject:self.defaultSwitch.on?@"1":@"0" forKey:@"isdefault"];
    if (_editAddressModel) {
        [paramDic setObject:_editAddressModel.addressID forKey:@"id"];
    }
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            if (self.savcSuccessBlock) {
                self.savcSuccessBlock(0);
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.areaTextField) {
        [self.view endEditing:YES];
        [self.addTitleAddressView addAnimate];
        return NO;
    } return YES;
}

-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
    if (titleAddress.length > 0) {
        NSMutableString *addressString = [NSMutableString stringWithString:titleAddress];
        [addressString deleteCharactersInRange:NSMakeRange(0, 1)];
        [self.areaTextField setText:addressString];
        //NSLog(@"%@",addressString);
    }
    
    //NSLog(@"%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@",titleID]);
}

- (void)AddressNavigationView:(AddressNavigationView *)view backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy
- (AddressNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[AddressNavigationView alloc] init];
        _navigationView.title = _titleString;
        _navigationView.delegate = self;
    }
    return _navigationView;
}

- (ZHFAddTitleAddressView *)addTitleAddressView {
    if (!_addTitleAddressView) {
        _addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
        _addTitleAddressView.title = @"选择地址";
        _addTitleAddressView.delegate1 = self;
        _addTitleAddressView.defaultHeight = 450;
        _addTitleAddressView.titleScrollViewH = 37;
    }
    return _addTitleAddressView;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setBackgroundColor:KRedColor];
        [_saveButton setTitle:@"保存地址" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton.titleLabel setFont:KFont(15)];
        [_saveButton.layer setMasksToBounds:YES];
        [_saveButton.layer setCornerRadius:5];
        [_saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (UISwitch *)defaultSwitch {
    if (!_defaultSwitch) {
        _defaultSwitch = [[UISwitch alloc] init];
        [_defaultSwitch setOn:NO];
        [_defaultSwitch setOnTintColor:KRedColor];
    }
    return _defaultSwitch;
}

- (UITextField *)detailsTextField {
    if (!_detailsTextField) {
        _detailsTextField = [[UITextField alloc] init];
        [_detailsTextField setTextColor:KUIColorFromHex(0x333333)];
        [_detailsTextField setFont:KFont(14)];
        [_detailsTextField setPlaceholder:@"街道、楼牌号"];
    }
    return _detailsTextField;
}

- (UITextField *)areaTextField {
    if (!_areaTextField) {
        _areaTextField = [[UITextField alloc] init];
        [_areaTextField setTextColor:KUIColorFromHex(0x333333)];
        [_areaTextField setFont:KFont(14)];
        [_areaTextField setPlaceholder:@"所在地区"];
        [_areaTextField setDelegate:self];
    }
    return _areaTextField;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        [_phoneTextField setTextColor:KUIColorFromHex(0x333333)];
        [_phoneTextField setFont:KFont(14)];
        [_phoneTextField setPlaceholder:@"请填写联系电话"];
        [_phoneTextField setKeyboardType:UIKeyboardTypePhonePad];
    }
    return _phoneTextField;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        [_nameTextField setTextColor:KUIColorFromHex(0x333333)];
        [_nameTextField setFont:KFont(14)];
        [_nameTextField setPlaceholder:@"请填写收货人姓名"];
    }
    return _nameTextField;
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
