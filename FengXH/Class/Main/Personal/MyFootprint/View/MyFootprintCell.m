//
//  MyFootprintCell.m
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyFootprintCell.h"
#import "MyFootprintResultModel.h"

@interface MyFootprintCell ()

/** 店铺名称 */
@property(nonatomic , strong)UILabel *storeNameLabel;
/** 浏览时间 */
@property(nonatomic , strong)UILabel *timeLabel;
/** 选择图标 */
@property(nonatomic , strong)UIButton *selectedButton;
/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** title */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 原价 */
@property(nonatomic , strong)UILabel *marketPriceLabel;
/** 现价 */
@property(nonatomic , strong)UILabel *productPriceLabel;

@end

@implementation MyFootprintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *storeImageView = [[UIImageView alloc] init];
        [storeImageView setImage:[UIImage imageNamed:@"personal_wodexiaodian"]];
        [storeImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:storeImageView];
        [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(7);
            make.left.mas_offset(12);
            make.width.height.mas_equalTo(16);
        }];
        
        [self.contentView addSubview:self.storeNameLabel];
        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(storeImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(storeImageView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(storeImageView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.selectedButton];
        [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(45);
            make.left.mas_offset(12);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(40);
            make.left.mas_offset(12);
            make.width.height.mas_equalTo(70);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_top);
            make.left.mas_equalTo(_goodsImageView.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        [self.contentView addSubview:self.marketPriceLabel];
        [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsNameLabel.mas_left);
            make.bottom.mas_equalTo(_goodsImageView.mas_bottom);
        }];
        
        [self.contentView addSubview:self.productPriceLabel];
        [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_marketPriceLabel.mas_right).offset(10);
            make.bottom.mas_equalTo(_goodsImageView.mas_bottom);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_offset(30);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setFootprintModel:(MyFootprintResultListModel *)footprintModel {
    _footprintModel = footprintModel;
    [self.storeNameLabel setText:_footprintModel.merchname];
    [self.timeLabel setText:_footprintModel.createtime];
    [self.selectedButton setSelected:_footprintModel.selected];
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_footprintModel.thumb]];
    [self.goodsNameLabel setText:_footprintModel.title];
    [self.marketPriceLabel setText:[NSString stringWithFormat:@"¥%@",_footprintModel.marketprice]];
    if ([_footprintModel.productprice floatValue] > 0) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",_footprintModel.productprice]];
        [attString addAttributes:@{NSFontAttributeName:KFont(16), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:KUIColorFromHex(0x999999), NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, _footprintModel.productprice.length+1)];
        [self.productPriceLabel setAttributedText:attString];
    } else {
        [self.productPriceLabel setText:@""];
    }
}

- (void)setEditingStatus:(BOOL)editingStatus {
    _editingStatus = editingStatus;
    if (_editingStatus) {
        [self.goodsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(40);
            make.left.mas_equalTo(_selectedButton.mas_right).offset(12);
            make.width.height.mas_equalTo(70);
        }];
    } else {
        [self.goodsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(40);
            make.left.mas_offset(12);
            make.width.height.mas_equalTo(70);
        }];
    }
}

#pragma mark - buttonAction
- (void)selectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [_selectedButton setSelected:sender.selected];
    self.footprintModel.selected = sender.selected;
}

#pragma mark - lazy
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setTextColor:KUIColorFromHex(0x333333)];
        [_timeLabel setFont:KFont(15)];
        [_timeLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc] init];
        [_storeNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_storeNameLabel setFont:KFont(16)];
    }
    return _storeNameLabel;
}

- (UILabel *)productPriceLabel {
    if (!_productPriceLabel) {
        _productPriceLabel = [[UILabel alloc]init];
        [_productPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_productPriceLabel setFont:KFont(16)];
        [_productPriceLabel setText:@" "];
    }
    return _productPriceLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        _marketPriceLabel = [[UILabel alloc]init];
        [_marketPriceLabel setTextColor:KRedColor];
        [_marketPriceLabel setFont:KFont(16)];
        [_marketPriceLabel setText:@" "];
    }
    return _marketPriceLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(15)];
        [_goodsNameLabel setNumberOfLines:2];
        [_goodsNameLabel setText:@" "];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]init];
        [_goodsImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_goodsImageView setBackgroundColor:KTableBackgroundColor];
    }
    return _goodsImageView;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"shopCar_btn_check_nor"] forState:UIControlStateNormal];
        [_selectedButton setImage:[UIImage imageNamed:@"shopCar_btn_check_sel"] forState:UIControlStateSelected];
        [_selectedButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
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
