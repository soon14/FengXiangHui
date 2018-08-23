//
//  PersonalFourthCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalFourthCell.h"

@implementation PersonalFourthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWidth = KMAINSIZE.width/4;
        CGFloat itemHeight = 90;
        
//        NSArray *imageArr = @[@"shop_1",@"shop_2",@"icon_my",@"shop_4",@"shop_5"];
//        NSArray *titleArr = @[@"邀请加入",@"开店礼包",@"我的团队",@"佣金收益",@"店铺管家"];
        NSArray *imageArr = @[@"shop_1",@"shop_2",@"icon_my",@"shop_4"];
        NSArray *titleArr = @[@"邀请加入",@"开店礼包",@"我的团队",@"佣金收益"];
        for (NSInteger i=0; i<4; i++) {
            PersonalCellItem *item = [[PersonalCellItem alloc] initWithFrame:CGRectMake(itemWidth*i, 0, itemWidth, itemHeight)];
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
