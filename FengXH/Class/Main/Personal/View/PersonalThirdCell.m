//
//  PersonalThirdCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalThirdCell.h"
#import "PersonalCellItem.h"
#import "PersonalDataModel.h"

@interface PersonalThirdCell ()

/** 待付款 */
@property(nonatomic , strong)PersonalCellItem *waitPayItem;
/** 待发货 */
@property(nonatomic , strong)PersonalCellItem *waitSendItem;
/** 待收货 */
@property(nonatomic , strong)PersonalCellItem *waitReceiveItem;
/** 退换货 */
@property(nonatomic , strong)PersonalCellItem *refundingItem;
/** 购物车 */
@property(nonatomic , strong)PersonalCellItem *shopCartItem;

@end

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

- (void)setStaticsModel:(PersonalDataStaticsModel *)staticsModel {
    _staticsModel = staticsModel;
    //待付款
    if (_staticsModel.order_0 > 0 && _staticsModel.order_0 < 20) {
        [self.waitPayItem.badgeLabel setHidden:NO];
        [self.waitPayItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_0]];
    } else if (_staticsModel.order_0 >= 20 && _staticsModel.order_0 < 100) {
        [self.waitPayItem.badgeLabel setHidden:NO];
        [self.waitPayItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_0]];
    } else if (_staticsModel.order_0 >= 100) {
        [self.waitPayItem.badgeLabel setHidden:NO];
        [self.waitPayItem.badgeLabel setText:[NSString stringWithFormat:@"99+"]];
    } else {
        [self.waitPayItem.badgeLabel setHidden:YES];
    }
    //待发货
    if (_staticsModel.order_1 > 0 && _staticsModel.order_1 < 20) {
        [self.waitSendItem.badgeLabel setHidden:NO];
        [self.waitSendItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_1]];
    } else if (_staticsModel.order_1 >= 20 && _staticsModel.order_1 < 100) {
        [self.waitSendItem.badgeLabel setHidden:NO];
        [self.waitSendItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_1]];
    } else if (_staticsModel.order_1 >= 100) {
        [self.waitSendItem.badgeLabel setHidden:NO];
        [self.waitSendItem.badgeLabel setText:[NSString stringWithFormat:@"99+"]];
    } else {
        [self.waitSendItem.badgeLabel setHidden:YES];
    }
    //待收货
    if (_staticsModel.order_2 > 0 && _staticsModel.order_2 < 20) {
        [self.waitReceiveItem.badgeLabel setHidden:NO];
        [self.waitReceiveItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_2]];
    } else if (_staticsModel.order_2 >= 20 && _staticsModel.order_2 < 100) {
        [self.waitReceiveItem.badgeLabel setHidden:NO];
        [self.waitReceiveItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_2]];
    } else if (_staticsModel.order_2 >= 100) {
        [self.waitReceiveItem.badgeLabel setHidden:NO];
        [self.waitReceiveItem.badgeLabel setText:[NSString stringWithFormat:@"99+"]];
    } else {
        [self.waitReceiveItem.badgeLabel setHidden:YES];
    }
    //退换货
    if (_staticsModel.order_4 > 0 && _staticsModel.order_4 < 20) {
        [self.refundingItem.badgeLabel setHidden:NO];
        [self.refundingItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_4]];
    } else if (_staticsModel.order_4 >= 20 && _staticsModel.order_4 < 100) {
        [self.refundingItem.badgeLabel setHidden:NO];
        [self.refundingItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.order_4]];
    } else if (_staticsModel.order_4 >= 100) {
        [self.refundingItem.badgeLabel setHidden:NO];
        [self.refundingItem.badgeLabel setText:[NSString stringWithFormat:@"99+"]];
    } else {
        [self.refundingItem.badgeLabel setHidden:YES];
    }
    //购物车
    if (_staticsModel.cart > 0 && _staticsModel.cart < 20) {
        [self.shopCartItem.badgeLabel setHidden:NO];
        [self.shopCartItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.cart]];
    } else if (_staticsModel.cart >= 20 && _staticsModel.cart < 100) {
        [self.shopCartItem.badgeLabel setHidden:NO];
        [self.shopCartItem.badgeLabel setText:[NSString stringWithFormat:@"%ld",(long)_staticsModel.cart]];
    } else if (_staticsModel.cart >= 100) {
        [self.shopCartItem.badgeLabel setHidden:NO];
        [self.shopCartItem.badgeLabel setText:[NSString stringWithFormat:@"99+"]];
    } else {
        [self.shopCartItem.badgeLabel setHidden:YES];
    }
}

#pragma mark - lazy
- (PersonalCellItem *)shopCartItem {
    if (!_shopCartItem) {
        _shopCartItem = [[PersonalCellItem alloc] init];
        [_shopCartItem.itemImageView setImage:[UIImage imageNamed:@"order_5"]];
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
        [_refundingItem.itemImageView setImage:[UIImage imageNamed:@"order_4"]];
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
        [_waitReceiveItem.itemImageView setImage:[UIImage imageNamed:@"order_3"]];
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
        [_waitSendItem.itemImageView setImage:[UIImage imageNamed:@"order_2"]];
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
        [_waitPayItem.itemImageView setImage:[UIImage imageNamed:@"icon_monery"]];
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
