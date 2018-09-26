//
//  GoodsListFilterViewController.m
//  FengXH
//
//  Created by sun on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsListFilterViewController.h"
#import "GoodsListFilterCell.h"

@interface GoodsListFilterViewController ()

/** 推荐商品 */
@property(nonatomic , strong)UIButton *recommendButton;
/** 新品上市 */
@property(nonatomic , strong)UIButton *isNewButton;
/** 热卖商品 */
@property(nonatomic , strong)UIButton *hotButton;
/** 促销商品 */
@property(nonatomic , strong)UIButton *discountButton;
/** 包邮商品 */
@property(nonatomic , strong)UIButton *freeShippingButton;
/** 限时抢购 */
@property(nonatomic , strong)UIButton *timeLimitButton;
/** 取消筛选按钮 */
@property(nonatomic , strong)UIButton *cancelButton;
/** 确定按钮 */
@property(nonatomic , strong)UIButton *confirmButton;

@end

@implementation GoodsListFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popupView.frame = CGRectMake(0, 0, KMAINSIZE.width, 135);
    
    [self initUI];
    
}

- (void)takeBackView {
    MJWeakSelf
    [UIView animateWithDuration:0.1 animations:^{
        [weakSelf.popupView layoutIfNeeded];
        weakSelf.backCancelButton.alpha = 0;
    } completion:^(BOOL finish) {
        [weakSelf.view removeFromSuperview];
        [weakSelf.backCancelButton removeFromSuperview];
    }];
    if (self.takeBackBlock) {
        self.takeBackBlock(0);
    }
}

#pragma mark - 确定按钮被点击
- (void)confirmButtonAction {
    //推荐商品  isrecommand     1:是     0:否
    NSString *isrecommand = @"0";
    if (self.recommendButton.selected) {
        isrecommand = @"1";
    }
    //新品上市  isnew           1:是     0:否
    NSString *isnew = @"0";
    if (self.isNewButton.selected) {
        isnew = @"1";
    }
    //热卖商品  ishot           1:是     0:否
    NSString *ishot = @"0";
    if (self.hotButton.selected) {
        ishot = @"1";
    }
    //促销商品  isdiscount      1:是     0:否
    NSString *isdiscount = @"0";
    if (self.discountButton.selected) {
        isdiscount = @"1";
    }
    //卖家包邮  issendfree      1:是     0:否
    NSString *issendfree = @"0";
    if (self.freeShippingButton.selected) {
        issendfree = @"1";
    }
    //限时抢购  istime          1:是     0:否
    NSString *istime = @"0";
    if (self.timeLimitButton.selected) {
        istime = @"1";
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(isrecommand, isnew, ishot, isdiscount, issendfree, istime);
    };
    [self takeBackView];
}

#pragma mark - 六个按钮被点击
- (void)buttonAction:(UIButton *)sender {
    if (sender == self.recommendButton) {
        if (!sender.selected) {
            [sender setTitleColor:KRedColor forState:UIControlStateNormal];
            [sender.layer setBorderColor:KRedColor.CGColor];
        } else {
            [sender setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [sender.layer setBorderColor:KLineColor.CGColor];
        }
        sender.selected = !sender.selected;
    } else if (sender == self.isNewButton) {
        if (!sender.selected) {
            [sender setTitleColor:KRedColor forState:UIControlStateNormal];
            [sender.layer setBorderColor:KRedColor.CGColor];
        } else {
            [sender setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [sender.layer setBorderColor:KLineColor.CGColor];
        }
        sender.selected = !sender.selected;
    } else if (sender == self.hotButton) {
        if (!sender.selected) {
            [sender setTitleColor:KRedColor forState:UIControlStateNormal];
            [sender.layer setBorderColor:KRedColor.CGColor];
        } else {
            [sender setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [sender.layer setBorderColor:KLineColor.CGColor];
        }
        sender.selected = !sender.selected;
    } else if (sender == self.discountButton) {
        if (!sender.selected) {
            [sender setTitleColor:KRedColor forState:UIControlStateNormal];
            [sender.layer setBorderColor:KRedColor.CGColor];
        } else {
            [sender setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [sender.layer setBorderColor:KLineColor.CGColor];
        }
        sender.selected = !sender.selected;
    } else if (sender == self.freeShippingButton) {
        if (!sender.selected) {
            [sender setTitleColor:KRedColor forState:UIControlStateNormal];
            [sender.layer setBorderColor:KRedColor.CGColor];
        } else {
            [sender setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [sender.layer setBorderColor:KLineColor.CGColor];
        }
        sender.selected = !sender.selected;
    } else if (sender == self.timeLimitButton) {
        if (!sender.selected) {
            [sender setTitleColor:KRedColor forState:UIControlStateNormal];
            [sender.layer setBorderColor:KRedColor.CGColor];
        } else {
            [sender setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [sender.layer setBorderColor:KLineColor.CGColor];
        }
        sender.selected = !sender.selected;
    }
}

#pragma mark - 设置 UI
- (void)initUI {
    CGFloat disWidth = 15;
    CGFloat buttonWidth = (KMAINSIZE.width-(disWidth*6))/3;
    CGFloat buttonHeight = 30;
    
    [self.popupView addSubview:self.recommendButton];
    [self.recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(disWidth);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.popupView addSubview:self.isNewButton];
    [self.isNewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.centerX.mas_equalTo(self.popupView.mas_centerX);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.popupView addSubview:self.hotButton];
    [self.hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.mas_offset(-disWidth);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.popupView addSubview:self.discountButton];
    [self.discountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_recommendButton.mas_bottom).offset(10);
        make.left.mas_offset(disWidth);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.popupView addSubview:self.freeShippingButton];
    [self.freeShippingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_recommendButton.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.popupView.mas_centerX);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.popupView addSubview:self.timeLimitButton];
    [self.timeLimitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_recommendButton.mas_bottom).offset(10);
        make.right.mas_offset(-disWidth);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.popupView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    [self.popupView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line_2 = [[UIView alloc] init];
    [line_2 setBackgroundColor:KLineColor];
    [self.popupView addSubview:line_2];
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(_cancelButton.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
}

#pragma mark - lazy
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:KFont(15)];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消筛选" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:KFont(15)];
        [_cancelButton addTarget:self action:@selector(takeBackView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)timeLimitButton {
    if (!_timeLimitButton) {
        _timeLimitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeLimitButton setTitle:@"限时抢购" forState:UIControlStateNormal];
        [_timeLimitButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_timeLimitButton.titleLabel setFont:KFont(14)];
        [_timeLimitButton.layer setBorderColor:KLineColor.CGColor];
        [_timeLimitButton.layer setBorderWidth:1];
        [_timeLimitButton.layer setMasksToBounds:YES];
        [_timeLimitButton.layer setCornerRadius:3];
        [_timeLimitButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeLimitButton;
}


- (UIButton *)freeShippingButton {
    if (!_freeShippingButton) {
        _freeShippingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_freeShippingButton setTitle:@"买家包邮" forState:UIControlStateNormal];
        [_freeShippingButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_freeShippingButton.titleLabel setFont:KFont(14)];
        [_freeShippingButton.layer setBorderColor:KLineColor.CGColor];
        [_freeShippingButton.layer setBorderWidth:1];
        [_freeShippingButton.layer setMasksToBounds:YES];
        [_freeShippingButton.layer setCornerRadius:3];
        [_freeShippingButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _freeShippingButton;
}

- (UIButton *)discountButton {
    if (!_discountButton) {
        _discountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_discountButton setTitle:@"促销商品" forState:UIControlStateNormal];
        [_discountButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_discountButton.titleLabel setFont:KFont(14)];
        [_discountButton.layer setBorderColor:KLineColor.CGColor];
        [_discountButton.layer setBorderWidth:1];
        [_discountButton.layer setMasksToBounds:YES];
        [_discountButton.layer setCornerRadius:3];
        [_discountButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _discountButton;
}

- (UIButton *)hotButton {
    if (!_hotButton) {
        _hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotButton setTitle:@"热卖商品" forState:UIControlStateNormal];
        [_hotButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_hotButton.titleLabel setFont:KFont(14)];
        [_hotButton.layer setBorderColor:KLineColor.CGColor];
        [_hotButton.layer setBorderWidth:1];
        [_hotButton.layer setMasksToBounds:YES];
        [_hotButton.layer setCornerRadius:3];
        [_hotButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotButton;
}

- (UIButton *)isNewButton {
    if (!_isNewButton) {
        _isNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_isNewButton setTitle:@"新品上市" forState:UIControlStateNormal];
        [_isNewButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_isNewButton.titleLabel setFont:KFont(14)];
        [_isNewButton.layer setBorderColor:KLineColor.CGColor];
        [_isNewButton.layer setBorderWidth:1];
        [_isNewButton.layer setMasksToBounds:YES];
        [_isNewButton.layer setCornerRadius:3];
        [_isNewButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _isNewButton;
}

- (UIButton *)recommendButton {
    if (!_recommendButton) {
        _recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recommendButton setTitle:@"推荐商品" forState:UIControlStateNormal];
        [_recommendButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_recommendButton.titleLabel setFont:KFont(14)];
        [_recommendButton.layer setBorderColor:KLineColor.CGColor];
        [_recommendButton.layer setBorderWidth:1];
        [_recommendButton.layer setMasksToBounds:YES];
        [_recommendButton.layer setCornerRadius:3];
        [_recommendButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recommendButton;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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
