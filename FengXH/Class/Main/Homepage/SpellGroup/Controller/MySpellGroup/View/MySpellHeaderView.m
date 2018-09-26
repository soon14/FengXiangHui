//
//  MySpellHeaderView.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MySpellHeaderView.h"

@interface MySpellHeaderView()

@property(nonatomic,assign)NSInteger spellType;

@end

@implementation MySpellHeaderView

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _spellType = type;
        
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    
    NSArray *titleArr;
    if (_spellType==0) {
        titleArr=@[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
    }
    else
    {
        titleArr=@[@"组团中",@"组团成功",@"组团失败"];
    }
    
    UIButton *leftBtn;
    for (int i=0; i<titleArr.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [titleBtn setTag:1000+i];
        [titleBtn.titleLabel setFont:KFont(14)];
        titleBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
        
        if (i==0) {
            [titleBtn setTitleColor:KRedColor forState:UIControlStateNormal];
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.mas_offset(0);
                make.top.mas_offset(0);
            }];
        }
        else if (i==titleArr.count-1)
        {
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftBtn.mas_right);
                make.top.mas_offset(0);
                make.width.mas_equalTo(leftBtn.mas_width);
                make.right.bottom.mas_offset(0);
            }];
        }
        else
        {
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftBtn.mas_right);
                make.top.mas_offset(0);
                make.width.mas_equalTo(leftBtn.mas_width);
                make.bottom.mas_offset(0);
            }];
        }
        
        leftBtn=titleBtn;
        
        switch (titleBtn.tag) {
            case 1000:
                _firstBtn=titleBtn;
                break;
            case 1001:
                _secondBtn=titleBtn;
                break;
            case 1002:
                _thirdBtn=titleBtn;
                break;
            case 1003:
                _fourthBtn=titleBtn;
                break;
            case 1004:
                _fifthBtn=titleBtn;
                break;
            default:
                break;
        }
        
    }
    
    
    //小黑线
    UIView *line = [[UIView alloc]init];
    [line setBackgroundColor:KLineColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    _moveLine = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KMAINSIZE.width/titleArr.count, 2)];
    [_moveLine setBackgroundColor:KUIColorFromHex(0xff5753)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_moveLine.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _moveLine.bounds;
    maskLayer.path = maskPath.CGPath;
    _moveLine.layer.mask = maskLayer;
    [self addSubview:self.moveLine];
    
    
}
- (void)buttonAction:(UIButton *)sender {
    if (self.spellTypeBlock) {
        self.spellTypeBlock(sender.tag-1000);
    }
}

@end
