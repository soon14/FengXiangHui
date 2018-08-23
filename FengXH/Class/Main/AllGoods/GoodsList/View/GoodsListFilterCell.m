//
//  GoodsListFilterCell.m
//  FengXH
//
//  Created by sun on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsListFilterCell.h"
#import "AllCategoryDataModel.h"

@interface GoodsListFilterCell ()

/** textLabel */
@property(nonatomic , strong)UILabel *titleLabel;

@end

@implementation GoodsListFilterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
    }
    return self;
}

- (void)setResultModel:(AllCategoryDataResultModel *)resultModel {
    _resultModel = resultModel;
    [self.titleLabel setText:_resultModel.name];
}

- (void)setChildrenModel:(AllCategoryDataChildrenModel *)childrenModel {
    _childrenModel = childrenModel;
    [self.titleLabel setText:_childrenModel.name];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:KUIColorFromHex(0x666666)];
        [_titleLabel setFont:KFont(14)];
    }
    return _titleLabel;
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
