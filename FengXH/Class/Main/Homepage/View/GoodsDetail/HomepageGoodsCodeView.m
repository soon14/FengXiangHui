//
//  HomepageGoodsCodeView.m
//  FengXH
//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsCodeView.h"

@interface HomepageGoodsCodeView ()<UIGestureRecognizerDelegate>



@end

@implementation HomepageGoodsCodeView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.7f];
        
        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
        tapGes.delegate=self;
        [self addGestureRecognizer:tapGes];
        
        _imgView=[[UIImageView alloc]init];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.right.mas_offset(-20);
            make.height.mas_offset(500);
            make.top.mas_offset(20+KTopHeight);
        }];
        
        UIButton *closeBtn=[[UIButton alloc]init];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_shutdown"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-20);
            make.centerX.mas_equalTo(self.imgView.centerX);
            make.height.width.mas_offset(60);
        }];
    }
    return self;
}
//手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:_imgView]) {
        return NO;
    }
    
    return YES;
    
}
-(void)closeAction
{
    self.hidden=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
