//
//  DBHUD.m
//  SSKSports
//
//  Created by HubinSun on 2016/12/9.
//  Copyright © 2016年 HubinSun. All rights reserved.
//

#import "DBHUD.h"

@implementation DBHUD

+(void)ShowInView:(UIView *)view withTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = title;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}
+(void)ShowProgressInview:(UIView *)view Withtitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text =  title;
    //hud.dimBackground = NO;
    [hud showAnimated:YES];
    
}
+(void)Hiden:(BOOL)hidden fromView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    [hud hideAnimated:YES];
}

@end
