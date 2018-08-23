//
//  CommissionCell.m
//  FengXH
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CommissionCell.h"

@implementation CommissionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLab=[[UILabel alloc]init];
        _titleLab.textColor=[UIColor blackColor];
        _titleLab.font=KFont(16);
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_offset(100);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.top.mas_offset(0);
        }];
        
        _priceLab=[[UILabel alloc]init];
        _priceLab.textColor=[UIColor blackColor];
        _priceLab.font=KFont(14);
        _priceLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.left.mas_equalTo(self.titleLab.mas_right);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.top.mas_offset(0);
        }];
        
    }
    return self;
}
-(void)setCommissionData:(NSDictionary *)commissionData
{
    _titleLab.text=commissionData[@"title"];
    _priceLab.text=[NSString stringWithFormat:@"%@元",commissionData[@"commission"]];
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
