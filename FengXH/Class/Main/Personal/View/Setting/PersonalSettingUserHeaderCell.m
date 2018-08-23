//
//  PersonalSettingUserHeaderCell.m
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalSettingUserHeaderCell.h"

@implementation PersonalSettingUserHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        
        _headImgView=[[UIImageView alloc]init];
        [self addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(60);
            make.height.mas_offset(60);
        }];
        
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
        
        
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=KFont(16);
        _nameLab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headImgView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
            make.right.mas_equalTo(arrowsImgView.mas_right).offset(-5);
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
