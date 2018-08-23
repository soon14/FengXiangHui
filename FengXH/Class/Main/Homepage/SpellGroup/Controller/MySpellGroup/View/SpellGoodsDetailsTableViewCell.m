//
//  SpellGoodsDetailsTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellGoodsDetailsTableViewCell.h"
#import "M80AttributedLabel.h"
#import "SpellGoodsDetailsModel.h"
@interface SpellGoodsDetailsTableViewCell()
@property (nonatomic ,strong) M80AttributedLabel *titleLabel;
@property (nonatomic ,strong) UILabel *describeLabel;
@property (nonatomic ,strong) M80AttributedLabel *priceLabel;
@property (nonatomic ,strong) UILabel *originalLabel;
@property (nonatomic ,strong) M80AttributedLabel *groupLabel;
@property (nonatomic ,strong) SpellGoodsDetailsModel *spellGoodsDetailsModel;
@end

@implementation SpellGoodsDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(5);
            make.right.mas_offset(-5);
            make.height.mas_equalTo(50);
        }];
        [self addSubview:self.describeLabel];
        [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
            make.left.mas_offset(5);
            make.right.mas_offset(-5);
            make.height.mas_equalTo(24);
        }];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.describeLabel.mas_bottom).offset(5);
            make.left.mas_offset(5);
            make.bottom.mas_offset(-5);
//            make.width.mas_equalTo(24);
        }];
        [self addSubview:self.originalLabel];
        [self.originalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.describeLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.priceLabel.mas_right).offset(5);
            make.bottom.mas_offset(-5);
            //            make.width.mas_equalTo(24);
        }];
        [self addSubview:self.groupLabel];
        [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.describeLabel.mas_bottom).offset(5);
            make.right.mas_offset(-5);
            make.bottom.mas_offset(-5);
            //            make.width.mas_equalTo(24);
        }];
    }
    return self;
}
- (M80AttributedLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[M80AttributedLabel alloc]init];
        

    }
    return _titleLabel;
}
- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_describeLabel setTextAlignment:NSTextAlignmentLeft];
        [_describeLabel setFont:KFont(12)];
        
        
    }
    return _describeLabel;
}
- (M80AttributedLabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[M80AttributedLabel alloc]init];
    }
    return _priceLabel;
}
- (UILabel *)originalLabel{
    if (!_originalLabel) {
        _originalLabel = [[UILabel alloc]init];
        [_originalLabel setTextColor:KUIColorFromHex(0x666666)];
        [_originalLabel setTextAlignment:NSTextAlignmentLeft];
        [_originalLabel setFont:KFont(10)];
        
    }
    return _originalLabel;
}
- (M80AttributedLabel *)groupLabel{
    if (!_groupLabel) {
        _groupLabel = [[M80AttributedLabel alloc]init];
    }
    return _groupLabel;
}
- (void)setData:(id)data{
    self.spellGoodsDetailsModel = data;
//    [self.titleLabel setText:[NSString stringWithFormat:@"%@",_spellGoodsDetailsModel.title]];
    [_titleLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人成团",_spellGoodsDetailsModel.groupnum] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:16.f],NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_titleLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_spellGoodsDetailsModel.title] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:16.f],NSForegroundColorAttributeName:[UIColor blackColor],NSBackgroundColorAttributeName:[UIColor whiteColor]}]];
    [_describeLabel setText:[NSString stringWithFormat:@"%@",_spellGoodsDetailsModel.spell_description]];
    [_priceLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_spellGoodsDetailsModel.price] attributes:@{NSFontAttributeName:KFont(16),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_priceLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",_spellGoodsDetailsModel.goodsnum,_spellGoodsDetailsModel.units] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor],NSBackgroundColorAttributeName:[UIColor whiteColor]}]];
    
    
    //原价
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_spellGoodsDetailsModel.price] attributes:attribtDic];
    _originalLabel.attributedText = attribtStr;
    
    [_priceLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_spellGoodsDetailsModel.groupsprice] attributes:@{NSFontAttributeName:KFont(16),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_priceLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",_spellGoodsDetailsModel.goodsnum,_spellGoodsDetailsModel.units] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor],NSBackgroundColorAttributeName:[UIColor whiteColor]}]];

    NSArray *comp = @[@"已有",@"参团,",@"销量"];
    
    for (NSString *text in comp)
    {
        if (text == comp[0]) {
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:KUIColorFromHex(0x666666)];
            
            [_groupLabel appendAttributedText:attributedText];
            [_groupLabel appendText:[NSString stringWithFormat:@"%@",_spellGoodsDetailsModel.teamnum]];
        }else if (text == comp[1]){
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:KUIColorFromHex(0x666666)];
            [_groupLabel appendAttributedText:attributedText];
        }else{
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:KUIColorFromHex(0x666666)];
            
            [_groupLabel appendAttributedText:attributedText];
            [_groupLabel appendText:[NSString stringWithFormat:@"%@",_spellGoodsDetailsModel.sales]];
        }
        
        
    }
    
    
}

@end
