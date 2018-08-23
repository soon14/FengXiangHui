//
//  CartCellHeaderView.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CartCellHeaderView.h"
#import "ShoppingCartResultModel.h"

@implementation CartCellHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:self.selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_equalTo(20);
            make.top.bottom.mas_offset(0);
        }];
        
        
        [self.contentView addSubview:self.storeNameLabel];
        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_selectButton.mas_right).offset(10);
            make.top.bottom.mas_offset(0);
        }];
        
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KUIColorFromHex(0xeeeeee)];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}


- (void)selectButtonAction:(UIButton *)sender {
    NSMutableString *idsString = [NSMutableString string];
    for (ShoppingCartResultListModel *listModel in self.storeArray) {
        [idsString appendString:[NSString stringWithFormat:@",%@",listModel.cart_id]];
    }
    [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
    if (self.clickBlock) {
        self.clickBlock(idsString, sender.selected);
    }
}

- (void)setStoreArray:(NSArray *)storeArray {
    _storeArray = storeArray;
    ShoppingCartResultListModel *listModel = [_storeArray firstObject];
    [self.storeNameLabel setText:listModel.merchname];
    for (ShoppingCartResultListModel *listModel in _storeArray) {
        if (!listModel.selected) {
            [self.selectButton setSelected:NO];
            break;
        } else {
            [self.selectButton setSelected:YES];
        }
    }
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc]init];
        [_storeNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_storeNameLabel setFont:KFont(14)];
        [_storeNameLabel setText:@" a"];
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
