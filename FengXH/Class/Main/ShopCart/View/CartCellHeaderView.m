//
//  CartCellHeaderView.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CartCellHeaderView.h"

@implementation CartCellHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:self.selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(20);
            make.top.bottom.mas_offset(0);
        }];
        
        
        [self addSubview:self.storeNameLabel];
        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_selectButton.mas_right).offset(10);
            make.top.bottom.mas_offset(0);
        }];
        
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KUIColorFromHex(0xeeeeee)];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)selectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.storeModel.storeSelected = sender.selected;
    [self.selectButton setSelected:self.storeModel.storeSelected];
    if (self.clickBlock) {
        self.clickBlock(self.storeModel);
    }
}

- (void)setStoreModel:(ShoppingCartStoreModel *)storeModel {
    _storeModel = storeModel;
    [self.storeNameLabel setText:storeModel.store_name];
    [self.selectButton setSelected:storeModel.storeSelected];
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc]init];
        [_storeNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_storeNameLabel setFont:KFont(14)];
        [_storeNameLabel setText:@"少少发货"];
    }
    return _storeNameLabel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_nor"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_sel"] forState:UIControlStateSelected];
        [_selectButton setTag:0];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
