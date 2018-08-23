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
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.killImageView];
        [self.killImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_offset(8);
                make.bottom.mas_offset(-8);
                make.width.mas_equalTo(100);
        }];
        
        [self addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(2);
        }];
        
        [self addSubview:self.killTitleLabel];
        [self.killTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8);
            make.right.mas_offset(-8);
            make.left.mas_equalTo(self.killImageView.mas_right).offset(8);
            make.height.mas_equalTo(40);
        }];
        
        [self addSubview:self.killPriceLabel];
        [self.killPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.killTitleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.killImageView.mas_right).offset(8);
            make.height.mas_equalTo(25);
        }];
        
        [self addSubview:self.killMarketprice];
        [self.killMarketprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.killTitleLabel.mas_bottom).offset(13);
            make.left.mas_equalTo(self.killPriceLabel.mas_right).offset(8);
            make.height.mas_equalTo(20);
        }];
        
        
        
        [self addSubview:self.killBuyLabel];
        [self.killBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-23);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(33);
        }];
        

        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.killImageView.mas_right).offset(100);
            make.bottom.mas_offset(-10);
            make.width.mas_equalTo(155*KScreenRatio);
            make.height.mas_equalTo(7);
        }];
        [self.whiteView addSubview:self.redLabel];
        [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.left.mas_offset(0);
            make.width.mas_equalTo(130*KScreenRatio);
            make.height.mas_equalTo(7);
        }];
        [self addSubview:self.killSellLabel];
        [self.killSellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-8);
            make.left.mas_equalTo(self.killImageView.mas_right).offset(8);
            make.height.mas_equalTo(20);
        }];

    }
    return self;
}

- (UIImageView *)killImageView{
    if (!_killImageView) {
        _killImageView = [[UIImageView alloc]init];
        
    }
    return _killImageView;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = KTableBackgroundColor;
        
    }
    return _backView;
}
- (UILabel *)killTitleLabel{
    if (!_killTitleLabel) {
        _killTitleLabel = [[UILabel alloc]init];
        [_killTitleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_killTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_killTitleLabel setFont:KFont(13)];
        _killTitleLabel.numberOfLines = 0;
        
    }
    return _killTitleLabel;
}
- (UILabel *)killPriceLabel{
    if(!_killPriceLabel){
        _killPriceLabel = [[UILabel alloc]init];
        
        [_killPriceLabel setTextColor:KUIColorFromHex(0xff463c)];
        [_killTitleLabel setFont:KFont(15)];
        _killPriceLabel.textAlignment = kCTTextAlignmentLeft;
    }
    
    return _killPriceLabel;
}
- (UILabel *)killMarketprice{
    if(!_killMarketprice){
        _killMarketprice = [[UILabel alloc]init];
        _killMarketprice.backgroundColor = [UIColor clearColor];
        [_killMarketprice setTextColor:KUIColorFromHex(0x666666)];
        [_killMarketprice setFont:KFont(10)];
        _killMarketprice.textAlignment = kCTTextAlignmentLeft;
    }
    
    return _killMarketprice;
}

- (UILabel *)killSellLabel{
    if(!_killSellLabel){
        _killSellLabel = [[UILabel alloc]init];
        _killSellLabel.backgroundColor = [UIColor clearColor];
        [_killSellLabel setTextColor:KUIColorFromHex(0x666666)];
        [_killSellLabel setFont:KFont(11)];
        _killSellLabel.textAlignment = kCTTextAlignmentRight;
    }
    
    return _killSellLabel;
}
- (UILabel *)killBuyLabel{
    if(!_killBuyLabel){
        _killBuyLabel = [[UILabel alloc]init];
//        _killBuyLabel.backgroundColor = KUIColorFromHex(0xff463c);
        [_killBuyLabel setTextColor:[UIColor whiteColor]];
        [_killBuyLabel setFont:KFont(15)];
        _killBuyLabel.textAlignment = NSTextAlignmentCenter;
        _killBuyLabel.layer.backgroundColor = KUIColorFromHex(0xff463c).CGColor;
        _killBuyLabel.layer.cornerRadius = 7;
        _killBuyLabel.text = @"去抢购";
    }
    
    return _killBuyLabel;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.borderColor = KUIColorFromHex(0xff463c).CGColor;
        _whiteView.layer.borderWidth = 0.5f;
        _whiteView.layer.cornerRadius = 5;
        _whiteView.clipsToBounds = YES;
    }
    return _whiteView;
}
- (UILabel *)redLabel{
    if(!_redLabel){
        _redLabel = [[UILabel alloc]init];
        _redLabel.layer.backgroundColor = KUIColorFromHex(0xff463c).CGColor;

    }
    
    return _redLabel;
}
- (void)setSecondsKillModel:(SecondsKillModel *)secondsKillModel{
    _secondsKillModel = secondsKillModel;
    [self.killImageView setYy_imageURL:[NSURL URLWithString:_secondsKillModel.thumb]];
    [self.killTitleLabel setText:_secondsKillModel.title];
    [self.killPriceLabel setText:[NSString stringWithFormat:@"¥%@",_secondsKillModel.price]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_secondsKillModel.marketprice] attributes:attribtDic];
    _killMarketprice.attributedText = attribtStr;
    [_killSellLabel setText:[NSString stringWithFormat:@"已售%@%%",_secondsKillModel.percent]];
    inter = [_secondsKillModel.percent integerValue]*0.01*155*KScreenRatio;
    
    [self.redLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(inter);
    }];
    
    [self.redLabel layoutIfNeeded];

    
    
}
@end
