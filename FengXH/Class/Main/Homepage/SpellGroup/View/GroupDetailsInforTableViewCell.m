//
//  GroupDetailsInforTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupDetailsInforTableViewCell.h"
@interface GroupDetailsInforTableViewCell()
@property (nonatomic ,strong) UIImageView *icon;
@property (nonatomic ,strong) UILabel *name;
@property (nonatomic ,strong) UILabel *time;
@end
@implementation GroupDetailsInforTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.width.mas_equalTo(50);
        }];
        [self addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.left.mas_equalTo(self.icon.mas_right).offset(5);
        }];
        [self addSubview:self.time];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.right.mas_offset(-10);
        }];
    }
    return self;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.layer.cornerRadius = 25;
        _icon.layer.masksToBounds=YES;
    }
    return _icon;
}
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = KUIColorFromHex(0x757575);
        _name.font = KFont(14);
        _name.textAlignment = NSTextAlignmentLeft;
    }
    return _name;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = KUIColorFromHex(0x757575);
        _time.font = KFont(14);
        _name.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}
- (void)setIcon:(NSString *)icon AndName:(NSString *)name AndTime:(NSString *)time{
    [self.icon setYy_imageURL:[NSURL URLWithString:icon]];
    [self.name setText:name];
    [self.time setText:time];
}
@end
