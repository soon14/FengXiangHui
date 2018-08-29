//
//  SpellOrderCompletedCell.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCompletedCell.h"
#import "SpellOrderView.h"
#import "SpellOrderListModel.h"

@interface SpellOrderCompletedCell ()

@property(nonatomic,strong)SpellOrderView *orderView;

@end

@implementation SpellOrderCompletedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _orderView=[[SpellOrderView alloc]initWithType:3 andFrame:CGRectMake(0, 0, KMAINSIZE.width, 150)];
        [self addSubview:_orderView];
        
        for (int i=0; i<1; i++) {
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width-(70+10)*(i+1), 150+10, 70, 30)];
            btn.tag=400+i;
            btn.titleLabel.font=KFont(13);
            btn.layer.cornerRadius=4;
            btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
            btn.layer.shouldRasterize = YES;
            [btn addTarget:self action:@selector(completedClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
//            if (i==0) {
//                btn.backgroundColor=[UIColor redColor];
//                [btn setTitle:@"评论" forState:UIControlStateNormal];
//                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            }
//            else
//            {
            
                btn.backgroundColor=[UIColor whiteColor];
                [btn setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
                btn.layer.borderWidth=1;
                btn.layer.borderColor=KUIColorFromHex(0x333333).CGColor;
//                if (i==1) {
                    [btn setTitle:@"删除订单" forState:UIControlStateNormal];
                    
//                }
//                else
//                {
//                    [btn setTitle:@"查看物流" forState:UIControlStateNormal];
//
//                }
//            }
        }
        
        
        
    }
    return self;
}
-(void)completedClick:(UIButton *)sender
{
    if (self.btnClickBlock) {
        self.btnClickBlock(sender.tag-400);
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