//
//  GoodsDetailContentImageCell.m
//  FengXH
//
//  Created by sun on 2018/9/18.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailContentImageCell.h"

@interface GoodsDetailContentImageCell ()

/** imageV */
@property(nonatomic , strong)UIImageView *imageV;

@end

@implementation GoodsDetailContentImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    [self.imageV setYy_imageURL:[NSURL URLWithString:_urlString]];
}

#pragma mark - lazy
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
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
