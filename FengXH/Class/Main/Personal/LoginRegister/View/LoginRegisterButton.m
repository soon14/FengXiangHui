//
//  LoginRegisterButton.m
//  FengXH
//
//  Created by sun on 2018/7/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "LoginRegisterButton.h"

@implementation LoginRegisterButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:KUIColorFromHex(0xf1a540)];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:KFont(16)];
        
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
