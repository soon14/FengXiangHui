//
//  PersonalThirdCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalThirdCell.h"

@implementation PersonalThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWidth = (KMAINSIZE.width/5);
        
        [self.contentView addSubview:self.waitPayItem];
        [self.waitPayItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.waitSendItem];
        [self.waitSendItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(itemWidth);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.waitReceiveItem];
        [self.waitReceiveItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(itemWidth*2);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.refundingItem];
        [self.refundingItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(itemWidth*3);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.shopCartItem];
        [self.shopCartItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWidth);
        }];
        
    }
    return self;
}

#pragma mark - action
- (void)clickAction:(UITapGestureRecognizer *)sender {
    if (self.cellClickBlock) {
        self.cellClickBlock(sender.view.tag);
    }
}

#pragma mark - lazy
- (PersonalCellItem *)shopCartItem {
    if (!_shopCartItem) {
        _shopCartItem = [[PersonalCellItem alloc] init];
        [_shopCartItem.itemImageView setImage:[UIImage imageNamed:@"Personal_tonghuajilu"]];
        [_shopCartItem.itemTitleLabel setText:@"购物车"];
        [_shopCartItem setTag:4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_shopCartItem addGestureRecognizer:tap];
    }
    return _shopCartItem;
}

- (PersonalCellItem *)refundingItem {
    if (!_refundingItem) {
        _refundingItem = [[PersonalCellItem alloc] init];
        [_refundingItem.itemImageView setImage:[UIImage imageNamed:@"Personal_tonghuajilu"]];
        [_refundingItem.itemTitleLabel setText:@"退换货"];
        [_refundingItem setTag:3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_refundingItem addGestureRecognizer:tap];
    }
    return _refundingItem;
}

- (PersonalCellItem *)waitReceiveItem {
    if (!_waitReceiveItem) {
        _waitReceiveItem = [[PersonalCellItem alloc] init];
        [_waitReceiveItem.itemImageView setImage:[UIImage imageNamed:@"Personal_tonghuajilu"]];
        [_waitReceiveItem.itemTitleLabel setText:@"待收货"];
        [_waitReceiveItem setTag:2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_waitReceiveItem addGestureRecognizer:tap];
    }
    return _waitReceiveItem;
}

- (PersonalCellItem *)waitSendItem {
    if (!_waitSendItem) {
        _waitSendItem = [[PersonalCellItem alloc] init];
        [_waitSendItem.itemImageView setImage:[UIImage imageNamed:@"Personal_tonghuajilu"]];
        [_waitSendItem.itemTitleLabel setText:@"待发货"];
        [_waitSendItem setTag:1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_waitSendItem addGestureRecognizer:tap];
    }
    return _waitSendItem;
}

- (PersonalCellItem *)waitPayItem {
    if (!_waitPayItem) {
        _waitPayItem = [[PersonalCellItem alloc] init];
        [_waitPayItem.itemImageView setImage:[UIImage imageNamed:@"Personal_tonghuajilu"]];
        [_waitPayItem.itemTitleLabel setText:@"待付款"];
        [_waitPayItem setTag:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_waitPayItem addGestureRecognizer:tap];
    }
    return _waitPayItem;
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
