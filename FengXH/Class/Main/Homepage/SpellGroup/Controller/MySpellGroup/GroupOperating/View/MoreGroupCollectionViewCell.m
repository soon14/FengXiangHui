//
//  MoreGroupCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MoreGroupCollectionViewCell.h"
#import "M80AttributedLabel.h"
#import "MoreGoodsModel.h"
@interface MoreGroupCollectionViewCell()
@property (nonatomic ,strong) UIImageView *thumb;
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) M80AttributedLabel *price;
@property (nonatomic ,strong) UILabel *originalPrice;
@property (nonatomic ,strong) UILabel *groupNum;

@end

@implementation MoreGroupCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.thumb];
        [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(5);
            make.right.mas_offset(-5);
            make.height.mas_equalTo(165);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.right.mas_offset(-5);
            make.top.mas_equalTo(self.thumb.mas_bottom).offset(10);
            make.height.mas_equalTo(40);
        }];
        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.bottom.mas_offset(-2);
            make.top.mas_equalTo(self.title.mas_bottom).offset(5);
            
        }];
        [self addSubview:self.originalPrice];
        [self.originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.price.mas_right).offset(1);
            make.bottom.mas_offset(-2);
            make.top.mas_equalTo(self.title.mas_bottom).offset(5);
            
        }];
        [self addSubview:self.groupNum];
        [self.groupNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-5);
            make.bottom.mas_offset(-2);
            make.top.mas_equalTo(self.title.mas_bottom).offset(5);
            
        }];
    }
    return self;
}
- (UIImageView *)thumb{
    if (!_thumb) {
        _thumb = [[UIImageView alloc]init];
    }
    return _thumb;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        [_title setTextColor:[UIColor blackColor]];
        [_title setTextAlignment:NSTextAlignmentLeft];
        [_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.f]];
        _title.numberOfLines = 0;
    }
    return _title;
}
- (M80AttributedLabel *)price{
    if (!_price) {
        _price = [[M80AttributedLabel alloc]init];
        _price.textAlignment = kCTTextAlignmentLeft;
        _price.font = KFont(12);
    }
    return _price;
}
- (UILabel *)originalPrice{
    if (!_originalPrice) {
        _originalPrice = [[UILabel alloc]init];
        [_originalPrice setTextColor:KUIColorFromHex(0x666666)];
        [_originalPrice setTextAlignment:NSTextAlignmentLeft];
        _originalPrice.font = KFont(12);
        
    }
    return _originalPrice;
}
- (UILabel *)groupNum{
    if (!_groupNum) {
        _groupNum = [[UILabel alloc]init];
        [_groupNum setTextColor:KUIColorFromHex(0x666666)];
        [_groupNum setTextAlignment:NSTextAlignmentRight];
        _groupNum.font = KFont(12);
        
    }
    return _groupNum;
}
- (void)setMoreGoodsModel:(MoreGoodsModel *)moreGoodsModel{
    _moreGoodsModel = moreGoodsModel;
    [self.thumb setYy_imageURL:[NSURL URLWithString:_moreGoodsModel.thumb]];
    [self.title setText:[NSString stringWithFormat:@"%@",_moreGoodsModel.title]];
    
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSAttributedString *attribtStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_moreGoodsModel.price] attributes:attribtDic];
    _originalPrice.attributedText = attribtStr;
    

    
    [_price setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥"] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_price appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_moreGoodsModel.groupsprice] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [self.groupNum setText:[NSString stringWithFormat:@"%@人参团",_moreGoodsModel.fightnum]];

}
@end
