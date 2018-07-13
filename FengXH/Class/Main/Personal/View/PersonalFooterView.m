//
//  PersonalFooterView.m
//  FengXH
//
//  Created by sun on 2018/7/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalFooterView.h"

@implementation PersonalFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x333333)];
        [label setFont:KFont(14)];
        [label setText:@"版权所有（c）全球优选商城"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
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
