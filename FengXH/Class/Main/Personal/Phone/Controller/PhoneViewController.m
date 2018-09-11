//
//  PhoneViewController.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneViewController.h"
#import "HBNavigationController.h"
#import "PhoneCollectionViewCell.h"
#import "DialCollectionViewCell.h"
#import "PhoneRecordViewController.h"
#import <ContactsUI/ContactsUI.h>

@interface PhoneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CNContactPickerDelegate>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UITextField *textLabel;
@property (nonatomic ,strong) NSArray *arr;
@property (nonatomic ,strong) NSArray *imgArr;
/** 通讯录 */
@property(nonatomic , strong)UIButton *contactButton;

@end

@implementation PhoneViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.contactButton];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.contactButton) {
        [self.contactButton removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云通话";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setSubView];
    [self.view addSubview:self.collectionView];
    _arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*",@"0",@"#"];
    _imgArr = @[@"折扣商城",@"拨打电话",@"通话记录"];
}

- (void)btnTarget:(UIButton *)sender {
    if (self.textLabel.text.length>0) {
        self.textLabel.text = [_textLabel.text substringToIndex:_textLabel.text.length - 1];
    }
}

- (UIButton *)contactButton {
    if (!_contactButton) {
        _contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactButton.frame = CGRectMake(KMAINSIZE.width-50, 0, 44, 44);
        [_contactButton setImage:[UIImage imageNamed:@"contact"] forState:UIControlStateNormal];
        [_contactButton setTitle:@"通讯录" forState:UIControlStateNormal];
        [_contactButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_contactButton.titleLabel setFont:KFont(16)];
        [_contactButton addTarget:self action:@selector(contactButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
}

#pragma mark - action
- (void)contactButtonAction {
    //让用户给权限,没有的话会被拒的各位
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                [DBHUD ShowInView:self.view withTitle:@"没有授权, 需要去设置中心设置授权"];
            } else {
                //NSLog(@"用户已授权限");
                CNContactPickerViewController * picker = [[CNContactPickerViewController alloc] init];
                picker.delegate = self;
                // 加载手机号
                picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
                if (@available(iOS 11, *)) {
                    UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
                }
                [self presentViewController:picker animated:YES completion:^{
                    if (@available(iOS 11, *)) {
                        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                    }
                }];

            }
        }];
    }
    if (status == CNAuthorizationStatusAuthorized) {
        //有权限时
        CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        if (@available(iOS 11, *)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self presentViewController:picker  animated:YES completion:^{
            if (@available(iOS 11, *)) {
                UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }];
    } else {
        [DBHUD ShowInView:self.view withTitle:@"您未开启通讯录权限,请前往设置中心开启"];
    }
}


/**
 逻辑:  在该代理方法中会调出手机通讯录界面, 选中联系人的手机号, 会将联系人姓名以及手机号赋值给界面上的TEXT1和TEXT2两个UITextFiled上.
 功能: 调用手机通讯录界面, 获取联系人姓名以及电话号码.
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
//    CNContact *contact = contactProperty.contact;
//    NSLog(@"%@",contactProperty);
//    NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
    
    if (![contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        //NSLog(@"提示用户选择11位的手机号");
        [DBHUD ShowInView:self.view withTitle:@"请选择11位的手机号"];
        return;
    }
    
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString * Str = phoneNumber.stringValue;
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *phoneStr = [[Str componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@" "];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneStr.length != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请选择11位的手机号"];
        return;
    }
    self.textLabel.text = phoneStr;
}

- (void)setSubView {
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width - 70*KScreenRatio, 32+KBottomHeight, 35*KScreenRatio, 20)];
    [deleteBtn setImage:[UIImage imageNamed:@"号码退回"] forState:UIControlStateNormal];
    deleteBtn.tag = 6002;
    [deleteBtn addTarget:self action:@selector(btnTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    _textLabel = [[UITextField alloc]initWithFrame:CGRectMake(50*KScreenRatio, 22+KBottomHeight, KMAINSIZE.width-120*KScreenRatio, 40)];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = KFont(30);
    _textLabel.enabled = NO;
    if(self.phoneNum == nil){
        _textLabel.text = @"";
    }else{
        _textLabel.text = self.phoneNum;
    }
    
    
    [self.view addSubview:_textLabel];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 136+KBottomHeight, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerClass:[PhoneCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PhoneCollectionViewCell class])];
        [_collectionView registerClass:[DialCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DialCollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return NO;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 12;
    }else{
        return 3;
    }
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PhoneCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhoneCollectionViewCell class]) forIndexPath:indexPath];
        [cell setTitle:_arr[indexPath.item] andLetter:nil];
        return cell;
    }else{
       DialCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DialCollectionViewCell class]) forIndexPath:indexPath];
        [cell setImg:_imgArr[indexPath.item]];
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(85*KScreenRatio, 75);
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 50*KScreenRatio, 10, 50*KScreenRatio);
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.textLabel.text.length < 11) {
            if (![_arr[indexPath.item] isEqualToString:@"#"] && ![_arr[indexPath.item] isEqualToString:@"*"]) {
                NSString *str = [NSString stringWithFormat:@"%@%@",self.textLabel.text,_arr[indexPath.item]];
                self.textLabel.text = str;
            }
        }
        
    }else{
        if (indexPath.item == 0) {
            //NSLog(@"商城");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://shop.xmhualao.com/home/index?id=e1106916-a66c-4e9c-9693-3d9c6aeeb1b0"]];
        }else if (indexPath.item == 1){
            //NSLog(@"通话");
            [self request];
        }else{
            //NSLog(@"记录");
            PhoneRecordViewController *vc = [[PhoneRecordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 20;

}
- (void)request{
    
    NSString *url = @"r=apply.hlapi.dial";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":token,@"num":self.textLabel.text} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:@"电话接通中..."];
            
            if (self.textLabel.text.length == 11) {
                NSDate * date = [NSDate date];
                NSTimeInterval sec = [date timeIntervalSinceNow];
                NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
                
                //设置时间输出格式：
                NSDateFormatter * df = [[NSDateFormatter alloc] init ];
                [df setDateFormat:@"MM月dd日 HH:mm"];
                NSString * na = [df stringFromDate:currentDate];
                //NSLog(@"%@",[responseDic objectForKey:@"message"]);
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneData"] == nil) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    [arr addObject:@{@"phoneNum":self.textLabel.text,@"time":na}];
                    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"PhoneData"];
                } else {
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneData"]];
                    [arr addObject:@{@"phoneNum":self.textLabel.text,@"time":na}];
                    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"PhoneData"];
                }
            }
        } else {
            [DBHUD ShowInView:self.view withTitle:[responseDic objectForKey:@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
