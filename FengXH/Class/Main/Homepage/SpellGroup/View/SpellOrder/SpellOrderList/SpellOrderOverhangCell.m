//
//  SpellOrderOverhangCell.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderOverhangCell.h"
#import "SpellOrderView.h"
#import "SpellOrderListModel.h"

@interface SpellOrderOverhangCell ()

@property(nonatomic,strong)SpellOrderView *orderView;

@end

@implementation SpellOrderOverhangCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _orderView=[[SpellOrderView alloc]initWithType:1 andFrame:CGRectMake(0, 0, KMAINSIZE.width, 150)];
        [self addSubview:_orderView];
        
        
        
    }
    return self;
}
-(void)setDataModel:(SpellOrderListDataModel *)dataModel
{
    
    _orderView.dataModel=dataModel;
    
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
