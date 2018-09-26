//
//  TitleCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "TitleCollectionViewCell.h"
#import "M80AttributedLabel.h"
#import "GroupOperatingModel.h"
@interface TitleCollectionViewCell()

@property (nonatomic ,strong) UIImageView *thumb;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) M80AttributedLabel *priceLabel;
@property (nonatomic ,strong) M80AttributedLabel *groupNumLabel;
@property (nonatomic ,strong) UIView *line;
@property (nonatomic ,strong) M80AttributedLabel *invitationLabel;
@property (nonatomic ,strong) UIButton *participateGroupBtn;
@property (nonatomic ,strong) UIButton *openGroupBtn;
@property (nonatomic ,strong) UIView *line1;
@property (nonatomic ,strong) UIView *redLine;
@property (nonatomic ,strong) UIImageView *playImg;
@property (nonatomic ,strong) UIButton *playBtn;

@end

@implementation TitleCollectionViewCell
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
            make.height.mas_equalTo(60);
        }];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.thumb.mas_bottom).offset(22);
            make.height.mas_equalTo(1);
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
        [self addSubview:self.invitationLabel];
        [self.invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.line.mas_bottom).offset(10);
            make.height.mas_equalTo(40);

        }];
        [self addSubview:self.participateGroupBtn];
        [self.participateGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.width.mas_equalTo(KMAINSIZE.width/2-30*KScreenRatio);
            make.top.mas_equalTo(self.invitationLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
            
        }];
        
        [self addSubview:self.openGroupBtn];
        [self.openGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.width.mas_equalTo(KMAINSIZE.width/2-30*KScreenRatio);
            make.top.mas_equalTo(self.invitationLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
            
        }];
        [self addSubview:self.line1];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_offset(0);
            make.top.mas_equalTo(self.openGroupBtn.mas_bottom).offset(20);
            make.height.mas_equalTo(5);
            
        }];
        [self addSubview:self.playImg];
        [self.playImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.left.mas_offset(0);
            make.top.mas_equalTo(self.openGroupBtn.mas_bottom).offset(25);
            
        }];
        [self addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(self.playImg).offset(0);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(95*KScreenRatio);
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
- (M80AttributedLabel *)invitationLabel{
    if (!_invitationLabel) {
        _invitationLabel = [[M80AttributedLabel alloc]init];
        _invitationLabel.textAlignment = kCTTextAlignmentLeft;
        _invitationLabel.textColor = KUIColorFromHex(0xec6258);
    }
    return _invitationLabel;
}

- (UIButton *)participateGroupBtn{
    if (!_participateGroupBtn) {
        _participateGroupBtn = [[UIButton alloc]init];
        _participateGroupBtn.backgroundColor = KUIColorFromHex(0xffffff);
        [_participateGroupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _participateGroupBtn.layer.cornerRadius = 5;
        _participateGroupBtn.titleLabel.font = KFont(15);
//        KRedColor
        _participateGroupBtn.tag = 80;
        _participateGroupBtn.layer.borderColor = [UIColor blackColor].CGColor;//颜色
        _participateGroupBtn.layer.borderWidth = 0.5f;//设置边框粗细
        [_participateGroupBtn setTitle:@"我要参团" forState:UIControlStateNormal];
        [_participateGroupBtn addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _participateGroupBtn;
}
- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = KTableBackgroundColor;
    }
    return _line1;
}
- (UIImageView *)playImg{
    if (!_playImg) {
        _playImg = [[UIImageView alloc]init];
        [_playImg setImage:[UIImage imageNamed:@"play"]];
    }
    return _playImg;
}
- (UIButton *)openGroupBtn{
    if (!_openGroupBtn) {
        _openGroupBtn = [[UIButton alloc]init];
        _openGroupBtn.backgroundColor = KRedColor;
        [_openGroupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _openGroupBtn.layer.cornerRadius = 5;
        _openGroupBtn.titleLabel.font = KFont(15);
        _openGroupBtn.tag = 81;
        
        [_openGroupBtn setTitle:@"我要开团" forState:UIControlStateNormal];
        [_openGroupBtn addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openGroupBtn;
}
- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [[UIButton alloc]init];
        _playBtn.backgroundColor = [UIColor clearColor];
        _playBtn.tag = 82;
        [_playBtn addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
- (void)cartButtonAction:(UIButton *)sender{
    if (self.mdelegate &&[self.mdelegate respondsToSelector:@selector(btnClicked:)]) {
        [self.mdelegate btnClicked:sender.tag-80];
    }
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

    NSArray *comp = @[@"支付开团并邀请",@"人参加，人数不足自动退款，详情见下方拼团玩法"];

    for (NSString *text in comp)
    {
        if (text == comp[0]) {
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:[UIColor blackColor]];

            [_invitationLabel appendAttributedText:attributedText];
            [_invitationLabel appendText:[NSString stringWithFormat:@"%@",_groupOperatingModel.groupnum]];
        }else{
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedText m80_setFont:[UIFont systemFontOfSize:13]];
            [attributedText m80_setTextColor:[UIColor blackColor]];
            
            [_invitationLabel appendAttributedText:attributedText];
            
        }

    }
}
@end
