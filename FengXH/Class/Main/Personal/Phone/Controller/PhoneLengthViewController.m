//
//  PhoneLengthViewController.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneLengthViewController.h"
#import "M80AttributedLabel.h"
@interface PhoneLengthViewController ()
@property (nonatomic ,strong) UITextField *tf;
@property (nonatomic ,strong) NSDictionary *dic;
@property (nonatomic ,strong) M80AttributedLabel *phoneLabel;
@end

@implementation PhoneLengthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时长充值";
    self.view.backgroundColor = [UIColor whiteColor];
    [self request];
}
- (void)request{
    NSString *url = [NSString stringWithFormat:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.hlapi.query&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]];
    NSString *path = [HBBaseAPI appendAPIurl:url];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self setSubView];
            _dic = [responseDic objectForKey:@"result"];
        }
        
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (void)setSubView{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10*KScreenRatio, 40, KMAINSIZE.width-20*KScreenRatio, 225)];
    [img setImage:[UIImage imageNamed:@"充值卡"]];
    [self.view addSubview:img];
    _phoneLabel = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(10*KScreenRatio, 320, KMAINSIZE.width-20*KScreenRatio, 30)];
    [_phoneLabel setText:@"当前话费余额："];
    _phoneLabel.font = KFont(13);
    if ([_dic objectForKey:@"message"] == nil) {
        [_phoneLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"0"] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    }else{
        [_phoneLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"message"]] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    }
    
    _phoneLabel.textColor = KUIColorFromHex(0x666666);
    [self.view addSubview:_phoneLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10*KScreenRatio, 350, KMAINSIZE.width-20*KScreenRatio, 1)];
    line.backgroundColor = KLineColor;
    [self.view addSubview:line];
    
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*KScreenRatio, 365, 85*KScreenRatio, 20)];
    pwdLabel.text = @"请输入卡密：";
    pwdLabel.font = KFont(13);
    pwdLabel.textColor = KUIColorFromHex(0x666666);
    [self.view addSubview:pwdLabel];
    
    _tf = [[UITextField alloc]initWithFrame:CGRectMake(97*KScreenRatio, 365, 250*KScreenRatio, 20)];
    _tf.secureTextEntry = YES;
    
    [self.view addSubview:self.tf];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10*KScreenRatio, 400, KMAINSIZE.width-20*KScreenRatio, 50)];
    button.backgroundColor = KGreenColor;
    button.layer.cornerRadius = 8;
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *footView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-70-KNaviHeight-KBottomHeight, KMAINSIZE.width, 70)];
    [footView setImage:[UIImage imageNamed:@"充值卡说明"]];
    [self.view addSubview:footView];
    
}
- (void)buttonAction{
    NSString *url = @"r=apply.hlapi.recharge";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":token,@"pwd":self.tf.text} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [_phoneLabel setText:@"当前话费余额："];
            [_phoneLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"111"] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor]}]];
        }else{
            [DBHUD Hiden:YES fromView:self.view];
            if([responseDic objectForKey:@"message"] == nil){
                
                [DBHUD ShowInView:self.view withTitle:[[responseDic objectForKey:@"result"] objectForKey:@"message"]];
            }else{
                [DBHUD ShowInView:self.view withTitle:[responseDic objectForKey:@"message"]];
            }
            
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_tf resignFirstResponder];
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
