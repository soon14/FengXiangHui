//
//  PopupViewController.m
//  PopupView_demo
//
//  Created by sun on 2017/2/14.
//  Copyright © 2017年 HubinSun. All rights reserved.
//

#import "PopupViewController.h"

@interface PopupViewController ()

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backCancelButton];
    [self.backCancelButton addSubview:self.popupView];
}

- (void)showView {
    self.backCancelButton.alpha = 0;
    MJWeakSelf
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.backCancelButton.alpha = 1;
    }];
}


- (UIButton *)backCancelButton {
    if (!_backCancelButton) {
        _backCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backCancelButton.frame = self.view.bounds;
        _backCancelButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_backCancelButton addTarget:self action:@selector(backCancelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backCancelButton;
}


- (UIView *)popupView {
    if (!_popupView) {
        _popupView = [[UIView alloc]init];
        _popupView.backgroundColor = [UIColor whiteColor];
    }
    return _popupView;
}

#pragma 动画效果
- (void)CAtransitionLoad {
    
    CATransition *transitionViewIn =[CATransition animation];
    // 动画时间.
    transitionViewIn.duration = 0.1;
    transitionViewIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 过渡效果.
    transitionViewIn.type = kCATransitionMoveIn;
    transitionViewIn.subtype = kCATransitionFromBottom;
    [[self.popupView layer] addAnimation:transitionViewIn forKey:nil];
    
}

- (void)takeBackView {
#pragma 动画效果
    MJWeakSelf
    [UIView animateWithDuration:0.1 animations:^{
        [weakSelf.popupView layoutIfNeeded];
        weakSelf.backCancelButton.alpha = 0;
    } completion:^(BOOL finish) {
        [weakSelf.view removeFromSuperview];
        [weakSelf.backCancelButton removeFromSuperview];
    }];
}

- (void)backCancelButtonDidClicked:(UIButton *)sender {
    [self takeBackView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
