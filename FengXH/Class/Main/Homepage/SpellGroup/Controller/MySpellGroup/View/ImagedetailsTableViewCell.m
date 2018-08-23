//
//  ImagedetailsTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ImagedetailsTableViewCell.h"

@interface ImagedetailsTableViewCell()
@property (nonatomic ,strong) UIImageView *img;
@end

@implementation ImagedetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];
    }
    return self;
}
- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
    }
    return _img;
}
- (void)setStr:(NSString *)dataStr{
    [self.img setYy_imageURL:[NSURL URLWithString:dataStr]];
}
@end
