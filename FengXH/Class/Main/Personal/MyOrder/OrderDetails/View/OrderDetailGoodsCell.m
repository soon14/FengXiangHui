//
//  OrderDetailGoodsCell.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailGoodsCell.h"
#import "OrderDetailResultModel.h"

@interface OrderDetailGoodsCell ()

/** goodsImage */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** goodsName */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 商品单价 */
@property(nonatomic , strong)UILabel *goodsPriceLabel;
/** 商品数量 */
@property(nonatomic , strong)UILabel *goodsNumLabel;

@end

@implementation OrderDetailGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_offset(12);
            make.width.height.mas_equalTo(80);
        }];
        
        [self.contentView addSubview:self.goodsPriceLabel];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_top).offset(6);
            make.right.mas_offset(-10);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsPriceLabel.mas_top);
            make.left.mas_equalTo(_goodsImageView.mas_right).offset(10);
            make.right.mas_equalTo(_goodsPriceLabel.mas_left).offset(-20);
        }];
        
        
        
        [self.contentView addSubview:self.goodsNumLabel];
        [self.goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsPriceLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(_goodsPriceLabel.mas_right);
        }];
        
    }
    return self;
}

- (void)setGoodsModel:(OrderDetailResultGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_goodsModel.thumb]];
    [self.goodsNameLabel setText:_goodsModel.title];
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"¥ %@",_goodsModel.price]];
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"x %@",_goodsModel.total]];
}


#pragma mark - lazy
- (UILabel *)goodsNumLabel {
    if (!_goodsNumLabel) {
        _goodsNumLabel = [[UILabel alloc] init];
        [_goodsNumLabel setTextColor:KUIColorFromHex(0x999999)];
        [_goodsNumLabel setFont:KFont(14)];
        [_goodsNumLabel setTextAlignment:NSTextAlignmentRight];
        //        [_goodsNumLabel setText:@"X 2"];
    }
    return _goodsNumLabel;
}

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        [_goodsPriceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsPriceLabel setFont:KFont(14)];
        [_goodsPriceLabel setTextAlignment:NSTextAlignmentRight];
        //        [_goodsPriceLabel setText:@"¥ 2121.10"];
    }
    return _goodsPriceLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(14)];
        [_goodsNameLabel setNumberOfLines:2];
        //        [_goodsNameLabel setText:@"技术测试技术测试技术测试技术测试"];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        [_goodsImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_goodsImageView setBackgroundColor:KTableBackgroundColor];
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
