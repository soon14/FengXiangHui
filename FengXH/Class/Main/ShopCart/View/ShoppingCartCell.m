//
//  ShoppingCartCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShoppingCartCell.h"

@implementation ShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:self.selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        //
        [self addSubview:self.goodsImageV];
        [self.goodsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_selectButton.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(100);
        }];
        
        //
        [self addSubview:self.goodsNameLabel];
//        [self.goodsNameLabel setBackgroundColor:[UIColor yellowColor]];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageV.mas_right).offset(13);
            make.right.mas_offset(-16);
            make.top.mas_offset(15);
        }];
        
        //
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageV.mas_right).offset(13);
            make.bottom.mas_equalTo(_goodsImageV.mas_bottom).offset(-10);
            make.height.mas_equalTo(25);
        }];
        
        
        //数量编辑框
        [self addSubview:self.editCountView];
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
    sender.selected = !sender.selected;
    self.cartGoodsModel.goodsSelected = sender.selected;
    [self.selectButton setSelected:self.cartGoodsModel.goodsSelected];
    if (self.selectClickBlock) {
        self.selectClickBlock(self.cartGoodsModel);
    }
}

- (void)setCartGoodsModel:(ShoppingCartGoodsModel *)cartGoodsModel {
    _cartGoodsModel = cartGoodsModel;
    [self.goodsNameLabel setText:cartGoodsModel.goods_name];
    [self.priceLabel setText:cartGoodsModel.goods_price];
    [self.editCountView.numTextField setText:[NSString stringWithFormat:@"%zd",cartGoodsModel.goods_num]];
    
    [self.selectButton setSelected:cartGoodsModel.goodsSelected];
}

#pragma mark - 减号点击
- (void)EditCountViewMinusClick:(UIButton *)sender {
    // 至于加减操作。这里就要用
    if (self.cartGoodsModel.goods_num > 1) {
        self.cartGoodsModel.goods_num --;
        self.editCountView.numTextField.text = [NSString stringWithFormat:@"%zd",self.cartGoodsModel.goods_num];
    } else {
        // 属性不能少于1，做一个友好提示
    }
    
    if (self.minsBtnClickBlock) {
        self.minsBtnClickBlock(self.cartGoodsModel);
    }
}

#pragma mark - 加号点击
- (void)EditCountViewPlusBtnClick:(UIButton *)sender{
    // 至于加减操作。这里就要对 模型 做操作方法
    self.cartGoodsModel.goods_num ++;
    self.editCountView.numTextField.text = [NSString stringWithFormat:@"%zd",self.cartGoodsModel.goods_num];
    if (self.plusBtnClickBlock) {
        self.plusBtnClickBlock(self.cartGoodsModel);
    }
}

- (EditCountView *)editCountView {
    if (!_editCountView) {
        _editCountView = [[EditCountView alloc]init];
        [_editCountView setBackgroundColor:KTableBackgroundColor];
        [_editCountView.numTextField setDelegate:self];
        [_editCountView.minusBtn addTarget:self action:@selector(EditCountViewMinusClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editCountView.plusBtn addTarget:self action:@selector(EditCountViewPlusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editCountView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.cartGoodsModel.goods_num = [self.editCountView.numTextField.text integerValue];
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        [_priceLabel setBackgroundColor:KTableBackgroundColor];
        [_priceLabel setTextColor:KUIColorFromHex(0xff463c)];
        [_priceLabel setFont:KFont(16)];
        [_priceLabel setText:@"¥5439"];
    }
    return _priceLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(14)];
        [_goodsNameLabel setNumberOfLines:2];
        [_goodsNameLabel setText:@"GUCCI 古驰 新款男士银色闪光织物休闲鞋"];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageV {
    if (!_goodsImageV) {
        _goodsImageV = [[UIImageView alloc]init];
        [_goodsImageV setBackgroundColor:KTableBackgroundColor];
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
