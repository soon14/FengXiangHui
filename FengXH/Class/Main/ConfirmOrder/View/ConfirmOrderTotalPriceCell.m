//
//  ConfirmOrderTotalPriceCell.m
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderTotalPriceCell.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderTotalPriceCell ()

/** 价格 */
@property(nonatomic , strong)UILabel *priceLabel;

@end

@implementation ConfirmOrderTotalPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setResultModel:(ConfirmOrderCreatResultModel *)resultModel {
    _resultModel = resultModel;
    
    NSInteger goodsNum = 0;
    for (ConfirmOrderCreatResultGoodsListModel *goodsListModel in _resultModel.goods_list) {
        for (ConfirmOrderCreatResultGoodsListGoodsModel *goodsListGoodsModel in goodsListModel.goods) {
            goodsNum = goodsNum + [goodsListGoodsModel.total integerValue];
        }
    }
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共 %ld 个商品，共计：¥%.2f",(long)goodsNum,[_resultModel.subtotalprice floatValue]]];
    
    [aString addAttributes:@{NSForegroundColorAttributeName:KRedColor} range:NSMakeRange(2, [NSString stringWithFormat:@"%ld",(long)goodsNum].length)];
    [aString addAttributes:@{NSForegroundColorAttributeName:KRedColor} range:NSMakeRange([NSString stringWithFormat:@"%ld",(long)goodsNum].length + 10, aString.length - ([NSString stringWithFormat:@"%ld",(long)goodsNum].length + 10))];
    [self.priceLabel setAttributedText:aString];
}

#pragma mark - lazy
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_priceLabel setFont:KFont(14)];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _priceLabel;
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
