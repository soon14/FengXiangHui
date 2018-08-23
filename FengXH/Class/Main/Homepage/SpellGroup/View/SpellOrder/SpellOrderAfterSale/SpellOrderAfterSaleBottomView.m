//
//  SpellOrderAfterSaleBottomView.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderAfterSaleBottomView.h"

@implementation SpellOrderAfterSaleBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        NSArray *btnArr=@[@"取消",@"提交申请"];
        
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
            if (i==0) {
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
    return self;
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
