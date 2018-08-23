//
//  PayOrderMethodCell.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PayOrderMethodCell.h"
#import "PayOrderMethodItem.h"
#import "WXApi.h"

@interface PayOrderMethodCell ()

/** 微信 */
@property(nonatomic , strong)PayOrderMethodItem *wechatPay;
/** 支付宝 */
@property(nonatomic , strong)PayOrderMethodItem *aliPay;
/** 京东 */
@property(nonatomic , strong)PayOrderMethodItem *jdPay;

@end

@implementation PayOrderMethodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        CGFloat height = 70;
        
        [self.contentView addSubview:self.wechatPay];
        [self.wechatPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(height);
        }];
        
        
        [self.contentView addSubview:self.aliPay];
        [self.aliPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(_wechatPay.mas_bottom);
            make.height.mas_equalTo(height);
        }];
        
        [self.contentView addSubview:self.jdPay];
        [self.jdPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(height);
        }];
        
        [self.aliPay setHidden:YES];
        [self.jdPay setHidden:YES];
        for (NSInteger i=1; i<2; i++) {
            UIView *line = [[UIView alloc] init];
            [line setBackgroundColor:KLineColor];
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(12);
                make.right.mas_offset(0);
                make.height.mas_equalTo(0.5);
                make.top.mas_equalTo(height*i);
            }];
        }
        
    }
    return self;
}

#pragma mark - action
- (void)payMethodAction:(UIGestureRecognizer *)sender {
    if (self.payMethodBlock) {
        self.payMethodBlock(sender.view.tag);
    }
}


#pragma mark - lazy
- (PayOrderMethodItem *)jdPay {
    if (!_jdPay) {
        _jdPay = [[PayOrderMethodItem alloc] init];
        [_jdPay.iconView setImage:[UIImage imageNamed:@"pay_jingdong"]];
        [_jdPay.titleLabel setText:@"京东支付"];
        [_jdPay.detailLabel setText:@"京东安全支付"];
        [_jdPay setTag:2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payMethodAction:)];
        [_jdPay addGestureRecognizer:tap];
    }
    return _jdPay;
}

- (PayOrderMethodItem *)aliPay {
    if (!_aliPay) {
        _aliPay = [[PayOrderMethodItem alloc] init];
        [_aliPay.iconView setImage:[UIImage imageNamed:@"pay_ali"]];
        [_aliPay.titleLabel setText:@"支付宝支付"];
        [_aliPay.detailLabel setText:@"支付宝安全支付"];
        [_aliPay setTag:1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payMethodAction:)];
        [_aliPay addGestureRecognizer:tap];
    }
    return _aliPay;
}

- (PayOrderMethodItem *)wechatPay {
    if (!_wechatPay) {
        _wechatPay = [[PayOrderMethodItem alloc] init];
        [_wechatPay.iconView setImage:[UIImage imageNamed:@"pay_wechat"]];
        [_wechatPay.titleLabel setText:@"微信支付"];
        [_wechatPay.detailLabel setText:@"微信安全支付"];
        [_wechatPay setTag:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payMethodAction:)];
        [_wechatPay addGestureRecognizer:tap];
    }
    return _wechatPay;
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
