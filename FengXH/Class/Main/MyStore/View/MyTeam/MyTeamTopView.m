//
//  MyTeamTopView.m
//  FengXH
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyTeamTopView.h"

@implementation MyTeamTopView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.stairShopkeeper];
        [_stairShopkeeper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.mas_offset(0);
        }];
        
        [self addSubview:self.secondShopkeeper];
        [_secondShopkeeper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.stairShopkeeper.mas_right);
            make.width.mas_equalTo(self.stairShopkeeper.mas_width);
            make.top.bottom.right.mas_offset(0);
            
        }];
        
        [self addSubview:self.moveLine];
        
        
        
        //小黑线
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}
- (void)buttonAction:(UIButton *)sender {
    if (self.myTeamBlock) {
        self.myTeamBlock(sender.tag-2000);
    }
}
#pragma mark----懒加载
-(UIButton *)stairShopkeeper
{
    if (!_stairShopkeeper) {
        _stairShopkeeper = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stairShopkeeper setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
        [_stairShopkeeper setTag:2000];
        [_stairShopkeeper.titleLabel setFont:KFont(14)];
        _stairShopkeeper.titleLabel.textAlignment=NSTextAlignmentCenter;
        [_stairShopkeeper setTitle:@"一级店主" forState:UIControlStateNormal];
        [_stairShopkeeper addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stairShopkeeper;
}
-(UIButton *)secondShopkeeper
{
    if (!_secondShopkeeper) {
        _secondShopkeeper = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondShopkeeper setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_secondShopkeeper setTag:2001];
        [_secondShopkeeper.titleLabel setFont:KFont(14)];
        _secondShopkeeper.titleLabel.textAlignment=NSTextAlignmentCenter;
        [_secondShopkeeper setTitle:@"二级店主" forState:UIControlStateNormal];
        [_secondShopkeeper addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondShopkeeper;
}
-(UIView *)moveLine
{
    if (!_moveLine) {
        _moveLine = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KMAINSIZE.width/2, 2)];
        [_moveLine setBackgroundColor:KUIColorFromHex(0xff5753)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_moveLine.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _moveLine.bounds;
        maskLayer.path = maskPath.CGPath;
        _moveLine.layer.mask = maskLayer;
    }
    return _moveLine;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
