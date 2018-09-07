//
//  ArticleListContentCell.m
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ArticleListContentCell.h"
#import "BaseCornerShadowView.h"
#import "ArticelListResultModel.h"

@interface ArticleListContentCell ()

/** backView */
@property(nonatomic , strong)BaseCornerShadowView *backView;
/** 图片 */
@property(nonatomic , strong)UIImageView *articleImageV;
/** 分类名 */
@property(nonatomic , strong)UILabel *categoryNameLabel;
/** 标题 */
@property(nonatomic , strong)UILabel *articleTitleLabel;
/** 内容 */
@property(nonatomic , strong)UILabel *articleContentLabel;
/** 时间 */
@property(nonatomic , strong)UILabel *articleTimeLabel;
/** 积分 */
@property(nonatomic , strong)UIButton *integralButton;

@end

@implementation ArticleListContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.right.mas_offset(-10);
        }];
        
        [self.backView addSubview:self.articleImageV];
        [self.articleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.height.mas_equalTo(100);
            make.centerY.mas_equalTo(self.backView.mas_centerY);
        }];
        
        [self.backView addSubview:self.categoryNameLabel];
        [self.categoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(11);
            make.left.mas_equalTo(_articleImageV.mas_right).offset(10);
        }];
        
        [self.backView addSubview:self.articleTitleLabel];
        [self.articleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_categoryNameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_categoryNameLabel.mas_left);
            make.right.mas_offset(-10);
        }];
        
        [self.backView addSubview:self.articleContentLabel];
        [self.articleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_articleTitleLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_categoryNameLabel.mas_left);
            make.right.mas_offset(-10);
        }];
        
        [self.backView addSubview:self.articleTimeLabel];
        [self.articleTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_articleTitleLabel.mas_left);
            make.bottom.mas_equalTo(_articleImageV.mas_bottom);
        }];
        
        [self.backView addSubview:self.integralButton];
        [self.integralButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.bottom.mas_offset(-12);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)setArticleListModel:(ArticelListResultArticlesListModel *)articleListModel {
    _articleListModel = articleListModel;
    [self.articleImageV setYy_imageURL:[NSURL URLWithString:_articleListModel.resp_img]];
    [self.categoryNameLabel setText:_articleListModel.category_name];
    [self.articleTitleLabel setText:_articleListModel.article_title];
    [self.articleContentLabel setText:_articleListModel.resp_desc];
    [self.articleTimeLabel setText:_articleListModel.article_date_v];
    [self.integralButton setTitle:[NSString stringWithFormat:@"+%@ 积分",_articleListModel.article_rule_credit] forState:UIControlStateNormal];
}


#pragma mark - lazy
- (UIButton *)integralButton {
    if (!_integralButton) {
        _integralButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_integralButton setBackgroundColor:KRedColor];
        [_integralButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_integralButton.titleLabel setFont:KFont(13)];
        [_integralButton.layer setMasksToBounds:YES];
        [_integralButton.layer setCornerRadius:10];
    }
    return _integralButton;
}

- (UILabel *)articleTimeLabel {
    if (!_articleTimeLabel) {
        _articleTimeLabel = [[UILabel alloc] init];
        [_articleTimeLabel setTextColor:KUIColorFromHex(0x999999)];
        [_articleTimeLabel setFont:KFont(11)];
    }
    return _articleTimeLabel;
}

- (UILabel *)articleContentLabel {
    if (!_articleContentLabel) {
        _articleContentLabel = [[UILabel alloc] init];
        [_articleContentLabel setTextColor:KUIColorFromHex(0x999999)];
        [_articleContentLabel setFont:KFont(13)];
        [_articleContentLabel setNumberOfLines:2];
    }
    return _articleContentLabel;
}

- (UILabel *)articleTitleLabel {
    if (!_articleTitleLabel) {
        _articleTitleLabel = [[UILabel alloc] init];
        [_articleTitleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_articleTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    return _articleTitleLabel;
}

- (UILabel *)categoryNameLabel {
    if (!_categoryNameLabel) {
        _categoryNameLabel = [[UILabel alloc] init];
        [_categoryNameLabel setTextColor:KUIColorFromHex(0xff9a9a)];
        [_categoryNameLabel setFont:[UIFont boldSystemFontOfSize:18]];
    }
    return _categoryNameLabel;
}

- (UIImageView *)articleImageV {
    if (!_articleImageV) {
        _articleImageV = [[UIImageView alloc] init];
        [_articleImageV setContentMode:UIViewContentModeScaleAspectFill];
        [_articleImageV setBackgroundColor:KTableBackgroundColor];
    }
    return _articleImageV;
}

- (BaseCornerShadowView *)backView {
    if (!_backView) {
        _backView = [[BaseCornerShadowView alloc] init];
    }
    return _backView;
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
