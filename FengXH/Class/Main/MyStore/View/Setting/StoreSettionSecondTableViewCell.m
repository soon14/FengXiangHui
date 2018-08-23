//
//  StoreSettionSecondTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreSettionSecondTableViewCell.h"

@implementation StoreSettionSecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        _titleLab.text=@"图标";
        _titleLab.textColor=KUIColorFromHex(0x333333);
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        
        _iconBtn=[[UIButton alloc]init];
        [_iconBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [_iconBtn addTarget:self action:@selector(addIconAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_iconBtn];
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLab.mas_right).offset(0);
            make.width.height.mas_offset(50);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}
-(void)addIconAction
{
    if (self.addClick) {
        self.addClick();
    }
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
