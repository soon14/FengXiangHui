//
//  HomepageFourthCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageFourthCell.h"

@implementation HomepageFourthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *hotImageView = [[UIImageView alloc] init];
        [hotImageView setImage:[UIImage imageNamed:@"home_hot"]];
        [self.contentView addSubview:hotImageView];
        [hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(6);
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(36);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(hotImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
        
    }
    return self;
}

@end
