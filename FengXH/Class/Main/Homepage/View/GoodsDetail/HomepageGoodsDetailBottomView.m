//
//  HomepageGoodsDetailBottomView.m
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsDetailBottomView.h"
#import "UIButton+LayoutSubviews.h"

@interface HomepageGoodsDetailBottomView ()

//购物车
@property(nonatomic,strong)UIButton *shopCartBtn;
//加入购物车
@property(nonatomic,strong)UIButton *addShopCartBtn;
//立刻购买
@property(nonatomic,strong)UIButton *immediatelyBuyBtn;

@end

@implementation HomepageGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *arr1=@[@"关注",@"购物车"];
        for (int i=0; i<2; i++) {
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width/3/2*i, 0, KMAINSIZE.width/3/2, 50)];
            [btn setTitle:arr1[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag=100+i;
            btn.titleLabel.font=KFont(12);
            [btn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(16, 16) space:2];
            
            switch (i) {
                case 0:
                    [btn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
                    btn.userInteractionEnabled=NO;
                    _attentionBtn=btn;
                    break;
                case 1:
                    [btn setImage:[UIImage imageNamed:@"home_icon_cart_nol"] forState:UIControlStateNormal];
                    _shopCartBtn=btn;
                    break;
                default:
                    break;
            }
        }
        
        NSArray *arr2=@[@"加入购物车",@"立刻购买"];
        for (int i=0; i<2; i++) {
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width/3*(i+1), 0, KMAINSIZE.width/3, 50)];
            [btn setTitle:arr2[i] forState:UIControlStateNormal];
            btn.tag=100+2+i;
            btn.titleLabel.font=KFont(16);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            switch (i) {
                case 0:
                    btn.backgroundColor=KUIColorFromHex(0xE9852B);
                    _addShopCartBtn=btn;
                    
                    break;
                case 1:
                    btn.backgroundColor=KRedColor;

                    _immediatelyBuyBtn=btn;
                    break;
                default:
                    break;
            }
        }
        
        
        
    }
    return self;
}
- (void)bottomBtnAction:(UIButton *)sender {
    if (self.bottomBlock) {
        self.bottomBlock(sender.tag-100);
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
