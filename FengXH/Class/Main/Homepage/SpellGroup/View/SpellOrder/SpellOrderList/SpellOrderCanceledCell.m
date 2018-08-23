//
//  SpellOrderCanceledCell.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCanceledCell.h"
#import "SpellOrderView.h"
#import "SpellOrderListModel.h"

@interface SpellOrderCanceledCell ()

@property(nonatomic,strong)SpellOrderView *orderView;

@end

@implementation SpellOrderCanceledCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _orderView=[[SpellOrderView alloc]initWithType:4 andFrame:CGRectMake(0, 0, KMAINSIZE.width, 150)];
        [self addSubview:_orderView];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width-(70+10), 150+10, 70, 30)];
        btn.titleLabel.font=KFont(13);
        btn.layer.cornerRadius=4;
        btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        btn.layer.shouldRasterize = YES;
        [btn addTarget:self action:@selector(canceledClick) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor whiteColor];
        [btn setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        btn.layer.borderWidth=1;
        btn.layer.borderColor=KUIColorFromHex(0x333333).CGColor;
        [btn setTitle:@"删除订单" forState:UIControlStateNormal];
        [self addSubview:btn];

        
    }
    return self;
}
-(void)canceledClick
{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
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
