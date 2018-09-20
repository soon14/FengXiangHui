//
//  GoodsDetailOptionsSelectCell.m
//  FengXH
//
//  Created by sun on 2018/9/20.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailOptionsSelectCell.h"
#import "GoodsDetailResultModel.h"

@interface GoodsDetailOptionsSelectCell ()

/** titleLabel */
@property(nonatomic , strong)UILabel *titleLabel;

@end

@implementation GoodsDetailOptionsSelectCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setOptionsModel:(GoodsDetailResultOptionsModel *)optionsModel {
    _optionsModel = optionsModel;
    [self.titleLabel setText:_optionsModel.title];
    if (_optionsModel.selected) {
        [self.titleLabel setBackgroundColor:KUIColorFromHex(0xffe9e9)];
        [self.titleLabel.layer setBorderColor:KRedColor.CGColor];
        [self.titleLabel setTextColor:KRedColor];
    } else {
        [self.titleLabel setBackgroundColor:KTableBackgroundColor];
        [self.titleLabel.layer setBorderColor:KTableBackgroundColor.CGColor];
        [self.titleLabel setTextColor:KUIColorFromHex(0x333333)];
    }
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:KTableBackgroundColor];
        [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_titleLabel setFont:KFont(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel.layer setMasksToBounds:YES];
        [_titleLabel.layer setCornerRadius:15];
        [_titleLabel.layer setBorderColor:KTableBackgroundColor.CGColor];
        [_titleLabel.layer setBorderWidth:1];
    }
    return _titleLabel;
}

@end
