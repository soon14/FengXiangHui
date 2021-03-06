//
//  GoodsListPopupView.m
//  GoodsListPopup_demo
//
//  Created by sun on 2018/8/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBPopupView.h"

@interface HBPopupView ()<UIGestureRecognizerDelegate>

@end

@implementation HBPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加手势，点击背景视图消失
        UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        tapBackGesture.delegate = self;
        [self addGestureRecognizer:tapBackGesture];
        
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark - UIGestureRecognizerDelegate
//确定点击范围
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    } return YES;
}

#pragma mark - 显示属性选择视图
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    MJWeakSelf
    self.contentView.frame = CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, self.contentHeight);;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = CGRectMake(0, KMAINSIZE.height - weakSelf.contentHeight, KMAINSIZE.width, weakSelf.contentHeight);
    }];
}

#pragma mark - 显示属性选择视图
- (void)removeView {
    MJWeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, weakSelf.contentHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - lazy
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:(CGRect){0, 0, KMAINSIZE.width, self.contentHeight}];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentView.bounds;
        maskLayer.path = maskPath.CGPath;
        _contentView.layer.mask = maskLayer;
    }
    return _contentView;
}

- (CGFloat)contentHeight {
    if (!_contentHeight) {
        _contentHeight = 500;
    }
    return _contentHeight;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
