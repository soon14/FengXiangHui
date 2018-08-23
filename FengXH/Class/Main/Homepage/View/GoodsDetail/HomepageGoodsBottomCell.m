//
//  HomepageGoodsBottomCell.m
//  FengXH
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsBottomCell.h"
#import "UIButton+LayoutSubviews.h"

@interface HomepageGoodsBottomCell ()

@property(nonatomic,strong)UIButton *btn;

@end

@implementation HomepageGoodsBottomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.btn];
        [_btn setImgViewStyle:ButtonImgViewStyleLeft imageSize:CGSizeMake(19, 12) space:10];
        
        
    }
    return self;
}

#pragma mark-----懒加载
- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame=CGRectMake(0, 0, KMAINSIZE.width, 50);
        [_btn setTitle:@"上拉查看图文详情" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        _btn.titleLabel.font=KFont(16);
        _btn.userInteractionEnabled=NO;
    }
    return _btn;
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
