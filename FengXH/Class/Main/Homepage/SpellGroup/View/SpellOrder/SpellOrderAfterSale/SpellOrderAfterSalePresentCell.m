//
//  SpellOrderAfterSalePresentCell.m
//  FengXH
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderAfterSalePresentCell.h"

@implementation SpellOrderAfterSalePresentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _rightImgView=[[UIImageView alloc]init];
        _rightImgView.image=[UIImage imageNamed:@"shopCar_btn_check_nor"];
        [self addSubview:_rightImgView];
        [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.width.mas_offset(20);
        }];
        
        _titleLab=[[UILabel alloc]init];
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.adjustsFontSizeToFitWidth=YES;
        _titleLab.font=KFont(15);
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.right.mas_equalTo(_rightImgView.mas_left).offset(-5);
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
