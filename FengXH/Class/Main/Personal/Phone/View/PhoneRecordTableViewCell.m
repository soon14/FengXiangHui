//
//  PhoneRecordTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneRecordTableViewCell.h"

@interface PhoneRecordTableViewCell()
@property (nonatomic ,strong) UILabel *phoneNum;
@property (nonatomic ,strong) UILabel *time;
@property (nonatomic ,strong) UIView *line;
@end

@implementation PhoneRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.phoneNum];
        [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.height.mas_equalTo(40);
            make.top.mas_offset(5);
            make.width.mas_equalTo(150);
        }];
        [self addSubview:self.time];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.mas_equalTo(40);
            make.top.mas_offset(5);
            make.width.mas_equalTo(200);
        }];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_offset(0);
            make.left.mas_offset(10);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}
- (UILabel *)phoneNum{
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc]init];
        _phoneNum.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneNum;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = KUIColorFromHex(0x666666);
        _time.textAlignment = NSTextAlignmentRight;
        _time.font = KFont(14);
    }
    return _time;
}
- (UIView *)line{
    if(!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = KLineColor;
    }
    return _line;
}
- (void)setTitle:(NSString *)Num andTime:(NSString *)timelab{
    self.phoneNum.text = Num;
    self.time.text = timelab;
}
@end
