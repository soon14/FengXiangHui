//
//  HomepageFirstCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageFirstCell.h"

@implementation HomepageFirstCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KUIColorFromHex(0xf1f1f2);
        
        UIView *whiteBackView = [[UIView alloc] init];
        [whiteBackView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:whiteBackView];
        [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.right.mas_offset(-10);
        }];
        
        UIImageView *searchImageView = [[UIImageView alloc] init];
        [searchImageView setImage:[UIImage imageNamed:@"home_search"]];
        [whiteBackView addSubview:searchImageView];
        [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(7);
            make.centerY.mas_equalTo(whiteBackView.mas_centerY);
            make.width.height.mas_equalTo(17);
        }];
        
        [whiteBackView addSubview:self.searchTextField];
        [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_equalTo(searchImageView.mas_right).offset(6);
            make.right.mas_offset(-11);
        }];
        
    }
    return self;
}

#pragma mark - lazy
- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        [_searchTextField setFont:KFont(15)];
        [_searchTextField setPlaceholder:@"请输入关键字进行搜索"];
        [_searchTextField setReturnKeyType:UIReturnKeySearch];
    }
    return _searchTextField;
}

@end
