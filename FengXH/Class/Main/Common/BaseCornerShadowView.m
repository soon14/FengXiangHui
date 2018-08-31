//
//  BaseCornerShadowView.m
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseCornerShadowView.h"

@implementation BaseCornerShadowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setShadowOpacity:0.1];
        [self.layer setCornerRadius:5];
        [self.layer setShadowRadius:5];
        [self.layer setShadowOffset:CGSizeMake(5, 5)];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        
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
