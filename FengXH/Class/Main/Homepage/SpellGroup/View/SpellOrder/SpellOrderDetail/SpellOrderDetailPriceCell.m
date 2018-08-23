//
//  SpellOrderDetailPriceCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailPriceCell.h"

@implementation SpellOrderDetailPriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=KFont(15);
        _titleLab.textColor=KUIColorFromHex(0xb2b2b2);
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_offset(160);
            make.height.mas_offset(20);
        }];
        
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=KFont(15);
        _priceLab.textAlignment=NSTextAlignmentRight;
        _priceLab.adjustsFontSizeToFitWidth=YES;
        _priceLab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(_titleLab.mas_right).offset(5);
            make.height.mas_offset(20);
        }];
        
        
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic
{
    _titleLab.text=dataDic[@"title"];
    
    _priceLab.text=dataDic[@"price"];
    
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
