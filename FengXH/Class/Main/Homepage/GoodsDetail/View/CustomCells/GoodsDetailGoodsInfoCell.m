//
//  GoodsDetailGoodsInfoCell.m
//  FengXH
//
//  Created by sun on 2018/9/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailGoodsInfoCell.h"
#import "GoodsDetailResultModel.h"
#import "SDCycleScrollView.h"
#import "ZQCountDownView.h"

@interface GoodsDetailGoodsInfoCell ()<SDCycleScrollViewDelegate>

/** 商品图片轮播图 */
@property(nonatomic , strong)SDCycleScrollView *bannerScrollView;
/** 非秒杀商品的价格 View */
@property(nonatomic , strong)UIView *priceView;
/** 原价价格 */
@property(nonatomic , strong)UILabel *pruductPriceLabel;
/** 现价 */
@property(nonatomic , strong)UILabel *marketPriceLabel;
/** 分享 */
@property(nonatomic , strong)UIButton *shareButton;
/** 商品名称 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 小标题 */
@property(nonatomic , strong)UILabel *subTitleLabel;
/** 销量 */
@property(nonatomic , strong)UILabel *salesLabel;

/** 倒计时背景 View */
@property(nonatomic , strong)UIView *seckillTimeBackView;
/** 价格进度条背景 */
@property(nonatomic , strong)UIView *seckillPriceBackView;
/** 倒计时模块 */
@property(nonatomic , strong)ZQCountDownView *seckillCountDownView;
/** 秒杀商品现价 */
@property(nonatomic , strong)UILabel *seckillMarketPriceLabel;
/** 秒杀商品进度条 */
@property(nonatomic , strong)UIView *seckillProcessView;
/** 进度百分比 */
@property(nonatomic , strong)UILabel *seckillPercentLabel;
/** 秒杀商品原价 */
@property(nonatomic , strong)UILabel *seckillPruductPriceLabel;

@end

@implementation GoodsDetailGoodsInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.bannerScrollView];
        
//        [self.priceView setBackgroundColor:[UIColor orangeColor]];
        [self.contentView addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bannerScrollView.mas_bottom);
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(45);
        }];
        
        
        //普通商品的现价、原价
        [self.priceView addSubview:self.pruductPriceLabel];
        [self.pruductPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.left.mas_offset(15);
        }];

        [self.priceView addSubview:self.marketPriceLabel];
        [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_pruductPriceLabel.mas_right).offset(5);
            make.bottom.mas_equalTo(_pruductPriceLabel.mas_bottom).offset(-3);
        }];
        
        //秒杀商品
        [self.priceView addSubview:self.seckillTimeBackView];
        [self.seckillTimeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_offset(0);
            make.width.mas_equalTo(100);
        }];
        
        [self.priceView addSubview:self.seckillPriceBackView];
        [self.seckillPriceBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_offset(0);
            make.width.mas_equalTo(KMAINSIZE.width-100);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KRedColor];
        [label setText:@"距结束还剩:"];
        [label setFont:KFont(12)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.seckillTimeBackView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.height.mas_equalTo(20);
            make.centerX.mas_equalTo(_seckillTimeBackView.mas_centerX);
        }];
        
        [self.seckillTimeBackView addSubview:self.seckillCountDownView];
        
        //秒杀商品价格
        [self.seckillPriceBackView addSubview:self.seckillMarketPriceLabel];
        [self.seckillMarketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(10);
            make.height.mas_equalTo(30);
        }];
        
        //秒杀商品进度条
        UIView *processBackView = [[UIView alloc] init];
        [processBackView.layer setMasksToBounds:YES];
        [processBackView.layer setCornerRadius:7];
        [processBackView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [processBackView.layer setBorderWidth:1];
        [self.seckillPriceBackView addSubview:processBackView];
        [processBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_seckillMarketPriceLabel.mas_left);
            make.top.mas_equalTo(_seckillMarketPriceLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(70);
        }];
        
        [processBackView addSubview:self.seckillProcessView];
        [self.seckillProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_offset(0);
        }];
        
        //秒杀商品百分比
        [self.seckillPriceBackView addSubview:self.seckillPercentLabel];
        [self.seckillPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(processBackView.mas_right).offset(15);
            make.centerY.mas_equalTo(processBackView.mas_centerY);
        }];
        
        //秒杀商品原价
        [self.seckillPriceBackView addSubview:self.seckillPruductPriceLabel];
        [self.seckillPruductPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_seckillPercentLabel.mas_right).offset(10);
            make.centerY.mas_equalTo(_seckillPercentLabel.mas_centerY);
        }];
        
        
        [self.contentView addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_priceView.mas_bottom);
            make.right.mas_offset(-0);
            make.width.height.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.right.mas_equalTo(_shareButton.mas_left).offset(-0);
            make.top.mas_equalTo(_priceView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.salesLabel];
        [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.top.mas_equalTo(_goodsNameLabel.mas_bottom);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsNameLabel.mas_left);
            make.centerY.mas_equalTo(_salesLabel.mas_centerY);
            make.right.mas_equalTo(_salesLabel.mas_left).offset(-10);
        }];
        
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailGoodsInfoCell:shareAction:)]) {
        [self.delegate GoodsDetailGoodsInfoCell:self shareAction:sender];
    }
}


- (void)setGoodsDetailResultModel:(GoodsDetailResultModel *)goodsDetailResultModel {
    _goodsDetailResultModel = goodsDetailResultModel;
    //商品图
    [self.bannerScrollView setImageURLStringsGroup:_goodsDetailResultModel.thumb_url];
    if (_goodsDetailResultModel.seckillinfo) {
        //秒杀商品
        [self.priceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(70);
        }];
        [self.seckillTimeBackView setHidden:NO];
        [self.seckillPriceBackView setHidden:NO];
        //倒计时
        NSDate *datenow = [NSDate date];
        NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
        NSInteger integer = [_goodsDetailResultModel.seckillinfo.endtime integerValue] - timeSp;
        [self.seckillCountDownView setCountDownTimeInterval:integer];
        //商品现价
        [self.seckillMarketPriceLabel setText:[NSString stringWithFormat:@"¥%.2lf",[_goodsDetailResultModel.seckillinfo.price floatValue]]];
        //进度条
        NSInteger inter = [_goodsDetailResultModel.seckillinfo.percent integerValue]*0.01*70;
        [self.seckillProcessView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(inter);
        }];
        //百分比
        [self.seckillPercentLabel setText:[NSString stringWithFormat:@"%ld%%",[_goodsDetailResultModel.seckillinfo.percent integerValue]]];
        //原价
        NSMutableAttributedString *pruductPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2lf",[_goodsDetailResultModel.seckillinfo.oldprice floatValue]]];
        [pruductPriceString addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, pruductPriceString.length)];
        [self.seckillPruductPriceLabel setAttributedText:pruductPriceString];
    } else {
        //普通商品
        [self.pruductPriceLabel setHidden:NO];
        [self.marketPriceLabel setHidden:NO];
        //商品现价
        [self.pruductPriceLabel setText:[NSString stringWithFormat:@"¥%.2lf",[_goodsDetailResultModel.marketprice floatValue]]];
        //商品原价
        NSMutableAttributedString *marketPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2lf",[_goodsDetailResultModel.productprice floatValue]]];
        [marketPriceString addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, marketPriceString.length)];
        [self.marketPriceLabel setAttributedText:marketPriceString];
    }
    //商品名称
    [self.goodsNameLabel setText:_goodsDetailResultModel.title];
    //小标题
    [self.subTitleLabel setText:_goodsDetailResultModel.subtitle];
    //销量
    [self.salesLabel setText:[NSString stringWithFormat:@"销量：%ld %@",(long)_goodsDetailResultModel.sales,/*_goodsDetailResultModel.unit*/@"件"]];
}



#pragma mark - lazy
- (UILabel *)seckillPruductPriceLabel {
    if (!_seckillPruductPriceLabel) {
        _seckillPruductPriceLabel = [[UILabel alloc] init];
        [_seckillPruductPriceLabel setTextColor:[UIColor whiteColor]];
        [_seckillPruductPriceLabel setFont:KFont(14)];
    }
    return _seckillPruductPriceLabel;
}

- (UILabel *)seckillPercentLabel {
    if (!_seckillPercentLabel) {
        _seckillPercentLabel = [[UILabel alloc] init];
        [_seckillPercentLabel setTextColor:[UIColor whiteColor]];
        [_seckillPercentLabel setFont:KFont(14)];
    }
    return _seckillPercentLabel;
}

- (UIView *)seckillProcessView {
    if (!_seckillProcessView) {
        _seckillProcessView = [[UIView alloc] init];
        [_seckillProcessView setBackgroundColor:KUIColorFromHex(0xfff722)];
    }
    return _seckillProcessView;
}

- (UILabel *)seckillMarketPriceLabel {
    if (!_seckillMarketPriceLabel) {
        _seckillMarketPriceLabel = [[UILabel alloc] init];
        [_seckillMarketPriceLabel setTextColor:[UIColor whiteColor]];
        [_seckillMarketPriceLabel setFont:[UIFont boldSystemFontOfSize:24]];
    }
    return _seckillMarketPriceLabel;
}

- (ZQCountDownView *)seckillCountDownView {
    if (!_seckillCountDownView) {
        _seckillCountDownView = [[ZQCountDownView alloc] initWithFrame:CGRectMake(10, 30, 80, 30)];
        _seckillCountDownView.themeColor = KRedColor;
        _seckillCountDownView.textColor = [UIColor whiteColor];
        _seckillCountDownView.textFont = KFont(12);
    }
    return _seckillCountDownView;
}

- (UIView *)seckillPriceBackView {
    if (!_seckillPriceBackView) {
        _seckillPriceBackView = [[UIView alloc] init];
        [_seckillPriceBackView.layer addSublayer:[self backgroundLayer]];
        [_seckillPriceBackView setHidden:YES];
    }
    return _seckillPriceBackView;
}

- (CAGradientLayer *)backgroundLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, KMAINSIZE.width-100, 70);
    gradientLayer.colors = @[(__bridge id)KUIColorFromHex(0xf08d66).CGColor,(__bridge id)KUIColorFromHex(0xfc3030).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    return gradientLayer;
}

- (UIView *)seckillTimeBackView {
    if (!_seckillTimeBackView) {
        _seckillTimeBackView = [[UIView alloc] init];
        [_seckillTimeBackView setBackgroundColor:[UIColor whiteColor]];
        [_seckillTimeBackView setHidden:YES];
    }
    return _seckillTimeBackView;
}

- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        [_salesLabel setTextColor:KUIColorFromHex(0x999999)];
        [_salesLabel setFont:KFont(13)];
        [_salesLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _salesLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setTextColor:KUIColorFromHex(0x999999)];
        [_subTitleLabel setFont:KFont(13)];
    }
    return _subTitleLabel;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"goodsDetailShare"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(15)];
        [_goodsNameLabel setNumberOfLines:2];
    }
    return _goodsNameLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        _marketPriceLabel = [[UILabel alloc] init];
        [_marketPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_marketPriceLabel setFont:KFont(12)];
        [_marketPriceLabel setHidden:YES];
    }
    return _marketPriceLabel;
}

- (UILabel *)pruductPriceLabel {
    if (!_pruductPriceLabel) {
        _pruductPriceLabel = [[UILabel alloc] init];
        [_pruductPriceLabel setTextColor:KRedColor];
        [_pruductPriceLabel setFont:[UIFont boldSystemFontOfSize:24]];
        [_pruductPriceLabel setHidden:YES];
    }
    return _pruductPriceLabel;
}

- (UIView *)priceView {
    if (!_priceView) {
        _priceView = [[UIView alloc] init];
    }
    return _priceView;
}

- (SDCycleScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 360*KScreenRatio) delegate:self placeholderImage:nil];
        _bannerScrollView.backgroundColor = [UIColor whiteColor];
        _bannerScrollView.currentPageDotColor = KRedColor;
    }
    return _bannerScrollView;
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
