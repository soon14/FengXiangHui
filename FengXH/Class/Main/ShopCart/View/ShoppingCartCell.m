//
//  ShoppingCartCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "ShoppingCartResultModel.h"

@implementation ShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:self.selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        //
        [self.contentView addSubview:self.goodsImageV];
        [self.goodsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_selectButton.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(100);
        }];
        
        //
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageV.mas_right).offset(13);
            make.right.mas_offset(-16);
            make.top.mas_offset(15);
        }];
        
        //
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageV.mas_right).offset(13);
            make.bottom.mas_equalTo(_goodsImageV.mas_bottom).offset(-10);
            make.height.mas_equalTo(25);
        }];
        
        
        //数量编辑框
        [self.contentView addSubview:self.editCountView];
        [self.editCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-16);
            make.bottom.mas_equalTo(_priceLabel.mas_bottom);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(25);
        }];
        
    }
    return self;
}

- (void)selectButtonAction:(UIButton *)sender {
    if (self.selectClickBlock) {
        self.selectClickBlock(self.cartGoodsModel.cart_id, self.cartGoodsModel.selected);
    }
}

- (void)setCartGoodsModel:(ShoppingCartResultListModel *)cartGoodsModel {
    _cartGoodsModel = cartGoodsModel;
    [self.goodsImageV setYy_imageURL:[NSURL URLWithString:_cartGoodsModel.thumb]];
    
    if (_cartGoodsModel.selected && [_cartGoodsModel.discount_s count]>0) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@  %@",_cartGoodsModel.discount_s[0],_cartGoodsModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, [_cartGoodsModel.discount_s[0] length]+2)];
        [self.goodsNameLabel setAttributedText:aString];
    } else {
        [self.goodsNameLabel setText:[NSString stringWithFormat:@"%@",_cartGoodsModel.title]];
    }
    
    [self.priceLabel setText:[NSString stringWithFormat:@"¥%.2f",[_cartGoodsModel.marketprice floatValue]]];
    
    [self.editCountView.numTextField setText:[NSString stringWithFormat:@"%zd",(long)_cartGoodsModel.total]];
    
    [self.selectButton setSelected:_cartGoodsModel.selected];
}

#pragma mark - 减号点击
- (void)EditCountViewMinusClick:(UIButton *)sender {
    NSInteger goodsNumber = self.cartGoodsModel.total;
    if (1 < goodsNumber) {
        if (self.minsBtnClickBlock) {
            goodsNumber--;
            self.minsBtnClickBlock(self.cartGoodsModel, goodsNumber);
        }
    }
}

#pragma mark - 加号点击
- (void)EditCountViewPlusBtnClick:(UIButton *)sender{
    NSInteger goodsNumber = self.cartGoodsModel.total;
    if (self.plusBtnClickBlock) {
        goodsNumber++;
        self.plusBtnClickBlock(self.cartGoodsModel, goodsNumber);
    }
    
}

- (EditCountView *)editCountView {
    if (!_editCountView) {
        _editCountView = [[EditCountView alloc]init];
        [_editCountView.numTextField setDelegate:self];
        [_editCountView.minusBtn addTarget:self action:@selector(EditCountViewMinusClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editCountView.plusBtn addTarget:self action:@selector(EditCountViewPlusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editCountView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField setText:[NSString stringWithFormat:@"%zd",(long)_cartGoodsModel.total]];
    } else if ([textField.text integerValue] == 0) {
        if (self.endEditNumberBlock) {
            self.endEditNumberBlock(self.cartGoodsModel, 1);
        }
    } else {
        if (self.endEditNumberBlock) {
            self.endEditNumberBlock(self.cartGoodsModel, [textField.text integerValue]);
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
}

#pragma mark - lazy
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setTextColor:KUIColorFromHex(0xff463c)];
        [_priceLabel setFont:KFont(16)];
        [_priceLabel setText:@" "];
    }
    return _priceLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(14)];
        [_goodsNameLabel setNumberOfLines:2];
        [_goodsNameLabel setText:@" "];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageV {
    if (!_goodsImageV) {
        _goodsImageV = [[UIImageView alloc]init];
//        [_goodsImageV setBackgroundColor:KTableBackgroundColor];
    }
    return _goodsImageV;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_nor"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_sel"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
