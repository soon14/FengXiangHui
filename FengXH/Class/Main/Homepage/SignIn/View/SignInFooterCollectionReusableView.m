//
//  SignInFooterCollectionReusableView.m
//  FengXH
//
//  Created by sun on 2018/10/9.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInFooterCollectionReusableView.h"

@interface SignInFooterCollectionReusableView ()



@end

@implementation SignInFooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KUIColorFromHex(0xff2741);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 40)];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setTextColor:KUIColorFromHex(0x999999)];
        [label setFont:KFont(13)];
        [label setText:@"\t\t\t\t提示：点击漏签日期可补签哦~"];
        [self addSubview:label];

        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:label.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = label.bounds;
        maskLayer.path = maskPath.CGPath;
        label.layer.mask = maskLayer;
        
    }
    return self;
}

@end
