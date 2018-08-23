//
//  GroupGoodsTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupGoodsTableViewCell.h"
#import "M80AttributedLabel.h"
#import "GroupOperatingModel.h"
@interface GroupGoodsTableViewCell()
@property (nonatomic ,strong) UIImageView *thumb;
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UILabel *num;
@property (nonatomic ,strong) M80AttributedLabel *price;
@property (nonatomic ,strong) UIView *line;
@end

@implementation GroupGoodsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.thumb];
        [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(5);
            make.bottom.mas_offset(-10);
            make.width.mas_equalTo(100*KScreenRatio);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(105*KScreenRatio);
            make.top.mas_offset(5);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(40);
        }];
        [self addSubview:self.num];
        [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(105*KScreenRatio);
            make.top.mas_equalTo(self.title.mas_bottom).offset(5);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(105*KScreenRatio);
            make.bottom.mas_offset(-20);

            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(10);
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
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = KUIColorFromHex(0x666666);
        [_title setTextAlignment:NSTextAlignmentLeft];
        _title.numberOfLines = 0;
        _title.font = KFont(15);
    }
    return _title;
}
- (UILabel *)num{
    if (!_num) {
        _num = [[UILabel alloc]init];
        _num.textColor = KUIColorFromHex(0x666666);
        [_num setTextAlignment:NSTextAlignmentLeft];
        
        _num.font = KFont(15);
    }
    return _num;
}
- (M80AttributedLabel *)price{
    if (!_price) {
        _price = [[M80AttributedLabel alloc]init];
        _price.textAlignment = kCTTextAlignmentLeft;
        _price.font = KFont(15);
    }
    return _price;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
- (void)setGroupOperatingModel:(GroupOperatingModel *)groupOperatingModel{
    _groupOperatingModel = groupOperatingModel;
    [self.thumb setYy_imageURL:[NSURL URLWithString:_groupOperatingModel.thumb]];
    [self.title setText:[NSString stringWithFormat:@"%@",_groupOperatingModel.title]];
    [self.num setText:[NSString stringWithFormat:@"数量：%@",_groupOperatingModel.goodsnum]];
    
    [_price setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"("] attributes:@{NSFontAttributeName:KFont(15),NSForegroundColorAttributeName:KUIColorFromHex(0x666666)}]];
    if ([self.type isEqual:@"single"]) {
        [_price appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_groupOperatingModel.singleprice] attributes:@{NSFontAttributeName:KFont(15),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    }else{
    [_price appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_groupOperatingModel.groupsprice] attributes:@{NSFontAttributeName:KFont(15),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    }
    [_price appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"/1件)"] attributes:@{NSFontAttributeName:KFont(15),NSForegroundColorAttributeName:KUIColorFromHex(0x666666)}]];
    
    
}
@end
