//
//  GroupDetailCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupDetailCollectionViewCell.h"

@interface GroupDetailCollectionViewCell()
@property(nonatomic ,strong) UIImageView *icon;
@end

@implementation GroupDetailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_offset(0);
        }];
    }
    return self;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        
        _icon.layer.cornerRadius = 45/2;
        _icon.layer.masksToBounds=YES;
    }
    return _icon;
}
- (void)setThumb:(NSString *)thumb andMark:(NSString *)mark{
    
    if ([thumb isEqualToString:@"无头像"]) {
        [self.icon setImage:[UIImage imageNamed:@"无头像"]];
    }else{
        [self.icon setYy_imageURL:[NSURL URLWithString:thumb]];
    }
}
@end
