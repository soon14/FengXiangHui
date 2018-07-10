//
//  HomepageFifthCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageFifthCell.h"

@implementation HomepageFifthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWith = KMAINSIZE.width/3;
        CGFloat itemHeight = self.frame.size.height;
        NSArray *colorArray = @[[UIColor orangeColor],[UIColor yellowColor],[UIColor cyanColor]];
        for (NSInteger i=0; i<3; i++) {
            UIImageView *imageV = [[UIImageView alloc] init];
            [imageV setFrame:CGRectMake(itemWith*i, 0, itemWith, itemHeight)];
            [imageV setBackgroundColor:colorArray[i]];
            [imageV setUserInteractionEnabled:YES];
            [imageV setTag:i];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)];
            [imageV addGestureRecognizer:tap];
            [self.contentView addSubview:imageV];
        }
        
    }
    return self;
}

#pragma mark - 图片被点击
- (void)imageClickAction:(UITapGestureRecognizer *)sender {
    if (self.fifthCellBlock) {
        self.fifthCellBlock(sender.view.tag);
    }
}

@end
