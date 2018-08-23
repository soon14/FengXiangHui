//
//  StoreBottomItemCell.m
//  FengXH
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreBottomItemCell.h"
@interface StoreBottomItemCell()
//图标
@property(nonatomic,strong)UIImageView *iconImageView;
//名称
@property(nonatomic,strong)UILabel *nameLab;
//数量
@property(nonatomic,strong)UILabel *countLab;
@end
@implementation StoreBottomItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.height.mas_offset(25);
            make.top.mas_offset(20);
        }];
        
        [self addSubview:self.nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(5);
        }];
        
        [self addSubview:self.countLab];
        [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(15);
        }];
        
        
        
        
    }
    return self;
}
-(void)setStoreBottomItemData:(NSDictionary *)storeBottomItemData
{
    _nameLab.text=storeBottomItemData[@"name"];
//    _countLab.text=storeBottomItemData[@"count"];
    _iconImageView.image=[UIImage imageNamed:storeBottomItemData[@"iconImgName"]];
    if ([storeBottomItemData[@"count"] length]>0) {
        _countLab.hidden=NO;
        NSString *str = storeBottomItemData[@"count"];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range;
        if ([str hasSuffix:@"元"]) {
            range = [str rangeOfString:@"\\d[\\d.,]*(?=元)" options:NSRegularExpressionSearch];
        }
        else if ([str hasSuffix:@"笔"])
        {
            range = [str rangeOfString:@"\\d[\\d.,]*(?=笔)" options:NSRegularExpressionSearch];
        }
        else if ([str hasSuffix:@"人"])
        {
            range = [str rangeOfString:@"\\d[\\d.,]*(?=人)" options:NSRegularExpressionSearch];
        }
        if (range.location != NSNotFound) {
            [attStr addAttribute:NSForegroundColorAttributeName value:KUIColorFromHex(0xfbf456) range:range];
        }
        _countLab.attributedText = attStr;
    }
    else
    {
        _countLab.hidden=YES;
    }
    
}
#pragma mark-----懒加载
-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc]init];
    }
    return _iconImageView;
}
-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.textColor=KUIColorFromHex(0x333333);
        _nameLab.font=KFont(16);
        _nameLab.textAlignment=NSTextAlignmentCenter;
    }
    return _nameLab;
}
-(UILabel *)countLab
{
    if (!_countLab) {
        _countLab=[[UILabel alloc]init];
        _countLab.textColor=KUIColorFromHex(0x333333);
        _countLab.font=KFont(16);
        _countLab.textAlignment=NSTextAlignmentCenter;
    }
    return _countLab;
}

@end
