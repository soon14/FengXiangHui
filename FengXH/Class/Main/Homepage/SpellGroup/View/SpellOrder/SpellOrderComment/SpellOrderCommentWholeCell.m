//
//  SpellOrderCommentWholeCell.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCommentWholeCell.h"

@implementation SpellOrderCommentWholeCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        _titleLab.text=@"整单评价";
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        
    }
    return self;
}



@end
