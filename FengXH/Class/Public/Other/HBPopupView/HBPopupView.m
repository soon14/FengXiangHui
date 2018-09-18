//
//  GoodsListPopupView.m
//  GoodsListPopup_demo
//
//  Created by 孙湖滨 on 2018/8/28.
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
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, self.contentHeight);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.contentView.frame = CGRectMake(0, KMAINSIZE.height - self.contentHeight, KMAINSIZE.width, self.contentHeight);
    }];
}

#pragma mark - 显示属性选择视图
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.contentView.frame = CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, self.contentHeight);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

#pragma mark - lazy
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:(CGRect){0, KMAINSIZE.height - self.contentHeight, KMAINSIZE.width, self.contentHeight}];
    }
    return _contentView;
}

- (CGFloat)contentHeight {
    if (!_contentHeight) {
        _contentHeight = 350;
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
