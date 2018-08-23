//
//  PhoneTopUpTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneTopUpTableViewCell.h"
#import "M80AttributedLabel.h"
@interface PhoneTopUpTableViewCell()
@property(nonatomic ,strong) UIImageView *whiteView;
@property(nonatomic ,strong) UILabel *title;
@property(nonatomic ,strong) UILabel *typeTitle;
@property(nonatomic ,strong) UILabel *content;
@property(nonatomic ,strong) UILabel *time;
@property(nonatomic ,strong) M80AttributedLabel *state;
@end
@implementation PhoneTopUpTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KTableBackgroundColor;
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(10);
            make.right.bottom.mas_offset(-10);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.whiteView).offset(10);
            make.right.mas_equalTo(self.whiteView).offset(-10);
            make.height.mas_equalTo(30);
        }];
        [self addSubview:self.typeTitle];
        [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView).offset(10);
            make.top.mas_equalTo(self.title.mas_bottom).offset(5);
            make.right.mas_equalTo(self.whiteView).offset(-10);
            make.height.mas_equalTo(15);
        }];
        [self addSubview:self.content];
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView).offset(10);
            make.top.mas_equalTo(self.typeTitle.mas_bottom).offset(5);
            make.right.mas_equalTo(self.whiteView).offset(-5);
            make.height.mas_equalTo(40);
        }];
        [self addSubview:self.time];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView).offset(10);
            make.top.mas_equalTo(self.content.mas_bottom).offset(5);
            make.right.mas_equalTo(self.whiteView).offset(-5);
            make.height.mas_equalTo(15);
        }];
        [self addSubview:self.state];
        [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView).offset(10);
            make.top.mas_equalTo(self.time.mas_bottom).offset(8);
            make.right.mas_equalTo(self.whiteView).offset(-5);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
- (UIImageView *)whiteView{
    if(!_whiteView){
        _whiteView = [[UIImageView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        _whiteView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _whiteView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
        _whiteView.layer.shadowRadius = 4;
        _whiteView.layer.cornerRadius = 5;
    }
    return _whiteView;
}
- (UILabel *)title{
    if(!_title){
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.text = @"话费消息通知";
        _title.font = KFont(16);
    }
    return _title;
}
- (UILabel *)typeTitle{
    if(!_typeTitle){
        _typeTitle = [[UILabel alloc]init];
        _typeTitle.textColor = [UIColor blackColor];
        _typeTitle.textAlignment = NSTextAlignmentLeft;
        _typeTitle.text = @"类型：充值";
        _typeTitle.font = KFont(13);
    }
    return _typeTitle;
}
- (UILabel *)content{
    if(!_content){
        _content = [[UILabel alloc]init];
        _content.textColor = [UIColor blackColor];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.numberOfLines = 0;
        _content.font = KFont(13);
    }
    return _content;
}
- (UILabel *)time{
    if(!_time){
        _time = [[UILabel alloc]init];
        _time.textColor = [UIColor blackColor];
        _time.textAlignment = NSTextAlignmentLeft;
        
        _time.font = KFont(13);
    }
    return _time;
}
- (M80AttributedLabel *)state{
    if(!_state){
        _state = [[M80AttributedLabel alloc]init];
        _state.textColor = [UIColor blackColor];
        _state.font = KFont(13);
        
    }
    return _state;
}
- (void)setTitle:(NSString *)str andTime:(NSString *)time andDateStatus:(NSString *)sta{
    [_content setText:[NSString stringWithFormat:@"内容：%@",str]];
    [_time setText:[NSString stringWithFormat:@"时间：%@",time]];
    if([sta isEqualToString:@"1"]){
        [_state setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"状态: "] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor]}]];
        [_state appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"成功"] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:KGreenColor}]];
    }else{
        [_state setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"状态:"] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:[UIColor blackColor]}]];
        [_state appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"失败"] attributes:@{NSFontAttributeName:KFont(13),NSForegroundColorAttributeName:KRedColor}]];
    }
}
@end
