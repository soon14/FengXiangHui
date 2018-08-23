//
//  ShopBottomCell.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShopBottomCell.h"

@implementation ShopBottomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, KMAINSIZE.width-20, 20)];
        lab.textColor=[UIColor blackColor];
        lab.font=KFont(16);
        lab.text=@"用户需知";
        [self addSubview:lab];
        
        _contentLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, KMAINSIZE.width-20, 60)];
        _contentLab.numberOfLines = 0;
        _contentLab.font=KFont(15);
        _contentLab.textColor=[UIColor blackColor];
        NSString *str=@"买家确认收货(3天)后，佣金可提现。结算内，买家退货，佣金将自动扣除。注意：可用佣金满1元后才能申请提现。";
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:str];
        [attribut setAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0xE9852B)} range:[str rangeOfString:@"(3天)"]];
        [attribut setAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0xE9852B)} range:[str rangeOfString:@"1元"]];
        _contentLab.attributedText = attribut;
        [self addSubview:_contentLab];
        
        
        
        
        
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
