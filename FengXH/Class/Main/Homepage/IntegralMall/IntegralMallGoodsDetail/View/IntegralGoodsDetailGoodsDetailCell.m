//
//  IntegralGoodsDetailGoodsDetailCell.m
//  FengXH
//
//  Created by sun on 2018/9/29.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralGoodsDetailGoodsDetailCell.h"

@interface IntegralGoodsDetailGoodsDetailCell ()

/** 图 */
@property(nonatomic , strong)UIImageView *detailImageView;

@end

@implementation IntegralGoodsDetailGoodsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.detailImageView];
        [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setImageURLString:(NSString *)imageURLString {
    _imageURLString = imageURLString;
    [self.detailImageView setYy_imageURL:[NSURL URLWithString:_imageURLString]];
}

#pragma mark - lazy
- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
    }
    return _detailImageView;
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
