//
//  AddressNavigationView.h
//  FengXH
//
//  Created by sun on 2018/9/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressNavigationView;

@protocol AddressNavigationViewDelegate <NSObject>
- (void)AddressNavigationView:(AddressNavigationView *)view backButtonAction:(UIButton *)sender;
@end

@interface AddressNavigationView : UIView

/** title */
@property(nonatomic , copy)NSString *title;
/** delegate */
@property(nonatomic , weak)id delegate;

@end
