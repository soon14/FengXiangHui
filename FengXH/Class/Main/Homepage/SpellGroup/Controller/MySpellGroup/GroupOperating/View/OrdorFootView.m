//
//  OrdorFootView.m
//  FengXH
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrdorFootView.h"
#import "M80AttributedLabel.h"
@interface OrdorFootView()
@property (nonatomic ,strong) UIView *line;
@property (nonatomic ,strong) M80AttributedLabel *price;
@property (nonatomic ,strong) UIButton *payBtn;
@end

@implementation OrdorFootView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        [self addSubview:self.payBtn];
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_offset(0);
            make.bottom.mas_offset(-KBottomHeight);
            make.width.mas_equalTo(100*KScreenRatio);
        }];
        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.right.mas_equalTo(self.payBtn.mas_left).offset(-5);
            make.bottom.mas_offset(-KBottomHeight);
            make.width.mas_equalTo(100*KScreenRatio);
        }];

    }
    return self;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
- (UIButton *)payBtn{
    if (!_payBtn) {
        
        _payBtn = [[UIButton alloc]init];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBtn.backgroundColor = KUIColorFromHex(0xec6258);
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        _payBtn.titleLabel.font = KFont(13);
        [_payBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}
- (M80AttributedLabel *)price{
    if (!_price) {
        _price = [[M80AttributedLabel alloc]init];
        _price.textAlignment = kCTTextAlignmentRight;
        _price.font = KFont(13);
        
    }
    return _price;
}
- (void)btnAction{
    if (self.fdelegate &&[self.fdelegate respondsToSelector:@selector(onItemClicks)]) {
        [self.fdelegate onItemClicks];
    }
}
- (void)setTitle:(NSString *)goodsTitle setPrice:(NSString *)price setFreight:(NSString *)freight setNum:(NSString *)num{
    double f = [price doubleValue] +[freight doubleValue];
    [_price setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"需付："] attributes:@{NSFontAttributeName:KFont(12),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_price appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f",f] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    

}
@end
