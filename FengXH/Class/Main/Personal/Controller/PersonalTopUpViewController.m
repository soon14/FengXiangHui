//
//  PersonalTopUpViewController.m
//  FengXH
//
//  Created by mac on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalTopUpViewController.h"
#import "WXApi.h"
#import <CommonCrypto/CommonDigest.h>

@interface PersonalTopUpViewController ()
@property (nonatomic ,strong) UILabel *amountLabel;
@property (nonatomic ,strong) UITextField *tf;
/** 订单 id 用于查询是否充值成功 */
@property(nonatomic , copy)NSString *logID;

@end

@implementation PersonalTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    [self setSubView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WechatPayInfoAction:) name:@"WechatPayInfo" object:nil];
}

#pragma mark -  微信支付信息回调监听
- (void)WechatPayInfoAction:(NSNotification *)notification {
    NSInteger infoCode = [notification.object[@"info"] integerValue];
    switch (infoCode) {
        case 0: {
            //确认充值成功
            [self rechargeCompleteRequest];
        } break;
        default: {//失败
            [DBHUD ShowInView:self.view withTitle:@"支付失败"];
        } break;
    }
}

- (void)setSubView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, KMAINSIZE.width, 80)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KMAINSIZE.width, 1)];
    line.backgroundColor = KLineColor;
    [view addSubview:line];
    
    NSArray *arr = @[@"当前商城现金",@"充值金额"];
    NSArray *btnArr = @[@"微信支付",@"支付宝支付"];
    NSArray *backArr = @[KGreenColor,KUIColorFromHex(0xEF8732)];
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10*KScreenRatio, 10+40*i, 100*KScreenRatio, 25)];
        label.text = arr[i];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = KFont(14);
        label.textColor = KUIColorFromHex(0x666666);
        [view addSubview:label];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10*KScreenRatio, 112+50*i, KMAINSIZE.width-20*KScreenRatio, 40)];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:backArr[i]];
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.tag = i+300;
        if (btn.tag == 301) {
            btn.hidden = YES;
        }
        btn.layer.cornerRadius = 8;
        [btn addTarget:self action:@selector(btnTarget:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(115*KScreenRatio, 10, 100*KScreenRatio, 25)];
    _amountLabel.textColor = [UIColor blackColor];
    _amountLabel.font = KFont(14);
    _amountLabel.textAlignment = NSTextAlignmentLeft;
    _amountLabel.text = self.str;
    [view addSubview:_amountLabel];
    
    _tf = [[UITextField alloc]initWithFrame:CGRectMake(115*KScreenRatio, 50, 100*KScreenRatio, 25)];
    _tf.placeholder = @"输入金额";
    _tf.font = KFont(14);
    _tf.keyboardType = UIKeyboardTypeDecimalPad;
    [view addSubview:_tf];
    
    
}
- (void)btnTarget:(UIButton *)sender{
    [self.view endEditing:YES];
    if (sender.tag ==300) {
        //微信
        if ([self.tf.text floatValue] > 0) {
            [self rechargeWechatPayRequest];
        } else {
            [DBHUD ShowInView:self.view withTitle:@"请输入充值金额"];
        }
    }else{
        //支付宝
        NSLog(@"%@",self.tf.text);
    }
}



#pragma mark - 确认是否充值成功
- (void)rechargeCompleteRequest {
    NSString *url = @"r=apply.personal.recharge.wechat_complete";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              self.logID,@"logid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            //NSLog(@"充值成功");
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"后台繁忙"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
    
}

#pragma mark - 微信充值支付
- (void)rechargeWechatPayRequest {
    NSString *url = @"r=apply.personal.recharge.submit";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%.2f",[self.tf.text floatValue]],@"money",
                              @"wechat",@"type", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            //            NSLog(@"微信支付：\n%@",responseDic);
            NSDictionary *wxPayDic = responseDic[@"result"];
            
            self.logID = wxPayDic[@"logid"];
            [self WXPayWithAppid:wxPayDic[@"appId"] noncestr:wxPayDic[@"nonceStr"] package:@"Sign=WXPay" partnerid:wxPayDic[@"partnerid"] prepayid:wxPayDic[@"prepay_id"] timestamp:[ShareManager getNowTimeTimestamp] key:@"daup4t4cs1xj1jjrj50de4dknx4bcnsm"];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"后台繁忙"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
    
}

#pragma mark 微信支付方法
- (void)WXPayWithAppid:(NSString *)appid noncestr:(NSString *)noncestr package:(NSString *)package partnerid:(NSString *)partnerid prepayid:(NSString *)prepayid timestamp:(NSString *)timestamp key:(NSString *)key {
    
    NSString *signString = [NSString stringWithFormat:@"appid=%@&noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%@&key=%@",appid,noncestr,package,partnerid,prepayid,timestamp,key];
    NSString *md5SignString = [self md5:signString];
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = appid;
    // 商家id，在注册的时候给的
    req.partnerId = partnerid;
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = prepayid;
    // 根据财付通文档填写的数据和签名
    req.package  = package;
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = noncestr;
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = timestamp;
    req.timeStamp = stamp.intValue;
    // 这个签名也是后台做的
    req.sign = md5SignString;
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}

// MD5加密算法
-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
