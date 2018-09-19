//
//  PaySuccessFooterCell.m
//  FengXH
//
//  Created by sun on 2018/9/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PaySuccessFooterCell.h"

@interface PaySuccessFooterCell ()

/** 返回按钮 */
@property(nonatomic , strong)UIButton *backButton;
/** 订单详情 */
@property(nonatomic , strong)UIButton *orderDetailButton;

@end

@implementation PaySuccessFooterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGFloat leftMargin = (KMAINSIZE.width - 240)/4;
        
        [self.contentView addSubview:self.orderDetailButton];
        [self.orderDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(32);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_offset(leftMargin);
        }];
        
        [self.contentView addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(32);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_offset(-leftMargin);
        }];
        
        
    }
    return self;
}

#pragma mark - action
- (void)backButtonAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock(sender.tag);
    }
}

#pragma mark - lazy
- (UIButton *)orderDetailButton {
    if (!_orderDetailButton) {
        _orderDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderDetailButton setBackgroundColor:[UIColor whiteColor]];
        [_orderDetailButton setTitle:@"订单详情" forState:UIControlStateNormal];
        [_orderDetailButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_orderDetailButton.titleLabel setFont:KFont(15)];
        [_orderDetailButton.layer setMasksToBounds:YES];
        [_orderDetailButton.layer setCornerRadius:16];
        [_orderDetailButton.layer setBorderColor:KUIColorFromHex(0x999999).CGColor];
        [_orderDetailButton.layer setBorderWidth:1];
        [_orderDetailButton setTag:0];
        [_orderDetailButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderDetailButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundColor:[UIColor whiteColor]];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_backButton.titleLabel setFont:KFont(15)];
        [_backButton.layer setMasksToBounds:YES];
        [_backButton.layer setCornerRadius:16];
        [_backButton.layer setBorderColor:KUIColorFromHex(0x999999).CGColor];
        [_backButton.layer setBorderWidth:1];
        [_backButton setTag:1];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
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
