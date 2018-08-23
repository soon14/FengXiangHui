//
//  SpellOrderCommentGradeCell.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCommentGradeCell.h"

@interface SpellOrderCommentGradeCell ()
{
    UIView *_btnView;//放星星的背景view
    UIView *_showView;//在星星上面的view
    CGFloat _height;//星星的高
    NSInteger _btnNum;//按钮的数量
    NSInteger _index;//第几个
}
//评分view
@property(nonatomic,strong)UIView *gradeView;

@property (nonatomic, assign) int value;

@end

@implementation SpellOrderCommentGradeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        titleLab.text=@"评分";
        titleLab.textColor=KUIColorFromHex(0x333333);
        titleLab.font=KFont(16);
        [self addSubview:titleLab];
        
        _gradeView=[[UIView alloc]init];
        [self addSubview:_gradeView];
        [_gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_right).offset(0);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-10);
            make.top.mas_offset(10);
        }];
        
        
        _height = 40;
        _btnNum = 5;
        CGFloat starW = 40;
        _btnView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, starW*5, starW)];
        for (int i = 0; i< 5; i++) {
            UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            starBtn.frame = CGRectMake(starW * i, 0, starW, starW);
            [starBtn setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [starBtn setImage:[UIImage imageNamed:@"star_light"] forState:UIControlStateSelected];
            starBtn.tag = 1991+i;
            [starBtn setAdjustsImageWhenHighlighted:NO];
            [_btnView addSubview:starBtn];
        }
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, starW*5, starW)];
        [_btnView addSubview:_showView];
        [_gradeView addSubview:_btnView];
        
        
        
    }
    return self;
}


//滑动需要的。
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self getTouchPoint:touches];
    int j = (int)(point.x/_height);
    _index = j;
    for (NSInteger i = 0; i < _btnNum; i++) {
        if (i<=j) {
            UIButton *btn = [_btnView viewWithTag:i+1991];
            btn.selected = YES;
        }else{
            UIButton *btn = [_btnView viewWithTag:i+1991];
            btn.selected = NO;
        }
    }
}
//滑动需要的。
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self getTouchPoint:touches];
    int j = (int)(point.x/_height);
    _index = j;
    for (NSInteger i = 0; i < _btnNum; i++) {
        if (i<=j) {
            UIButton *btn = [_btnView viewWithTag:i+1991];
            btn.selected = YES;
        }else{
            UIButton *btn = [_btnView viewWithTag:i+1991];
            btn.selected = NO;
        }
    }
}
//滑动需要的。
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:[NSString stringWithFormat:@"%ld",(long)_index+1]];
    }
}
//取到 手势 在屏幕上点的 位置point
- (CGPoint)getTouchPoint:(NSSet<UITouch *>*)touches{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_showView];
    return point;
}
//如果点击的范围在 按钮的区域
- (BOOL)pointInBtn:(UIButton *)btn WithPoint:(CGPoint)point{
    if (CGRectContainsPoint(btn.frame, point)) {
        return YES;
    }
        return NO;
}




@end
