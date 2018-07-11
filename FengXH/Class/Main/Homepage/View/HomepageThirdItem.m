//
//  HomepageSecondCellItem.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageThirdItem.h"

@implementation HomepageThirdItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.itemImageView];
        [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.height.mas_equalTo(45);
        }];
        
        [self addSubview:self.itemTitleLabel];
        [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.itemImageView.mas_bottom).offset(15);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }
    return self;
}


#pragma mark - lazy
- (UILabel *)itemTitleLabel {
    if (!_itemTitleLabel) {
        _itemTitleLabel = [[UILabel alloc] init];
        [_itemTitleLabel setTextColor:KUIColorFromHex(0x666666)];
        [_itemTitleLabel setFont:KFont(13)];
        [_itemTitleLabel setTextAlignment:NSTextAlignmentCenter];
//        [_itemTitleLabel setText:@"全部秒杀"];
    }
    return _itemTitleLabel;
}

- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
//        [_itemImageView setBackgroundColor:];
    }
    return _itemImageView;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
