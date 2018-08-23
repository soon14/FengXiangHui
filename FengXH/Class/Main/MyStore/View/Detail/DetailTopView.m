//
//  DetailTopView.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "DetailTopView.h"
@interface DetailTopView()

@property(nonatomic,assign)NSInteger detailType;


@end

@implementation DetailTopView


- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];

        _detailType = type;
        
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    UIView *topBgView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 40)];
    topBgView.backgroundColor=KUIColorFromHex(0xE9852B);
    [self addSubview:topBgView];
    
    self.commissionLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, KMAINSIZE.width-20, 40)];
    _commissionLab.font=KFont(16);
    _commissionLab.text=@"佣金：0.00元";
    _commissionLab.textColor=[UIColor whiteColor];
    [topBgView addSubview:_commissionLab];
    
    NSArray *titleArr;
    if (_detailType==0) {
        titleArr=@[@"所有",@"待付款",@"已付款",@"已完成"];
    }
    else
    {
        titleArr=@[@"所有",@"待审核",@"待打款",@"已打款",@"无效"];
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
            [titleBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.mas_offset(0);
                make.top.mas_offset(40);
            }];
        }
        else if (i==titleArr.count-1)
        {
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftBtn.mas_right);
                make.top.mas_offset(40);
                make.width.mas_equalTo(leftBtn.mas_width);
                make.right.bottom.mas_offset(0);
            }];
        }
       else
       {
           [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(leftBtn.mas_right);
               make.top.mas_offset(40);
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
    
    _moveLine = [[UIView alloc]initWithFrame:CGRectMake(0, 80, KMAINSIZE.width/titleArr.count, 2)];
    [_moveLine setBackgroundColor:KUIColorFromHex(0xff5753)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_moveLine.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _moveLine.bounds;
    maskLayer.path = maskPath.CGPath;
    _moveLine.layer.mask = maskLayer;
    [self addSubview:self.moveLine];
    
    
}
- (void)buttonAction:(UIButton *)sender {
    if (self.detailTypeBlock) {
        self.detailTypeBlock(sender.tag-1000);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
