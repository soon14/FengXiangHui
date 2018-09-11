//
//  KillTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "KillTableViewCell.h"
#import "SecondsKillModel.h"

@interface KillTableViewCell()

@property(nonatomic , strong)UIImageView *killImageView;
@property(nonatomic , strong)UILabel *killTitleLabel;
@property(nonatomic , strong)UILabel *killPriceLabel;
@property(nonatomic , strong)UILabel *killMarketprice;
@property(nonatomic , strong)UILabel *killSellLabel;
@property(nonatomic , strong)UILabel *killBuyLabel;
@property(nonatomic , strong)UIView *backView;
//百分比线
@property(nonatomic , strong)UIView *whiteView;
@property(nonatomic , strong)UILabel *redLabel;

@end

@implementation KillTableViewCell
{
    NSInteger inter;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_offset(11);
            make.right.mas_offset(-11);
        }];
        
        [self.backView addSubview:self.killImageView];
        [self.killImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.backView.mas_centerY);
            make.width.height.mas_equalTo(90);
        }];
        
        
        [self.backView addSubview:self.killTitleLabel];
        [self.killTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(20);
            make.right.mas_offset(-8);
            make.left.mas_equalTo(self.killImageView.mas_right).offset(8);
            make.height.mas_equalTo(40);
        }];
        
        
        [self.backView addSubview:self.killBuyLabel];
        [self.killBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_killTitleLabel.mas_bottom).offset(12);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(28);
        }];
        

        [self.backView addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_killBuyLabel.mas_right);
            make.top.mas_equalTo(_killBuyLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(7);
        }];
        
        [self.whiteView addSubview:self.redLabel];
        [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.left.mas_offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(7);
        }];
        
        
        [self.backView addSubview:self.killSellLabel];
        [self.killSellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_whiteView.mas_bottom);
            make.right.mas_equalTo(_whiteView.mas_left).offset(-8);
        }];
        
        
        [self.backView addSubview:self.killPriceLabel];
        [self.killPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_killBuyLabel.mas_top);
            make.left.mas_equalTo(_killTitleLabel.mas_left);
        }];
        
        [self.backView addSubview:self.killMarketprice];
        [self.killMarketprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_killSellLabel.mas_top);
            make.left.mas_equalTo(_killPriceLabel.mas_left);
        }];

    }
    return self;
}

- (void)setSecondsKillModel:(SecondsKillModel *)secondsKillModel{
    _secondsKillModel = secondsKillModel;
    [self.killImageView setYy_imageURL:[NSURL URLWithString:_secondsKillModel.thumb]];
    [self.killTitleLabel setText:_secondsKillModel.title];
    [self.killPriceLabel setText:[NSString stringWithFormat:@"¥%@",_secondsKillModel.price]];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_secondsKillModel.marketprice] attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    _killMarketprice.attributedText = attribtStr;
    [_killSellLabel setText:[NSString stringWithFormat:@"已售%@%%",_secondsKillModel.percent]];
    inter = [_secondsKillModel.percent integerValue]*0.01*80;
    
    [self.redLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(inter);
    }];
    
    [self.redLabel layoutIfNeeded];
    
}


#pragma mark - lazy
- (UIImageView *)killImageView{
    if (!_killImageView) {
        _killImageView = [[UIImageView alloc]init];
    }
    return _killImageView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:[UIColor whiteColor]];
        [_backView.layer setMasksToBounds:YES];
        [_backView.layer setCornerRadius:10];
    }
    return _backView;
}
- (UILabel *)killTitleLabel{
    if (!_killTitleLabel) {
        _killTitleLabel = [[UILabel alloc]init];
        [_killTitleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_killTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_killTitleLabel setFont:KFont(15)];
        _killTitleLabel.numberOfLines = 0;
        
    }
    return _killTitleLabel;
}
- (UILabel *)killPriceLabel{
    if(!_killPriceLabel){
        _killPriceLabel = [[UILabel alloc]init];
        [_killPriceLabel setTextColor:KRedColor];
        [_killPriceLabel setFont:KFont(20)];
    }
    
    return _killPriceLabel;
}
- (UILabel *)killMarketprice{
    if(!_killMarketprice){
        _killMarketprice = [[UILabel alloc]init];
        [_killMarketprice setTextColor:KUIColorFromHex(0x666666)];
        [_killMarketprice setFont:KFont(12)];
    }
    
    return _killMarketprice;
}

- (UILabel *)killSellLabel{
    if(!_killSellLabel){
        _killSellLabel = [[UILabel alloc]init];
        _killSellLabel.backgroundColor = [UIColor clearColor];
        [_killSellLabel setTextColor:KUIColorFromHex(0x999999)];
        [_killSellLabel setFont:KFont(11)];
        _killSellLabel.textAlignment = kCTTextAlignmentRight;
    }
    
    return _killSellLabel;
}
- (UILabel *)killBuyLabel{
    if(!_killBuyLabel){
        _killBuyLabel = [[UILabel alloc]init];
        [_killBuyLabel setTextColor:[UIColor whiteColor]];
        [_killBuyLabel setFont:KFont(15)];
        _killBuyLabel.textAlignment = NSTextAlignmentCenter;
        [_killBuyLabel.layer addSublayer:[self backgroundLayer]];
        _killBuyLabel.text = @"去抢购";
    }
    return _killBuyLabel;
}

- (CAGradientLayer *)backgroundLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 80, 28);
    gradientLayer.colors = @[(__bridge id)KUIColorFromHex(0xfc3030).CGColor,(__bridge id)KUIColorFromHex(0xf08d66).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.cornerRadius = 14;
    return gradientLayer;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.borderColor = KUIColorFromHex(0xff9191).CGColor;
        _whiteView.layer.borderWidth = 0.5f;
        _whiteView.layer.cornerRadius = 5;
        _whiteView.clipsToBounds = YES;
    }
    return _whiteView;
}
- (UILabel *)redLabel{
    if(!_redLabel){
        _redLabel = [[UILabel alloc]init];
        _redLabel.layer.backgroundColor = KUIColorFromHex(0xff9191).CGColor;

    }
    
    return _redLabel;
}

@end
