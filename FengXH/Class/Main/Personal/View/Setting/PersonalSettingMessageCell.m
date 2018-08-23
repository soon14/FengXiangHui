//
//  PersonalSettingMessageCell.m
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalSettingMessageCell.h"

@implementation PersonalSettingMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        
        _contentTextField=[[UITextField alloc]init];
        _contentTextField.borderStyle=UITextBorderStyleNone;
        _contentTextField.keyboardType=UIKeyboardTypeNumberPad;
        _contentTextField.font=KFont(16);
        _contentTextField.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_contentTextField];
        [_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLab.mas_right).offset(0);
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
        }];
        
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic
{
    _titleLab.text=dataDic[@"title"];
    _contentTextField.text=dataDic[@"message"];
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
