//
//  GrpupGoodsDetailsTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GrpupGoodsDetailsTableViewCell.h"

@interface GrpupGoodsDetailsTableViewCell()
@property (nonatomic ,strong) UIImageView *thumb;
@end
@implementation GrpupGoodsDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.thumb];
        [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];
    }
    return self;
}
- (UIImageView *)thumb{
    if (!_thumb) {
        _thumb = [[UIImageView alloc]init];
    }
    return _thumb;
}
- (void)setImg:(NSString *)thumb{
    [self.thumb setYy_imageURL:[NSURL URLWithString:thumb]];
}
@end
