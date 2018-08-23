//
//  ShopkeeperTopTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShopkeeperTopTableViewCell.h"

@implementation ShopkeeperTopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KUIColorFromHex(0xE9852B);
        
        [self addSubview:self.commissionLab];
        _commissionLab.text=@"0.00元";
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 85, KMAINSIZE.width, 20)];
        lab.textColor=[UIColor whiteColor];
        lab.font=KFont(15);
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=@"累计佣金(元)";
        [self addSubview:lab];
        
    }
    return self;
}

-(UILabel *)commissionLab
{
    if (!_commissionLab) {
        _commissionLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 35, KMAINSIZE.width, 30)];
        _commissionLab.font=KFont(26);
        _commissionLab.textAlignment=NSTextAlignmentCenter;
        _commissionLab.textColor=[UIColor whiteColor];
    }
    return _commissionLab;
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
