//
//  WebJumpViewController.m
//  FengXH
//
//  Created by sun on 2018/7/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "WebJumpViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "GoodsDetailViewController.h"
#import "IntegralCreatOrderViewController.h"

@interface WebJumpViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/** navigation */
@property(nonatomic , strong)UIView *navigationView;
@property(nonatomic , strong)WKWebView *webView;
@property(nonatomic , strong)UIProgressView *progressView;

/** 积分商品 id */
@property(nonatomic , copy)NSString *integralGoodsID;

@end

@implementation WebJumpViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(webviewBack)];
    [self.navigationItem.leftBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    
    [self.view addSubview:self.progressView];
    [self.view insertSubview:self.webView belowSubview:self.progressView];
    
    NSString *jumpUrl = [NSString stringWithFormat:@"%@&token=%@",_jumpURL,[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:jumpUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    [self.webView loadRequest:request]; 
}

#pragma mark - 返回操作
- (void)webviewBack {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self CloseWebView];
    }
}

#pragma mark - 关闭webview操作
- (void)CloseWebView {
    // 获取当前导航栏下所有控制器个数
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            // push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        // present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSMutableString *MString = [NSMutableString string];
    // 获取js中的<div class=“fui-header”> ... </div> 这个类，使用document.getElementsByClassName，返回一个数组，获取第一个元素[0]，
    [MString appendFormat:@"var header = document.getElementsByClassName('fui-header')[0];"];
    //removeChild:移除子标签内容
    [MString appendFormat:@"header.parentNode.removeChild(header);"];
    [webView evaluateJavaScript:MString completionHandler:nil];
    
//    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
//    NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
}

#pragma mark - #pragma mark - 拦截 URL WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *urlString = [NSString stringWithFormat:@"%@",URL];
    if ([urlString containsString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=creditshop.create&mid="]) {
        //积分兑换，点击立即兑换，跳转至生成订单界面
        IntegralCreatOrderViewController *VC = [[IntegralCreatOrderViewController alloc] init];
        VC.goodsID = _integralGoodsID;
        [self.navigationController pushViewController:VC animated:YES];
        
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - 监听 web 按钮点击
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *bodyDic = [NSDictionary dictionary];
    if ([message.name isEqualToString:@"ShowMessageFromWKWebView"]) {
        bodyDic = message.body;
        //NSLog(@"bodyDic:%@",bodyDic);
        if ([bodyDic[@"title"] isEqualToString:@"JFSC"]) {
            if (bodyDic[@"message"][@"code"]) {
                _integralGoodsID = bodyDic[@"message"][@"code"];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 计算wkWebView进度条
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } //网页title
    else if (object == self.webView && [keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }
    
}

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self clearCache];
    NSLog(@"%s",__func__);
}

/** 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件*/
- (void)clearCache {
    /* 取得Library文件夹的位置*/
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    /* 取得bundle id，用作文件拼接用*/
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    /*
     * 拼接缓存地址，具体目录为App/Library/Caches/你的APPBundleID/fsCachedData
     */
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* 取得目录下所有的文件，取得文件数组*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    /* 遍历文件组成的数组*/
    for(NSString * fileName in fileList){
        /* 定位每个文件的位置*/
        NSString * path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:@""];
        /* 将文件转换为NSData类型的数据*/
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        /* 如果FileData的长度大于2，说明FileData不为空*/
        if(fileData.length >2){
            /* 创建两个用于显示文件类型的变量*/
            int char1 =0;
            int char2 =0;
            
            [fileData getBytes:&char1 range:NSMakeRange(0,1)];
            [fileData getBytes:&char2 range:NSMakeRange(1,1)];
            /* 拼接两个变量*/
            NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
            /* 如果该文件前四个字符是6033，说明是Html文件，删除掉本地的缓存*/
            if([numStr isEqualToString:@"6033"]){
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",webKitFolderInCachesfs,fileName]error:&error];
                continue;
            }
        }
    }
}


#pragma mark - lazy
- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        [_navigationView setBackgroundColor:[UIColor whiteColor]];
    }
    return _navigationView;
}

- (WKWebView *)webView {
    if(!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) configuration:configuration];
        [configuration.userContentController addScriptMessageHandler:self name:@"ShowMessageFromWKWebView"];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if(!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 3)];
        _progressView.tintColor = KRedColor;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
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
