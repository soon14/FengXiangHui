//
//  ParticipateTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ParticipateTableViewCell.h"
#import "ParticipateModel.h"
@interface ParticipateTableViewCell()
@property(nonatomic ,strong) UIView *whiteView;
@property(nonatomic ,strong) UIImageView *icon;
@property(nonatomic ,strong) UILabel *name;
@property(nonatomic ,strong) UILabel *time;
@property(nonatomic ,strong) UILabel *group;
//去参团
@property(nonatomic ,strong) UILabel *participate;
@end

@implementation ParticipateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KUIColorFromHex(0xfaeeee);
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.right.bottom.mas_offset(-10);
        }];
        [self.whiteView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self.whiteView).offset(0);
            make.width.mas_equalTo(45);
        }];
        [self.whiteView addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView).offset(55);
            make.top.mas_equalTo(self.whiteView).offset(0);
            make.height.mas_equalTo(20);
        }];
        [self.whiteView addSubview:self.time];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView).offset(55);
            make.bottom.mas_equalTo(self.whiteView).offset(0);
            make.height.mas_equalTo(15);
        }];
        [self.whiteView addSubview:self.participate];
        [self.participate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.right.bottom.mas_equalTo(self.whiteView).offset(0);
            make.width.mas_equalTo(65);
        }];
        [self.whiteView addSubview:self.group];
        [self.group mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.mas_equalTo(self.whiteView).offset(0);
            make.right.mas_equalTo(self.participate.mas_left).offset(-10);
        }];
    }
    return self;
}
- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 22.5;
        _whiteView.clipsToBounds = YES;
    }
    return _whiteView;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.layer.cornerRadius = 22.5;
        
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = [UIColor blackColor];
        _name.font = KFont(14);

    }
    return _name;
}
- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = KUIColorFromHex(0x666666);
        _time.font = KFont(12);

    }
    return _time;
}
- (UILabel *)participate{
    if (!_participate) {
        _participate = [[UILabel alloc]init];
        _participate.backgroundColor = KUIColorFromHex(0xec6258);
        _participate.textColor = [UIColor whiteColor];
        _participate.font = KFont(16);
        _participate.textAlignment = NSTextAlignmentCenter;
        _participate.text = @"去参团";
    }
    return _participate;
}
- (UILabel *)group{
    if (!_group) {
        _group = [[UILabel alloc]init];
        
        _group.textColor = [UIColor blackColor];
        _group.font = KFont(15);
        _group.textAlignment = NSTextAlignmentRight;
        _group.text = @"还差2人成团";
        
    }
    return _group;
}
- (void)setParticipateModel:(ParticipateModel *)participateModel{
    _participateModel = participateModel;
    [self.icon setYy_imageURL:[NSURL URLWithString:_participateModel.avatar]];
    [self.name setText:[NSString stringWithFormat:@"%@",_participateModel.nickname]];
    NSInteger seconds = [_participateModel.residualtime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    [self.time setText:[NSString stringWithFormat:@"剩余：%@",format_time]];
    
    
    
}
@end
