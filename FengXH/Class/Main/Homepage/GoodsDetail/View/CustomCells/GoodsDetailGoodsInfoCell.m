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


@interface GoodsDetailGoodsInfoCell ()<SDCycleScrollViewDelegate>

/** 商品图片轮播图 */
@property(nonatomic , strong)SDCycleScrollView *bannerScrollView;
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

@end

@implementation GoodsDetailGoodsInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.bannerScrollView];
        
        [self.contentView addSubview:self.pruductPriceLabel];
        [self.pruductPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bannerScrollView.mas_bottom).offset(15);
            make.left.mas_offset(15);
        }];
        
        [self.contentView addSubview:self.marketPriceLabel];
        [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_pruductPriceLabel.mas_right).offset(5);
            make.bottom.mas_equalTo(_pruductPriceLabel.mas_bottom).offset(-3);
        }];
        
        [self.contentView addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_pruductPriceLabel.mas_bottom);
            make.right.mas_offset(-0);
            make.width.height.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_pruductPriceLabel.mas_left);
            make.right.mas_equalTo(_shareButton.mas_left).offset(-0);
            make.top.mas_equalTo(_pruductPriceLabel.mas_bottom);
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
            make.left.mas_equalTo(_pruductPriceLabel.mas_left);
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
    //商品原价
    [self.pruductPriceLabel setText:[NSString stringWithFormat:@"¥%@",_goodsDetailResultModel.marketprice]];
    //商品现价
    NSMutableAttributedString *marketPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",_goodsDetailResultModel.productprice]];
    [marketPriceString addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, marketPriceString.length)];
    [self.marketPriceLabel setAttributedText:marketPriceString];
    //商品名称
    [self.goodsNameLabel setText:_goodsDetailResultModel.title];
    //小标题
    [self.subTitleLabel setText:_goodsDetailResultModel.subtitle];
    //销量
    [self.salesLabel setText:[NSString stringWithFormat:@"销量：%ld %@",(long)_goodsDetailResultModel.sales,/*_goodsDetailResultModel.unit*/@"件"]];
    
    
}



#pragma mark - lazy

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
    }
    return _marketPriceLabel;
}

- (UILabel *)pruductPriceLabel {
    if (!_pruductPriceLabel) {
        _pruductPriceLabel = [[UILabel alloc] init];
        [_pruductPriceLabel setTextColor:KRedColor];
        [_pruductPriceLabel setFont:[UIFont boldSystemFontOfSize:24]];
    }
    return _pruductPriceLabel;
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
