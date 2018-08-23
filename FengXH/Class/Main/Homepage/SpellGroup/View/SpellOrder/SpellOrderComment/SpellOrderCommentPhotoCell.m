//
//  SpellOrderCommentPhotoCell.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCommentPhotoCell.h"

@implementation SpellOrderCommentPhotoCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        _photoImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _photoImgView.image=[UIImage imageNamed:@"添加"];
        [self addSubview:_photoImgView];
    }
    return self;
}

@end
