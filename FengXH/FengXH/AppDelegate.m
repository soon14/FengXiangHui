//
//  AppDelegate.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"

#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#define shareAppSecret @"f7abe8c59b142b8e19ee160bd9898020"
#define shareAppKey @"238f87d536130"


//通知
#import <UserNotifications/UserNotifications.h>

//判断网络状态
#import "ZYNetworkAccessibity.h"



@interface AppDelegate ()<WXApiDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    MyTabBarController * tabbar = [[MyTabBarController alloc]init];
    [self.window setRootViewController:tabbar];
    
    //监听网络状态
    [ZYNetworkAccessibity start];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibityChangedNotification object:nil];
    [ZYNetworkAccessibity setAlertEnable:YES];
    
    //分享
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"4293568287"
                                           appSecret:@"dc7879247ce030b7a0aef3bd9f1243ec"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx1a48004c29b09a6d"
                                       appSecret:@"7ba78fae5c2e6702c438665c03603d0f"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             
             default:
                 break;
         }
     }];
    
    [WXApi registerApp:@"wx1a48004c29b09a6d"];
    
//    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
//        NSLog(@"log : %@", log);
//    }];
    
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    
    return YES;
}

//网络状态监听提示
- (void)networkChanged:(NSNotification *)notification {
    ZYNetworkAccessibleState state = ZYNetworkAccessibity.currentState;
    if (state == ZYNetworkRestricted) {
        NSLog(@"网络权限被关闭");
    }
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    if ([url.host isEqualToString:@"pay"]) {
//        return [WXApi handleOpenURL:url delegate:self];
//    }
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    // 在此方法中做如下判断，因为还有可能有其他的支付，如支付宝就是@"safepay"
//    if ([url.host isEqualToString:@"pay"]) {
//        return [WXApi handleOpenURL:url delegate:self];
//    }
//    return YES;
//}

//iOS 9 以上的回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        // 微信支付
        PayResp *response=(PayResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WechatPayInfo" object:@{@"info":[NSString stringWithFormat:@"%d",response.errCode]}];
//        switch(response.errCode){
//            case 0:
//                NSLog(@"支付成功！");
//                break;
//            default:
//                NSLog(@"支付失败！");
//                break;
//        }
    }
    
}

- (void)registerUserNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    
}

// 远程通知注册成功委托
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"注册deviceToken");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@" userinfo ===== %@", userInfo);
}

//iOS 10 收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        //弹框通知
        UIAlertController * stateAlert = [UIAlertController alertControllerWithTitle:@"客服新消息" message:messageAlert preferredStyle:UIAlertControllerStyleAlert];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self.window.rootViewController presentViewController:stateAlert animated:YES completion:nil];
    }
    else {
        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);

    }

    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//iOS 10 通知的点击事件
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        //弹框通知
        UIAlertController * stateAlert = [UIAlertController alertControllerWithTitle:@"客服新消息" message:messageAlert preferredStyle:UIAlertControllerStyleAlert];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self.window.rootViewController presentViewController:stateAlert animated:YES completion:nil];
    }
    else {
        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);

    }

    completionHandler();  // 系统要求执行这个方法
}

// iOS7 < iOS系统< iOS 10通知接收方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    if (application.applicationState == UIApplicationStateActive) {
        [application setApplicationIconBadgeNumber:0];
        //弹框通知
        UIAlertController * stateAlert = [UIAlertController alertControllerWithTitle:@"客服新消息" message:messageAlert preferredStyle:UIAlertControllerStyleAlert];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self.window.rootViewController presentViewController:stateAlert animated:YES completion:nil];
    }else {

    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //断开连接
}
                      
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.window endEditing:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
