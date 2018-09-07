//
//  ArticleListHeaderView.m
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ArticleListHeaderView.h"

@implementation ArticleListHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat buttonWidth = (self.frame.size.width/5);
        
        [self addSubview:self.allButton];
        [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.welfareButton];
        [self.welfareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_allButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.mouthButton];
        [self.mouthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_welfareButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.goodButton];
        [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_mouthButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.newsButton];
        [self.newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
       
        
        
        [self addSubview:self.moveLine];
        
    }
    return self;
}


#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.articleTypeBlock) {
        self.articleTypeBlock(sender.tag-9001);
    }
}

#pragma mark - lazy
- (UIView *)moveLine {
    if (!_moveLine) {
        _moveLine = [[UIView alloc]initWithFrame:CGRectMake(12, 40, self.frame.size.width/5-24, 2)];
        [_moveLine setBackgroundColor:KRedColor];
        [_moveLine.layer setMasksToBounds:YES];
        [_moveLine.layer setCornerRadius:1];
    }
    return _moveLine;
}

- (UIButton *)newsButton {
    if (!_newsButton) {
        _newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_newsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_newsButton.titleLabel setFont:KFont(15)];
        [_newsButton setTitle:@"资讯" forState:UIControlStateNormal];
        [_newsButton setTag:9005];
        [_newsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newsButton;
}

- (UIButton *)goodButton {
    if (!_goodButton) {
        _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_goodButton.titleLabel setFont:KFont(15)];
        [_goodButton setTitle:@"好物" forState:UIControlStateNormal];
        [_goodButton setTag:9004];
        [_goodButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodButton;
}

- (UIButton *)mouthButton {
    if (!_mouthButton) {
        _mouthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mouthButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_mouthButton.titleLabel setFont:KFont(15)];
        [_mouthButton setTitle:@"口碑" forState:UIControlStateNormal];
        [_mouthButton setTag:9003];
        [_mouthButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mouthButton;
}

- (UIButton *)welfareButton {
    if (!_welfareButton) {
        _welfareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_welfareButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_welfareButton.titleLabel setFont:KFont(15)];
        [_welfareButton setTitle:@"福利" forState:UIControlStateNormal];
        [_welfareButton setTag:9002];
        [_welfareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _welfareButton;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allButton setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
        [_allButton.titleLabel setFont:KFont(15)];
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTag:9001];
        [_allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
