//
//  SpellGoodsDetailsFootView.m
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellGoodsDetailsFootView.h"
#import "M80AttributedLabel.h"
@interface SpellGoodsDetailsFootView()
@property (nonatomic ,strong)UIButton *homeBtn;
@property (nonatomic ,strong)UIButton *separateBtn;
@property (nonatomic ,strong)UIButton *groupBtn;
@property (nonatomic ,strong)M80AttributedLabel *separateLabel;
@property (nonatomic ,strong)M80AttributedLabel *groupLabel;
@end

@implementation SpellGoodsDetailsFootView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.homeBtn];
        [self.homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_offset(KDevice_Is_iPhoneX?58:34);
            make.left.top.mas_offset(0);
            make.bottom.mas_offset(KDevice_Is_iPhoneX?-34:0);
            make.width.mas_equalTo(60*KScreenRatio);
        }];
        [self addSubview:self.separateLabel];
        [self.separateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.homeBtn.mas_right).offset(0);
            make.top.mas_offset(0);
            make.bottom.mas_offset(KDevice_Is_iPhoneX?-34:0);
            make.width.mas_equalTo(165*KScreenRatio);
        }];
        [self addSubview:self.separateBtn];
        [self.separateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.separateLabel);
        }];
        
        [self addSubview:self.groupLabel];
        [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.separateBtn.mas_right).offset(0);
            
            make.top.mas_offset(0);
            make.bottom.mas_offset(KDevice_Is_iPhoneX?-34:0);
            make.width.mas_equalTo(150*KScreenRatio);
        }];
        
        [self addSubview:self.groupBtn];
        [self.groupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.groupLabel);
        }];

        
    }
    return self;
}
- (UIButton *)homeBtn{
    if (!_homeBtn) {
        _homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_homeBtn setTintColor:KRedColor];
        _homeBtn.tag = 200;
        [_homeBtn setImage:[UIImage imageNamed:@"home_icon_home_nol"] forState:UIControlStateNormal];
        [_homeBtn addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeBtn;
}
- (UIButton *)separateBtn{
    if (!_separateBtn) {
        _separateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _separateBtn.backgroundColor = [UIColor clearColor];
        
        _separateBtn.tag = 201;
        _separateBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [_separateBtn addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _separateBtn;
}
- (UIButton *)groupBtn{
    if (!_groupBtn) {
        _groupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _groupBtn.tag = 202;
        _groupBtn.backgroundColor = [UIColor clearColor];
        _groupBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [_groupBtn addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _groupBtn;
}
- (M80AttributedLabel *)separateLabel{
    if(!_separateLabel){
        _separateLabel = [[M80AttributedLabel alloc]init];
        _separateLabel.backgroundColor = KUIColorFromHex(0xf1827b);
        _separateLabel.lineSpacing = 5;
        _separateLabel.textAlignment = kCTTextAlignmentCenter;
        
    }
    
    return _separateLabel;
}
- (M80AttributedLabel *)groupLabel{
    if(!_groupLabel){
        _groupLabel = [[M80AttributedLabel alloc]init];
        _groupLabel.backgroundColor = KUIColorFromHex(0xec6258);
        _groupLabel.lineSpacing = 5;
        _groupLabel.textAlignment = kCTTextAlignmentCenter;
        
    }
    
    return _groupLabel;
}
- (void)cartButtonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onItemClick:)]) {
        [self.delegate onItemClick:sender.tag-200];
    }
}
- (void)setData:(NSArray *)dataArr{
    [_separateLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",dataArr[0]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    
    [_separateLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n单独购买"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    
    [_groupLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",dataArr[1]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    
    [_groupLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n团购"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}]];
}
@end
