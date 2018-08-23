//
//  SpellOrderDetailBottomView.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailBottomView.h"

@interface SpellOrderDetailBottomView ()

@property(nonatomic,assign)NSInteger orderType;

@end


@implementation SpellOrderDetailBottomView

-(instancetype)initWithType:(NSInteger)type  andFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        _orderType=type;
        
        self.backgroundColor=[UIColor whiteColor];
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    NSArray *btnArr;
    switch (_orderType) {
        case 0:
            //待付款
            btnArr=@[@"支付订单",@"取消订单"];
            break;
        case 1:
            //待发货(未申请退款)
            btnArr=@[@"申请退款"];
            break;
        case 5:
            //待发货(已申请退款)
            btnArr=@[@"取消申请",@"查看售后进度"];
            break;
        case 2:
            //待收货
            btnArr=@[@"确认收货"];
            break;
        case 3:
            //已完成(已申请售后)
            btnArr=@[@"取消申请",@"查看售后进度",@"删除订单"];
            break;
        case 4:
            //已完成(未售后)
            btnArr=@[@"申请售后",@"删除订单"];
            break;
        case -1:
            //已取消
            btnArr=@[@"删除订单"];
            break;
        default:
            break;
    }
    
    for (int i=0; i<btnArr.count; i++) {
    
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width-(70+10)*(i+1), 10, 70, 30)];
        btn.tag=100+i;
        btn.titleLabel.font=KFont(13);
        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
        btn.layer.cornerRadius=4;
        btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        btn.layer.shouldRasterize = YES;
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if ([btnArr[i] isEqualToString:@"取消订单"]||[btnArr[i] isEqualToString:@"删除订单"]||[btnArr[i] isEqualToString:@"取消申请"]) {
            [btn setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
            btn.layer.borderWidth=1;
            btn.layer.borderColor=KUIColorFromHex(0x333333).CGColor;
        }
        else
        {
            btn.backgroundColor=KUIColorFromHex(0xE9852B);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
    }
}
-(void)btnClick:(UIButton *)btn
{
    if (self.btnBlock) {
        self.btnBlock(btn.tag-100);
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
