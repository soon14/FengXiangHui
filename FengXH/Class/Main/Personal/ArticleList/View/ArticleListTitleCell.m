//
//  ArticleListTitleCell.m
//  scrollDemo
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ArticleListTitleCell.h"

@interface ArticleListTitleCell ()

/** titleLabel */
@property(nonatomic , strong)UILabel *titleLabel;

@end

@implementation ArticleListTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self.titleLabel setTextColor:KRedColor];
    } else {
        [self.titleLabel setTextColor:KUIColorFromHex(0x999999)];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.frame;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleLabel setText:_title];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        [_titleLabel setTextColor:KUIColorFromHex(0x999999)];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

@end
