//
//  PersonalSettingPhoneCell.m
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalSettingPhoneCell.h"

@implementation PersonalSettingPhoneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        _titleLab.text=@"手机号";
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        
        //箭头
        UIImageView *arrowsImgView=[[UIImageView alloc]init];
        arrowsImgView.image=[UIImage imageNamed:@"home_icon_arrow"];
        [self addSubview:arrowsImgView];
        [arrowsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.height.mas_offset(13);
            make.width.mas_offset(7);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        //更改绑定
        UILabel *lab=[[UILabel alloc]init];
        lab.font=KFont(16);
        lab.text=@"更改绑定";
        lab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(70);
            make.right.mas_equalTo(arrowsImgView.mas_left).offset(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
        }];
        
        _phoneLab=[[UILabel alloc]init];
        _phoneLab.font=KFont(16);
        _phoneLab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_phoneLab];
        [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLab.mas_right).offset(0);
            make.right.mas_equalTo(lab.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
