//
//  GoodsDetailCartPopupView.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailPopupView.h"

@interface GoodsDetailPopupView ()

/** view */

@end

@implementation GoodsDetailPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.contentHeight = 500 + KBottomHeight;
        [self.contentView setBackgroundColor:[UIColor orangeColor]];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
