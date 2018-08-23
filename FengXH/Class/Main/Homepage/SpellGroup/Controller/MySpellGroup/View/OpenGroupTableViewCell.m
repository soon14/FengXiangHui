//
//  OpenGroupTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OpenGroupTableViewCell.h"
#import "M80AttributedLabel.h"

@interface OpenGroupTableViewCell()
@property (nonatomic ,strong) M80AttributedLabel *titleLabel;
@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) UIView *footView;
@end

@implementation OpenGroupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(5);
        }];
        
        [self addSubview:self.footView];
        [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(5);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.right.mas_offset(-5);
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(5);
            make.bottom.mas_equalTo(self.footView.mas_top).offset(-5);
            
        }];
    }
    return self;
}
- (M80AttributedLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[M80AttributedLabel alloc]init];
        [_titleLabel setTextColor:KUIColorFromHex(0x666666)];
        [_titleLabel setFont:KFont(12)];
        NSString *text = @"*开团邀请两人参与，人数不足自动退款，详见拼团玩法";
        NSRange range   = [text rangeOfString:@"拼团玩法"];
        _titleLabel.text      = text;
        //    [label addCustomLink:[NSValue valueWithRange:range]
        //                forRange:range];
        [_titleLabel addCustomLink:[NSValue valueWithRange:range] forRange:range linkColor:[UIColor blackColor]];
//        _titleLabel.delegate = self;
 
    }
    return _titleLabel;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = KTableBackgroundColor;
    }
    return _headerView;
}
- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc]init];
        _footView.backgroundColor = KTableBackgroundColor;
    }
    return _footView;
}
@end
