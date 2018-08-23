//
//  JingdongItemCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "JingdongItemCollectionViewCell.h"
@interface JingdongItemCollectionViewCell()
@property (nonatomic ,strong) UIImageView *thumb;
@property (nonatomic ,strong) UILabel *title;
@end
@implementation JingdongItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.thumb];
        [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.right.mas_offset(-20);
            make.height.mas_equalTo(60);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
- (UIImageView *)thumb{
    if (!_thumb) {
        _thumb = [[UIImageView alloc]init];
    }
    return _thumb;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = KUIColorFromHex(0x666666);
        _title.font = KFont(12);
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
- (void)setThumb:(NSString *)imgStr setTitle:(NSString *)title{
    [self.thumb setYy_imageURL:[NSURL URLWithString:imgStr]];
    [self.title setText:title];
}
@end
