//
//  AddressBtnTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressBtnTableViewCell.h"
#import "M80AttributedLabel.h"
@interface AddressBtnTableViewCell()
@property (nonatomic ,strong)UIView *line;
@property (nonatomic ,strong)M80AttributedLabel *title;
@end
@implementation AddressBtnTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(10);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];

        
    }
    return self;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
- (M80AttributedLabel *)title{
    if (!_title) {
        _title = [[M80AttributedLabel alloc]init];
        _title.textColor = KUIColorFromHex(0x666666);
        [_title setTextAlignment:kCTTextAlignmentLeft];
        _title.font = KFont(15);
        [_title appendImage:[UIImage imageNamed:@"global_btn_nember_add"] maxSize:CGSizeMake(20, 20)];

        [_title appendText:@" 添加收获地址"];
    }
    return _title;
}

@end
