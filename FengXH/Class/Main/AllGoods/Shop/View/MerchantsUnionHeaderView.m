//
//  MerchantsUnionHeaderView.m
//  FengXH
//
//  Created by sun on 2018/9/25.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "MerchantsUnionHeaderView.h"

@interface MerchantsUnionHeaderView ()

/** layoutButton */
@property(nonatomic , strong)UIButton *layoutButton;
/** 综合按钮 */
@property(nonatomic , strong)UIButton *synthesizeButton;
/** 销量按钮 */
@property(nonatomic , strong)UIButton *salesButton;
/** 价格按钮 */
@property(nonatomic , strong)UIButton *priceButton;
/** 筛选按钮 */
@property(nonatomic , strong)UIButton *filtrateButton;

@end

@implementation MerchantsUnionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *whiteBackView = [[UIView alloc] init];
        [whiteBackView setBackgroundColor:KUIColorFromHex(0xf1f1f2)];
        [whiteBackView.layer setMasksToBounds:YES];
        [whiteBackView.layer setCornerRadius:5];
        [self addSubview:whiteBackView];
        [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_offset(15);
            make.height.mas_equalTo(25);
            make.right.mas_offset(-55);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(whiteBackView.mas_bottom).offset(10);
            make.height.mas_equalTo(0.5);
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
        
        [self addSubview:self.layoutButton];
        [self.layoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-5);
            make.width.mas_equalTo(45);
            make.centerY.mas_equalTo(_searchTextField.mas_centerY);
            make.height.mas_equalTo(45);
        }];
        
        CGFloat buttonWidth = (KMAINSIZE.width/4);
        
        [self addSubview:self.synthesizeButton];
        [self.synthesizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(45);
        }];
        
        [self addSubview:self.salesButton];
        [self.salesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(buttonWidth);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(45);
        }];
        
        [self addSubview:self.priceButton];
        [self.priceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_salesButton.mas_right);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(45);
        }];
        
        [self addSubview:self.filtrateButton];
        [self.filtrateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(45);
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        [bottomLine setBackgroundColor:KLineColor];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}


#pragma mark - layoutButtonAction
- (void)buttonAction:(UIButton *)sender {
    if (sender == self.layoutButton) {
        if (self.headerViewBlock) {
            self.headerViewBlock(sender.selected ? 1001 : 1002);
        }
        sender.selected = !sender.selected;
    } else if (sender == self.synthesizeButton) {
        if (self.headerViewBlock) {
            self.headerViewBlock(1003);
        }
        [self.synthesizeButton setTitleColor:KUIColorFromHex(0xfe525e) forState:UIControlStateNormal];
        [self.salesButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.priceButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.filtrateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.priceButton setImage:[UIImage imageNamed:@"price_sort_default"] forState:UIControlStateNormal];
        [self.filtrateButton setImage:[UIImage imageNamed:@"allGoods_filter_default"] forState:UIControlStateNormal];
    } else if (sender == self.salesButton) {
        if (self.headerViewBlock) {
            self.headerViewBlock(1004);
        }
        [self.synthesizeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.salesButton setTitleColor:KUIColorFromHex(0xfe525e) forState:UIControlStateNormal];
        [self.priceButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.filtrateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.priceButton setImage:[UIImage imageNamed:@"price_sort_default"] forState:UIControlStateNormal];
        [self.filtrateButton setImage:[UIImage imageNamed:@"allGoods_filter_default"] forState:UIControlStateNormal];
    } else if (sender == self.priceButton) {
        if (self.headerViewBlock) {
            self.headerViewBlock(!sender.selected ? 1005 : 1006);
        }
        sender.selected = !sender.selected;
        [self.synthesizeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.salesButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.priceButton setTitleColor:KUIColorFromHex(0xfe525e) forState:UIControlStateNormal];
        [self.filtrateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.filtrateButton setImage:[UIImage imageNamed:@"allGoods_filter_default"] forState:UIControlStateNormal];
        if (sender.selected) {
            [self.priceButton setImage:[UIImage imageNamed:@"price_sort_asc"] forState:UIControlStateNormal];
        } else {
            [self.priceButton setImage:[UIImage imageNamed:@"price_sort_desc"] forState:UIControlStateNormal];
        }
    } else if (sender == self.filtrateButton) {
        if (self.headerViewBlock) {
            self.headerViewBlock(1007);
        }
        [self.synthesizeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.salesButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.priceButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [self.filtrateButton setTitleColor:KUIColorFromHex(0xfe525e) forState:UIControlStateNormal];
        [self.priceButton setImage:[UIImage imageNamed:@"price_sort_default"] forState:UIControlStateNormal];
        [self.filtrateButton setImage:[UIImage imageNamed:@"allGoods_filter_select"] forState:UIControlStateNormal];
    }
}

#pragma mark - lazy
- (UIButton *)filtrateButton {
    if (!_filtrateButton) {
        _filtrateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_filtrateButton setTitle:@"筛选" forState:UIControlStateNormal];
        [_filtrateButton setImage:[UIImage imageNamed:@"allGoods_filter_default"] forState:UIControlStateNormal];
        [_filtrateButton setImage:[UIImage imageNamed:@"allGoods_filter_select"] forState:UIControlStateSelected];
        [_filtrateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [_filtrateButton setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, -35)];
        [_filtrateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_filtrateButton.titleLabel setFont:KFont(14)];
        [_filtrateButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filtrateButton;
}

- (UIButton *)priceButton {
    if (!_priceButton) {
        _priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
        [_priceButton setImage:[UIImage imageNamed:@"price_sort_default"] forState:UIControlStateNormal];
        [_priceButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
        [_priceButton setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, -35)];
        [_priceButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_priceButton.titleLabel setFont:KFont(14)];
        [_priceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceButton;
}

- (UIButton *)salesButton {
    if (!_salesButton) {
        _salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_salesButton setTitle:@"销量" forState:UIControlStateNormal];
        [_salesButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_salesButton.titleLabel setFont:KFont(14)];
        [_salesButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _salesButton;
}

- (UIButton *)synthesizeButton {
    if (!_synthesizeButton) {
        _synthesizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_synthesizeButton setTitle:@"综合" forState:UIControlStateNormal];
        [_synthesizeButton setTitleColor:KUIColorFromHex(0xfe525e) forState:UIControlStateNormal];
        [_synthesizeButton.titleLabel setFont:KFont(14)];
        [_synthesizeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _synthesizeButton;
}

- (UIButton *)layoutButton {
    if (!_layoutButton) {
        _layoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_layoutButton setImage:[UIImage imageNamed:@"listLayout"] forState:UIControlStateNormal];
        [_layoutButton setImage:[UIImage imageNamed:@"collectionLayout"] forState:UIControlStateSelected];
        [_layoutButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _layoutButton;
}

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
