//
//  StoreSettingFirstTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreSettingFirstTableViewCell.h"

@implementation StoreSettingFirstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        titleLab.text=@"名称";
        titleLab.textColor=KUIColorFromHex(0x333333);
        titleLab.font=KFont(16);
        [self addSubview:titleLab];
        
        _nameTextField=[[UITextField alloc]init];
        _nameTextField.placeholder=@"填写默认为您的昵称";
        _nameTextField.font=KFont(15);
        _nameTextField.borderStyle=UITextBorderStyleNone;
        [self addSubview:_nameTextField];
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_right).offset(0);
            make.right.mas_offset(-10);
            make.top.bottom.mas_offset(0);
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
