//
//  SpellOrderAfterSaleSelectCell.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderAfterSaleSelectCell.h"

@implementation SpellOrderAfterSaleSelectCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        _titleLab.text=@"处理方式";
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        
        _arrowsImgView=[[UIImageView alloc]init];
        _arrowsImgView.image=[UIImage imageNamed:@"home_icon_arrow"];
        [self addSubview:_arrowsImgView];
        [_arrowsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.height.mas_offset(13);
            make.width.mas_offset(7);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        _contentLab=[[UILabel alloc]init];
        _contentLab.textColor=KUIColorFromHex(0x333333);
        _contentLab.font=KFont(16);
        [self addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLab.mas_right).offset(0);
            make.right.mas_equalTo(_arrowsImgView.mas_left).offset(5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
        }];
        
    }
    return self;
}

@end
