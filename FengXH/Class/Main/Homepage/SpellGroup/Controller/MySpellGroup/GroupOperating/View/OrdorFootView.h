//
//  OrdorFootView.h
//  FengXH
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrdorFootView;
@protocol OrdorFootViewDelegate <NSObject>
- (void)onItemClicks;
@end
@interface OrdorFootView : UIView
- (void)setTitle:(NSString *)goodsTitle setPrice:(NSString *)price setFreight:(NSString *)freight setNum:(NSString *)num;
@property(nonatomic , weak)id <OrdorFootViewDelegate> fdelegate;
@end
