//
//  MyFootprintBottomView.m
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyFootprintBottomView.h"

@interface MyFootprintBottomView ()

/** 全选按钮 */
@property(nonatomic , strong)UIButton *allSelectButton;
/** 删除按钮 */
@property(nonatomic , strong)UIButton *deleteButton;

@end

@implementation MyFootprintBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.allSelectButton];
        [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        //删除
        [self addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_offset(0);
            make.width.mas_equalTo(106);
        }];
        
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender);
    }
}

#pragma mark - lazy
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundColor:KRedColor];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:KFont(16)];
        [_deleteButton setTag:1];
        [_deleteButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIButton *)allSelectButton {
    if (!_allSelectButton) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        [_allSelectButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_allSelectButton.titleLabel setFont:KFont(16)];
        [_allSelectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_nor"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_sel"] forState:UIControlStateSelected];
        [_allSelectButton setTag:0];
        [_allSelectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
