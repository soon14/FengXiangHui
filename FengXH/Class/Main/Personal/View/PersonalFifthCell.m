//
//  PersonalFifthCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalFifthCell.h"

@implementation PersonalFifthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWidth = KMAINSIZE.width/5;
        CGFloat itemHeight = 90;
        
        NSArray *imageArr = @[@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl",@"Personal_thjl"];
        NSArray *titleArr = @[@"新手攻略",@"进阶必听",@"店主风采",@"空中课堂",@"活动咨询"];
        for (NSInteger i=0; i<5; i++) {
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
