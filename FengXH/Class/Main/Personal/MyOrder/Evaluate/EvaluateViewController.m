//
//  EvaluateViewController.m
//  FengXH
//
//  Created by sun on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController ()

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    
}

#pragma mark - #pragma mark - 拦截 URL WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *urlString = [NSString stringWithFormat:@"%@",URL];
    if ([urlString containsString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=order&mid="]) {
        [DBHUD ShowInView:self.view withTitle:@"评价成功"];
        [self performSelector:@selector(pop) withObject:self afterDelay:0.8f];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    } else if ([urlString containsString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=order.detail&id="]) {
        [self.navigationController popViewControllerAnimated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - pop
- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
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
