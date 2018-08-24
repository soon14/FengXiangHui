//
//  ConfirmOrderGoodsCell.m
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderGoodsCell.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderGoodsCell ()

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 商品价格 */
@property(nonatomic , strong)UILabel *goodsPriceNumberLabel;
/** 是否是京东商品 */
@property(nonatomic , strong)UILabel *JDGoodsLabel;

@end

@implementation ConfirmOrderGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.width.mas_equalTo(90);
        }];
        
        [self.contentView addSubview:self.goodsPriceNumberLabel];
        [self.goodsPriceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_top);
            make.right.mas_offset(-12);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_top);
            make.left.mas_equalTo(_goodsImageView.mas_right).offset(10);
            make.right.mas_equalTo(_goodsPriceNumberLabel.mas_left).offset(-10);
        }];
        
        [self.contentView addSubview:self.JDGoodsLabel];
        [self.JDGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_goodsPriceNumberLabel);
            make.bottom.mas_equalTo(_goodsImageView.mas_bottom);
        }];
    }
    return self;
}

- (void)setGoodsListModel:(ConfirmOrderCreatResultGoodsListGoodsModel *)goodsListModel {
    _goodsListModel = goodsListModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_goodsListModel.thumb]];
    
    //价格、数量
    NSMutableAttributedString *pString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@\nx %@",_goodsListModel.marketprice,_goodsListModel.total]];
    [pString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(0, _goodsListModel.marketprice.length+1)];
    [self.goodsPriceNumberLabel setAttributedText:pString];
    
    //京东商品 or 折扣 + 商品名
    if (_goodsListModel.jd_saleState) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 京东  %@",_goodsListModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor,NSFontAttributeName:KFont(13)} range:NSMakeRange(0, 4)];
        [self.goodsNameLabel setAttributedText:aString];
    } else if ([_goodsListModel.discount_s count] > 0 && [_goodsListModel.discount_s[0] length] > 0) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@  %@",_goodsListModel.discount_s[0],_goodsListModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, [_goodsListModel.discount_s[0] length]+2)];
        [self.goodsNameLabel setAttributedText:aString];
    } else {
        [self.goodsNameLabel setText:[NSString stringWithFormat:@"%@",_goodsListModel.title]];
    }
    
    //京东是否有货
    if (_goodsListModel.jd_saleState) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"京东商品：%@",_goodsListModel.jd_kpl?_goodsListModel.jd_kpl:@""]];
        [aString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(0, 5)];
        [self.JDGoodsLabel setAttributedText:aString];
    } else {
        [self.JDGoodsLabel setText:@""];
    }
}

#pragma mark - lazy
- (UILabel *)JDGoodsLabel {
    if (!_JDGoodsLabel) {
        _JDGoodsLabel = [[UILabel alloc] init];
        [_JDGoodsLabel setTextColor:KRedColor];
        [_JDGoodsLabel setFont:KFont(14)];
        [_JDGoodsLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _JDGoodsLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(14)];
        [_goodsNameLabel setNumberOfLines:2];
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceNumberLabel {
    if (!_goodsPriceNumberLabel) {
        _goodsPriceNumberLabel = [[UILabel alloc] init];
        [_goodsPriceNumberLabel setTextColor:KUIColorFromHex(0x999999)];
        [_goodsPriceNumberLabel setFont:KFont(14)];
        [_goodsPriceNumberLabel setTextAlignment:NSTextAlignmentRight];
        [_goodsPriceNumberLabel setNumberOfLines:2];
    }
    return _goodsPriceNumberLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        [_goodsImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _goodsImageView;
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
