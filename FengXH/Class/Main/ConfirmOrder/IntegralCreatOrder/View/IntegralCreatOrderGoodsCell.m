//
//  integralCreatOrderGoodsCell.m
//  FengXH
//
//  Created by sun on 2018/8/22.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "IntegralCreatOrderGoodsCell.h"
#import "IntegralCreatOrderResultModel.h"

@interface IntegralCreatOrderGoodsCell ()

/** 商店名称 */
@property(nonatomic , strong)UILabel *storeNameLabel;
/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 商品价格 */
@property(nonatomic , strong)UILabel *goodsPriceNumberLabel;

@end

@implementation IntegralCreatOrderGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *storeImageView = [[UIImageView alloc] init];
        [storeImageView setImage:[UIImage imageNamed:@"personal_wodexiaodian"]];
        [storeImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:storeImageView];
        [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(16);
            make.left.mas_offset(16);
            make.width.height.mas_equalTo(16);
        }];
        
        [self.contentView addSubview:self.storeNameLabel];
        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(storeImageView.mas_right).offset(8);
            make.centerY.mas_equalTo(storeImageView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(storeImageView.mas_bottom).offset(16);
            make.left.mas_offset(16);
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
            make.right.mas_equalTo(_goodsPriceNumberLabel.mas_left).offset(-12);
        }];
        
    }
    return self;
}

- (void)setResultModel:(IntegralCreatOrderResultModel *)resultModel {
    _resultModel = resultModel;
    [self.storeNameLabel setText:_resultModel.shopname];
    //积分、价格
    NSMutableAttributedString *pString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 积分\n¥ %@",_resultModel.credit?_resultModel.credit:@"",_resultModel.money?_resultModel.money:@""]];
//    [pString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(0, _goodsListModel.marketprice.length+1)];
    [self.goodsPriceNumberLabel setAttributedText:pString];
    
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_resultModel.thumb]];
    [self.goodsNameLabel setText:_resultModel.title];
}


#pragma mark - lazy
- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc] init];
        [_storeNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_storeNameLabel setFont:KFont(15)];
    }
    return _storeNameLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(14)];
        [_goodsNameLabel setNumberOfLines:3];
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceNumberLabel {
    if (!_goodsPriceNumberLabel) {
        _goodsPriceNumberLabel = [[UILabel alloc] init];
        [_goodsPriceNumberLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsPriceNumberLabel setFont:KFont(14)];
        [_goodsPriceNumberLabel setTextAlignment:NSTextAlignmentRight];
        [_goodsPriceNumberLabel setNumberOfLines:3];
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
