//
//  SpellOrderDetailTopCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailTopCell.h"
#import "SpellOrderDetailModel.h"

@implementation SpellOrderDetailTopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KUIColorFromHex(0xE9852B);
        
        _statusLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, KMAINSIZE.width-20, 25)];
        _statusLab.textColor=[UIColor whiteColor];
        _statusLab.font = [UIFont boldSystemFontOfSize:20];
//        _statusLab.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(20.0)];
        [self addSubview:_statusLab];
        
        _orderPriceLab=[[UILabel alloc]init];
        _orderPriceLab.textColor=[UIColor whiteColor];
        _orderPriceLab.font=KFont(14);
        [self addSubview:_orderPriceLab];
        [_orderPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.width.mas_offset(KMAINSIZE.width-20);
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
