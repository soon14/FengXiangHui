//
//  ConfirmOrderRemarkCell.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderRemarkCell.h"

@implementation ConfirmOrderRemarkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x666666)];
        [label setFont:KFont(14)];
        [label setText:@"买家留言"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.remarkTextField];
        [self.remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).offset(10);
            make.top.bottom.mas_offset(0);
            make.right.mas_offset(-12);
        }];
        
    }
    return self;
}


#pragma mark - lazy
- (UITextField *)remarkTextField {
    if (!_remarkTextField) {
        _remarkTextField = [[UITextField alloc] init];
        [_remarkTextField setTextColor:KUIColorFromHex(0x666666)];
        [_remarkTextField setFont:KFont(14)];
        [_remarkTextField setPlaceholder:@"（选填）"];
        [_remarkTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return _remarkTextField;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
