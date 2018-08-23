//
//  SpellOrderDetailMessageCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailMessageCell.h"
#import "SpellOrderDetailModel.h"

@implementation SpellOrderDetailMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _contentLab=[[UILabel alloc]init];
        _contentLab.font=KFont(15);
        _contentLab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
        }];
    }
    return self;
}

-(void)setDataModel:(SpellOrderDetailModel *)dataModel
{
    
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
