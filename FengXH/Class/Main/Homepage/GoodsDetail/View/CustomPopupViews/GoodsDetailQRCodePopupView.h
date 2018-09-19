//
//  GoodsDetailQRCodeView.h
//  FengXH
//
//  Created by sun on 2018/9/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailQRCodePopupView : UIView

- (void)showInView:(UIView *)view;
/** url */
@property(nonatomic , copy)NSString *imageURL;

@end
