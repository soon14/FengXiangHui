//
//  HomepageDetailTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageDetailTableViewCell.h"

@implementation HomepageDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.detailImgView=[[UIImageView alloc]init];
        [self addSubview:_detailImgView];
        [_detailImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.mas_offset(0);
        }];
        
        
    }
    return self;
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
