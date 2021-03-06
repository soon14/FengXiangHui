//
//  GoodsDetailDragCell.m
//  FengXH
//
//  Created by sun on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailDragCell.h"

@implementation GoodsDetailDragCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KTableBackgroundColor;
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KRedColor];
        [label setFont:KFont(13)];
        [label setText:@"上拉加载详情"];
        [label setAdjustsFontSizeToFitWidth:YES];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
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
