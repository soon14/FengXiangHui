//
//  GroupMessageTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupMessageTableViewCell.h"
@interface GroupMessageTableViewCell()<UITextViewDelegate>
@property (nonatomic ,strong) UILabel *label;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong)UIView *line;
@end
@implementation GroupMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(10);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label.mas_right).offset(15);
            make.top.mas_offset(5);
            make.bottom.mas_offset(-15);
            make.right.mas_offset(-10);
        }];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(10);
        }];
    }
    return self;
}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor blackColor];
        [_label setTextAlignment:NSTextAlignmentLeft];
        _label.font = KFont(15);
        _label.text = @"买家留言";
    }
    return _label;
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.text = @"50字以内（选填）";
        _textView.textColor = KUIColorFromHex(0x666666);
        _textView.delegate = self;
    }
    return _textView;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(_textView.text.length < 1){
        _textView.text = @"50字以内（选填）";
        _textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([_textView.text isEqualToString:@"50字以内（选填）"]){
        _textView.text=@"";
        _textView.textColor=[UIColor blackColor];
    }
}


@end
