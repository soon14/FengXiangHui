//
//  StoreSettionThirdTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreSettionThirdTableViewCell.h"

@implementation StoreSettionThirdTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        titleLab.text=@"店招";
        titleLab.textColor=KUIColorFromHex(0x333333);
        titleLab.font=KFont(16);
        [self addSubview:titleLab];
        
        _imgBtn=[[UIButton alloc]init];
        [_imgBtn setBackgroundImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
        [_imgBtn addTarget:self action:@selector(addImgAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_imgBtn];
        [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_right).offset(0);
            make.width.mas_offset(180);
            make.height.mas_offset(100);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}
-(void)addImgAction
{
    if (self.upLoadClick) {
        self.upLoadClick();
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
