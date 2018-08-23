//
//  MyOrderCell.m
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDefaultCell.h"
#import "MyOrderResultModel.h"

@interface OrderDefaultCell ()

/** storeName */
//@property(nonatomic , strong)UILabel *storeNameLabel;
/** goodsImage */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** goodsName */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 商品单价 */
@property(nonatomic , strong)UILabel *goodsPriceLabel;
/** 商品数量 */
@property(nonatomic , strong)UILabel *goodsNumLabel;

@end

@implementation OrderDefaultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
//        UIImageView *storeImageView = [[UIImageView alloc] init];
//        [storeImageView setImage:[UIImage imageNamed:@"order_store"]];
//        [storeImageView setContentMode:UIViewContentModeScaleAspectFit];
//        [self.contentView addSubview:storeImageView];
//        [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(10);
//            make.top.mas_offset(12);
//            make.width.height.mas_equalTo(16);
//        }];
//
//        [self.contentView addSubview:self.storeNameLabel];
//        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(storeImageView.mas_right).offset(5);
//            make.centerY.mas_equalTo(storeImageView.mas_centerY);
//        }];
        
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

- (void)setOrderGoodsModel:(MyOrderResultListGoodsModel *)orderGoodsModel {
    _orderGoodsModel = orderGoodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_orderGoodsModel.thumb]];
    [self.goodsNameLabel setText:_orderGoodsModel.title];
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"¥ %@",_orderGoodsModel.price]];
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"x %@",_orderGoodsModel.total]];
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

//- (UILabel *)storeNameLabel {
//    if (!_storeNameLabel) {
//        _storeNameLabel = [[UILabel alloc] init];
//        [_storeNameLabel setTextColor:KUIColorFromHex(0x666666)];
//        [_storeNameLabel setFont:KFont(13)];
//        [_storeNameLabel setText:@"疯享汇全球优享商城"];
//    }
//    return _storeNameLabel;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
