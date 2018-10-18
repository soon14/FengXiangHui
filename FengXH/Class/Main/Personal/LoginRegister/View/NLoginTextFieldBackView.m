//
//  NLoginTextFieldBackView.m
//  FengXH
//
//  Created by sun on 2018/10/15.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NLoginTextFieldBackView.h"

@implementation NLoginTextFieldBackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:21];
        [self.layer setBorderColor:KLineColor.CGColor];
        [self.layer setBorderWidth:1];
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
