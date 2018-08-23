//
//  ParticipateHeaderView.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ParticipateHeaderView.h"
#import "M80AttributedLabel.h"
#import "GroupOperatingModel.h"
@interface ParticipateHeaderView()
@property (nonatomic ,strong) UIImageView *thumb;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) M80AttributedLabel *priceLabel;
@property (nonatomic ,strong) M80AttributedLabel *groupNumLabel;
@property (nonatomic ,strong) UIView *line;
@property (nonatomic ,strong) UILabel *label;
@end
@implementation ParticipateHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.thumb];
        [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(22);
            make.left.mas_offset(5);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(60*KScreenRatio);
            
        }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(12);
            make.right.mas_offset(-20);
            make.left.mas_equalTo(self.thumb.mas_right).offset(5);
            make.height.mas_equalTo(40);
        }];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.thumb.mas_bottom).offset(10);
            make.height.mas_equalTo(5);
        }];
        [self addSubview:self.groupNumLabel];
        [self.groupNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-9);
            make.bottom.mas_equalTo(self.line.mas_top).offset(-10);
            make.height.mas_equalTo(20);
            
        }];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumb.mas_right).offset(5);
            make.bottom.mas_equalTo(self.line.mas_top).offset(-10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(160*KScreenRatio);
        }];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.height.mas_equalTo(20);
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
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.f]];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
- (M80AttributedLabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[M80AttributedLabel alloc]init];
        _priceLabel.textAlignment = kCTTextAlignmentLeft;
    }
    return _priceLabel;
}
- (M80AttributedLabel *)groupNumLabel{
    if (!_groupNumLabel) {
        _groupNumLabel = [[M80AttributedLabel alloc]init];
        _groupNumLabel.textAlignment = kCTTextAlignmentRight;
    }
    return _groupNumLabel;
}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        [_label setTextColor:[UIColor blackColor]];
        [_label setTextAlignment:NSTextAlignmentLeft];
        [_label setFont:KFont(14)];
        _label.text = @"以下小伙伴正在发起拼团，您可以直接参加";
    }
    return _label;
}
- (void)setGroupOperatingModel:(GroupOperatingModel *)groupOperatingModel{
    _groupOperatingModel = groupOperatingModel;
    [self.thumb setYy_imageURL:[NSURL URLWithString:_groupOperatingModel.thumb]];
    [self.titleLabel setText:[NSString stringWithFormat:@"%@",_groupOperatingModel.title]];
    [_priceLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人团:",_groupOperatingModel.groupnum] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_priceLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥"] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_priceLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_groupOperatingModel.groupsprice] attributes:@{NSFontAttributeName:KFont(16),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_priceLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"/%@%@",_groupOperatingModel.goodsnum,_groupOperatingModel.units] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    NSArray *comp1 = @[@"已有",@"人参团"];
    
    for (NSString *text in comp1)
    {
        if (text == comp1[0]) {
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:KUIColorFromHex(0x666666)];
            
            [_groupNumLabel appendAttributedText:attributedText];
            [_groupNumLabel appendText:[NSString stringWithFormat:@"%@",_groupOperatingModel.fightnum]];
        }else{
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:KUIColorFromHex(0x666666)];
            
            [_groupNumLabel appendAttributedText:attributedText];
            
        }
        
    }

}
@end
