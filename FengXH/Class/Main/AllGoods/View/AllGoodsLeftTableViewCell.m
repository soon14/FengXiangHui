//
//  LeftTableViewCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AllGoodsLeftTableViewCell.h"
#import "AllCategoryDataModel.h"

@interface AllGoodsLeftTableViewCell ()

@property(nonatomic , strong)UILabel *titleLabel;
@property(nonatomic , strong)UIView *redLineView;

@end

@implementation AllGoodsLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KTableBackgroundColor;
        
        UIView *selectedView = [[UIView alloc]init];
        selectedView.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = selectedView;
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
        
        [selectedView addSubview:self.redLineView];
        [self.redLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_offset(0);
            make.width.mas_equalTo(2);
        }];
        
        if (self.selected==YES) {
            [self.titleLabel setTextColor:KUIColorFromHex(0xff463c)];
        } else {
            [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        }
        
    }
    return self;
}


- (void)setCatetoryModel:(AllCategoryDataResultModel *)catetoryModel {
    _catetoryModel = catetoryModel;
    [self.titleLabel setText:_catetoryModel.name];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_titleLabel setFont:KFont(13)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIView *)redLineView {
    if (!_redLineView) {
        _redLineView = [[UIView alloc]init];
        [_redLineView setBackgroundColor:KUIColorFromHex(0xff463c)];
    }
    return _redLineView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected==YES) {
        [self.titleLabel setTextColor:KUIColorFromHex(0xff463c)];
    } else {
        [self.titleLabel setTextColor:KUIColorFromHex(0x333333)];
    }
    // Configure the view for the selected state
}

@end
