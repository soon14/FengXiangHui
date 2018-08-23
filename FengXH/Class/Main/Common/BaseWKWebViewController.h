//
//  BaseWKWebViewController.h
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"

@interface BaseWKWebViewController : UIViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic , strong)WKWebView *webView;
/** url */
@property(nonatomic , copy)NSString *jumpURL;


@end
