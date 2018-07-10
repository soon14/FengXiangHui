//
//  DBHUD.h
//  SSKSports
//
//  Created by HubinSun on 2016/12/9.
//  Copyright © 2016年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHUD : NSObject
//错误提示
+(void)ShowInView:(UIView *)view withTitle:(NSString *)title;
//数据请求时提示
+(void)ShowProgressInview:(UIView *)view Withtitle:(NSString *)title;
+(void)Hiden:(BOOL)hidden fromView:(UIView *)view;
@end
