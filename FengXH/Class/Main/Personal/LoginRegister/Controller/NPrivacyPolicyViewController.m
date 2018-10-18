//
//  PrivacyPolicyViewController.m
//  FengXH
//
//  Created by sun on 2018/10/15.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NPrivacyPolicyViewController.h"
#import <WebKit/WebKit.h>

@interface NPrivacyPolicyViewController ()

/** webView */
@property(nonatomic , strong)WKWebView *webView;
/** 加载进度条 */
@property(nonatomic , strong)UIProgressView *progressView;

@end

@implementation NPrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私条款";
    
    [self.view addSubview:self.progressView];
    [self.view insertSubview:self.webView belowSubview:self.progressView];
    
    NSString *jumpUrl = @"http://dev.vipfxh.com/declaration.html";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:jumpUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    [self.webView loadRequest:request]; 
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 计算wkWebView进度条
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
    
}

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    NSLog(@"%s",__func__);
}


#pragma mark - cancelAction
- (void)cancelButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy
- (WKWebView *)webView {
    if(!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KNaviHeight, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) configuration:configuration];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if(!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, KNaviHeight, KMAINSIZE.width, 3)];
        _progressView.tintColor = KRedColor;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
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
