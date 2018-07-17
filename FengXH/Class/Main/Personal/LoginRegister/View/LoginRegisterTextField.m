//
//  LoginRegisterTextField.m
//  FengXH
//
//  Created by sun on 2018/7/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "LoginRegisterTextField.h"

@implementation LoginRegisterTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:(frame)]) {
        
//        [self setBackgroundColor:KTableBackgroundColor];
        [self setFont:KFont(16)];
        [self setTextColor:KUIColorFromHex(0x333333)];
        [self setTextAlignment:NSTextAlignmentCenter];
        
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
