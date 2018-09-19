//
//  GoodsDetailQRCodeView.m
//  FengXH
//
//  Created by sun on 2018/9/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailQRCodePopupView.h"

@interface GoodsDetailQRCodePopupView ()<UIGestureRecognizerDelegate>

/** contentView */
@property(nonatomic , strong)UIImageView *contentView;

@end

@implementation GoodsDetailQRCodePopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        // 添加手势，点击背景视图消失
        UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        tapBackGesture.delegate = self;
        [self addGestureRecognizer:tapBackGesture];
        
        [self addSubview:self.contentView];
        
    }
    return self;
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    [self.contentView setYy_imageURL:[NSURL URLWithString:_imageURL]];
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
    self.contentView.frame = CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, 500);;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = CGRectMake(30, KNaviHeight, KMAINSIZE.width-60, 500);
    }];
}

#pragma mark - 显示属性选择视图
- (void)removeView {
    MJWeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentView.frame = CGRectMake(KMAINSIZE.width/2, KMAINSIZE.height/2, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - lazy
- (UIImageView *)contentView {
    if (!_contentView) {
        _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(30, KNaviHeight, KMAINSIZE.width-60, 500)];
        [_contentView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _contentView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
