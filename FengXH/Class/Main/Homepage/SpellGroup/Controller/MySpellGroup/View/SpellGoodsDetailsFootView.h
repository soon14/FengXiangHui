//
//  SpellGoodsDetailsFootView.h
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpellGoodsDetailsFootView;
@protocol SpellGoodsDetailsFootViewDelegate <NSObject>
- (void)onItemClick:(NSInteger)data;

@end

@interface SpellGoodsDetailsFootView : UIView

@property(nonatomic , weak)id <SpellGoodsDetailsFootViewDelegate> delegate;
- (void)setData:(NSArray *)dataArr;
@end
