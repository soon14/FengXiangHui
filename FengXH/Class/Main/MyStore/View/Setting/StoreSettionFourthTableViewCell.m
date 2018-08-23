//
//  StoreSettionFourthTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreSettionFourthTableViewCell.h"

@implementation StoreSettionFourthTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        _titleLab.text=@"简介";
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
        _introTextView.placeholder=@"小店简介，分享你的小店";

        
        
        
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
