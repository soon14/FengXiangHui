//
//  AddressAddBottomView.m
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressAddBottomView.h"

@interface AddressAddBottomView ()

/** 新建按钮 */
@property(nonatomic , strong)UIButton *addButton;

@end

@implementation AddressAddBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.addBlock) {
        self.addBlock(sender);
    }
}

#pragma mark - lazy
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundColor:KRedColor];
        [_addButton setTitle:@"+ 新建地址" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton.titleLabel setFont:KFont(15)];
        [_addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
