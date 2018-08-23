//
//  DialCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "DialCollectionViewCell.h"

@interface DialCollectionViewCell()
@property (nonatomic ,strong) UIImageView *imgView;
@end

@implementation DialCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];
    }
    return self;
}
- (UIImageView *)imgView{
    if (!_imgView ) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}
- (void)setImg:(NSString *)img{
    [self.imgView setImage:[UIImage imageNamed:img]];
}
@end
