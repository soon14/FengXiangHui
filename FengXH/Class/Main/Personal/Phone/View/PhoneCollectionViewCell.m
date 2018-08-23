//
//  PhoneCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneCollectionViewCell.h"
@interface PhoneCollectionViewCell()
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UILabel *letter;
@end

@implementation PhoneCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-15);
        }];
    }
    return self;
}
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = KFont(33);
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UILabel *)letter {
    if (!_letter) {
        _letter = [[UILabel alloc]init];
        _letter.font = KFont(9);
        _letter.textColor = [UIColor blackColor];
        _letter.textAlignment = NSTextAlignmentCenter;
    }
    return _letter;
}
- (void)setTitle:(NSString *)title andLetter:(NSString *)letter{
    _title.text = title;
}
@end
