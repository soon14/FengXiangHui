//
//  HomepageSeventhView.h
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageDataModel.h"
typedef void(^SeventhCellBlock)(NSInteger index);

@interface HomepageSeventhView : UIView

@property(strong,nonatomic) UIScrollView * direct;

+ (instancetype)direcWithtFrame:(CGRect)frame
                 GoodsInfoArray:(NSArray *)goodsInfoArray
                   SeventhBlock:(SeventhCellBlock)seventhBlock;

@end
