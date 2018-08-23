//
//  SpellOrderCommentDiscussCell.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCommentDiscussCell.h"

@implementation SpellOrderCommentDiscussCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        _titleLab.text=@"评论";
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        
        _introTextView=[[UITextView alloc]init];
        _introTextView.font=KFont(14);
        [self addSubview:_introTextView];
        [_introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.bottom.right.mas_offset(-10);
            make.left.mas_equalTo(_titleLab.mas_right).offset(0);
        }];
        _introTextView.placeholder=@"说点什么吧";
        
    }
    return self;
}

@end
