//
//  PersonalSixthCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalSixthCell.h"

@implementation PersonalSixthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWidth = KMAINSIZE.width/4;
        CGFloat itemHeight = 90;
        
        NSArray *imageArr = @[@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl"];
        NSArray *titleArr = @[@"我的素材",@"推广海报",@"优惠券",@"兑换码",@"我的收藏",@"我的足迹",@"收货地址",@"邀请绑定"];
        for (NSInteger i=0; i<8; i++) {
            PersonalCellItem *item = [[PersonalCellItem alloc] initWithFrame:CGRectMake((i%4)*itemWidth, (i/4)*itemWidth, itemWidth, itemHeight)];
            [item.itemImageView setImage:[UIImage imageNamed:imageArr[i]]];
            [item.itemTitleLabel setText:titleArr[i]];
            [self addSubview:item];
            [item setTag:i];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
            [item addGestureRecognizer:tap];
        }
        
    }
    return self;
}

#pragma mark - action
- (void)clickAction:(UITapGestureRecognizer *)sender {
    if (self.cellClickBlock) {
        self.cellClickBlock(sender.view.tag);
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
