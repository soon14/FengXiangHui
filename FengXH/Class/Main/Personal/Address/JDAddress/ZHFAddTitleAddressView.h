//
//  ZHFAddTitleAddressView.h
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ZHFAddTitleAddressViewDelegate <NSObject>
-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID;
@end
@interface ZHFAddTitleAddressView : UIView
@property(nonatomic,assign)id<ZHFAddTitleAddressViewDelegate>delegate1;
@property(nonatomic,assign)NSUInteger defaultHeight;
@property(nonatomic,assign)CGFloat titleScrollViewH;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIView *addAddressView;
-(UIView *)initAddressView;
-(void)addAnimate;
@end
