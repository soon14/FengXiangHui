//
//  JingdongImgCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "JingdongImgCollectionViewCell.h"
@interface JingdongImgCollectionViewCell()
@property (nonatomic ,strong) UIImageView *image;
@end
@implementation JingdongImgCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];
    }
    return self;
}
- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
    }
    return _image;
}
- (void)setImg:(NSString *)imgStr{
    [self.image setYy_imageURL:[NSURL URLWithString:imgStr]];
}
@end
