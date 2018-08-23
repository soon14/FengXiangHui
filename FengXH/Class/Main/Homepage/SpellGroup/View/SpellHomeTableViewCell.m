//
//  SpellHomeTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellHomeTableViewCell.h"
#import "SpellHomeModel.h"
#import "M80AttributedLabel.h"
@interface SpellHomeTableViewCell()
//thumb
@property (nonatomic ,strong)UIImageView *img;
//红色背景 图标
@property (nonatomic ,strong)UIImageView *icon;
@property (nonatomic ,strong)UILabel *title;
//描述
@property (nonatomic ,strong)UILabel *description1;
// 原价
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UIView *redView;
//几人团¥价格/件数
@property (nonatomic ,strong)M80AttributedLabel *group;
//去拼团
@property (nonatomic ,strong)UILabel *goGroup;
@property (nonatomic ,strong)UIView *line;
@end

@implementation SpellHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(5);
            make.bottom.mas_offset(-15);
            make.width.mas_equalTo(115);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-20);
            make.left.mas_equalTo(self.img.mas_right).offset(10);
            make.height.mas_equalTo(25);
        }];
        [self addSubview:self.description1];
        [self.description1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.title.mas_bottom).offset(5);
            make.right.mas_offset(-20);
            make.left.mas_equalTo(self.img.mas_right).offset(10);
            make.height.mas_equalTo(12);
        }];
        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.description1.mas_bottom).offset(24);
            make.right.mas_offset(-20);
            make.left.mas_equalTo(self.img.mas_right).offset(10);
            make.height.mas_equalTo(12);
        }];
        
        [self addSubview:self.redView];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.price.mas_bottom).offset(3);
            make.right.mas_offset(-10);
            make.left.mas_equalTo(self.img.mas_right).offset(10);
            make.height.mas_equalTo(25);
        }];
        [self.redView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.redView).offset(0.5);
            make.bottom.mas_equalTo(self.redView).offset(-0.5);
            make.width.mas_equalTo(25);
            make.left.mas_equalTo(self.redView.mas_left).offset(2);

        }];
        
        [self.redView addSubview:self.group];
        [self.group mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.redView).offset(2);
            make.bottom.mas_equalTo(self.redView).offset(0);
            make.width.mas_equalTo(110*KScreenRatio);
            make.left.mas_equalTo(self.redView.mas_left).offset(33*KScreenRatio);
            
        }];
        [self.redView addSubview:self.goGroup];
        [self.goGroup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(self.redView).offset(0);
            
            make.width.mas_equalTo(50*KScreenRatio);
            
            
        }];

        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(10);
        }];
    }
    return self;
}
- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        
    }
    return _img;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        [_title setTextColor:[UIColor blackColor]];
        [_title setTextAlignment:NSTextAlignmentLeft];
        [_title setFont:KFont(16)];
        
//        _title.lineBreakMode = NSLineBreakByCharWrapping;
        
    }
    return _title;
}
- (UILabel *)description1{
    if (!_description1) {
        _description1 = [[UILabel alloc]init];
        [_description1 setTextColor:KUIColorFromHex(0x666666)];
        [_description1 setTextAlignment:NSTextAlignmentLeft];
        [_description1 setFont:KFont(12)];
        
        
    }
    return _description1;
}
- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]init];
        [_price setTextColor:KUIColorFromHex(0xec6258)];
        [_price setTextAlignment:NSTextAlignmentLeft];
        [_price setFont:KFont(13)];
        
    }
    return _price;
}
- (UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = KUIColorFromHex(0xf1827b);
        _redView.layer.cornerRadius = 12.5;
        _redView.clipsToBounds = YES;
    }
    return _redView;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.backgroundColor = [UIColor whiteColor];
        _icon.layer.cornerRadius = 12;
        self.icon.layer.masksToBounds=YES;
        [_icon setImage:[UIImage imageNamed:@"icon_my"]];
    }
    return _icon;
}
- (M80AttributedLabel *)group{
    if (!_group) {
        _group = [[M80AttributedLabel alloc]init];
        
        _group.backgroundColor = [UIColor clearColor];
        [_group setFont:KFont(13)];
        
    }
    return _group;
}
- (UILabel *)goGroup{
    if (!_goGroup) {
        _goGroup = [[UILabel alloc]init];
        [_goGroup setTextColor:[UIColor whiteColor]];
        _goGroup.backgroundColor = KUIColorFromHex(0xec6258);
        [_goGroup setTextAlignment:NSTextAlignmentCenter];
        [_goGroup setFont:KFont(13)];
        [_goGroup setText:@"去拼团>"];
    }
    return _goGroup;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
-(void)setSpellHomeModel:(SpellHomeModel *)spellHomeModel{
    _spellHomeModel = spellHomeModel;
    [self.img setYy_imageURL:[NSURL URLWithString:_spellHomeModel.thumb]];
    [self.title setText:[NSString stringWithFormat:@"%@",_spellHomeModel.title]];
    [self.description1 setText:[NSString stringWithFormat:@"%@",_spellHomeModel.spell_description]];
    //原价
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价：¥%@",_spellHomeModel.price] attributes:attribtDic];
    _price.attributedText = attribtStr;
    // 团价格/件数
    [_group setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人团¥",_spellHomeModel.groupnum] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    [_group appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_spellHomeModel.groupsprice] attributes:@{NSFontAttributeName:KFont(16),NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    [_group appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"/%@%@",_spellHomeModel.goodsnum,_spellHomeModel.units] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    
    
}
@end
