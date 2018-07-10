//
//  HomepageSecondCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageThirdCell.h"

@implementation HomepageThirdCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}

- (void)itemTapAction:(UITapGestureRecognizer *)sender {
    if (self.thirdCellBlock) {
        self.thirdCellBlock(sender.view.tag);
    }
}

- (void)setRecentyLotteries:(NSArray *)recentyLotteries {
    _recentyLotteries = recentyLotteries;
    for (UIView *subViews in self.contentView.subviews) {
        [subViews removeFromSuperview];
    }
    float itemWidth = KMAINSIZE.width/5;
    float itemHeight = 100;
    for (NSInteger i=0; i<10; i++) {
        HomepageThirdItem *item = [[HomepageThirdItem alloc]init];
        [item setFrame:CGRectMake((i%5)*itemWidth, (i/5)*itemHeight, itemWidth, itemHeight)];
        [item setTag:i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemTapAction:)];
        [item addGestureRecognizer:tap];
        [self.contentView addSubview:item];
    }
}


@end
