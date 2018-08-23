//
//  GroupEndCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupEndCollectionViewCell.h"
@interface GroupEndCollectionViewCell()
@property (nonatomic ,strong) UIView *line;
@property (nonatomic ,strong) UIView *lineB;
@property (nonatomic ,strong) UILabel *titleTT;
@property(nonatomic , assign)NSInteger spellType;
@end
@implementation GroupEndCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        [self addSubview:self.lineB];
        [self.lineB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(10);
        }];
        [self addSubview:self.titleTT];
        [self.titleTT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.line.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self.lineB.mas_top).offset(-10);
        }];
    }
    return self;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
- (UIView *)lineB {
    if (!_lineB) {
        _lineB = [[UIView alloc]init];
        _lineB.backgroundColor = KTableBackgroundColor;
    }
    return _lineB;
}
- (UILabel *)titleTT{
    if (!_titleTT) {
        _titleTT = [[UILabel alloc]init];
        _titleTT.textColor = KUIColorFromHex(0x757575);
        _titleTT.textAlignment = NSTextAlignmentCenter;
        _titleTT.font = KFont(14);
    }
    return _titleTT;
}

- (void)setTitle:(NSString *)str{
    [self.titleTT setText:str];
}
@end
