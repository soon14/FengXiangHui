//
//  SpellMyTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellMyTableViewCell.h"
#import "M80AttributedLabel.h"
#import "MyGroupModel.h"
@interface SpellMyTableViewCell()
@property (nonatomic ,strong) UILabel *order;
@property (nonatomic ,strong) UILabel *groststus;
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UIView *line;
@property (nonatomic ,strong) UIImageView *thumb;
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) M80AttributedLabel *price;
@property (nonatomic ,strong) UILabel *goodsNum;
@property (nonatomic ,strong) M80AttributedLabel *amount;
@property (nonatomic ,strong) UIButton *again;
@property (nonatomic ,strong) UIButton *details;
@property (nonatomic ,strong) UIImageView *arrow;
@property (nonatomic ,strong) UIImageView *arrow1;
@property (nonatomic ,strong) UIImageView *failure;
@property(nonatomic , assign)NSInteger spellType;
@end
@implementation SpellMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.order];
        [self.order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_offset(15);
            make.height.mas_equalTo(15);
        }];
        [self addSubview:self.groststus];
        [self.groststus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.groststus.mas_bottom).offset(10);
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(95);
        }];
        [self addSubview:self.thumb];
        [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backView).offset(5);
            make.left.mas_equalTo(self.backView).offset(10);
            make.bottom.mas_equalTo(self.backView).offset(-5);
            make.width.mas_equalTo(85*KScreenRatio);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backView).offset(5);
            make.left.mas_equalTo(self.thumb.mas_right).offset(10);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(100*KScreenRatio);
        }];
        [self addSubview:self.failure];
        [self.failure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backView).offset(10);
            make.left.mas_equalTo(self.title.mas_right).offset(5);
            make.bottom.mas_equalTo(self.backView).offset(-10);
            make.width.mas_equalTo(70*KScreenRatio);
        }];
        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backView).offset(25);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.backView).offset(-10);
            
        }];
        [self addSubview:self.goodsNum];
        [self.goodsNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.price.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.backView).offset(-10);
            
        }];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_offset(-50);
            
        }];
        [self addSubview:self.arrow];
        [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.backView.mas_bottom).offset(15);
            make.bottom.mas_equalTo(self.line.mas_top).offset(-15);
            
        }];
        [self addSubview:self.arrow1];
        [self.arrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.line.mas_bottom).offset(18);
            make.bottom.mas_offset(-18);
        }];
        [self addSubview:self.amount];
        [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrow.mas_left).offset(-10);
            make.top.mas_equalTo(self.backView.mas_bottom).offset(15);
            make.bottom.mas_equalTo(self.line.mas_top).offset(-10);
        }];
        [self addSubview:self.details];
        [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrow1.mas_left).offset(-10);
            make.top.mas_equalTo(self.line.mas_bottom).offset(10);
            make.bottom.mas_offset(-10);
            make.width.mas_equalTo(95*KScreenRatio);
        }];
        [self addSubview:self.again];
        [self.again mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.details.mas_left).offset(-10);
            make.top.mas_equalTo(self.line.mas_bottom).offset(10);
            make.bottom.mas_offset(-10);
            make.width.mas_equalTo(80*KScreenRatio);
        }];
        
    }
    return self;
}
- (UILabel *)order{
    if (!_order) {
        _order = [[UILabel alloc]init];
        _order.textAlignment = NSTextAlignmentLeft;
        _order.font = KFont(10);
        _order.textColor = KUIColorFromHex(0x757575);
    }
    return _order;
}
- (UILabel *)groststus{
    if (!_groststus) {
        _groststus = [[UILabel alloc]init];
        _groststus.textAlignment = NSTextAlignmentRight;
        _groststus.font = KFont(14);
        _groststus.textColor = KUIColorFromHex(0xec6258);
    }
    return _groststus;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = KUIColorFromHex(0xf2f2f2);
    }
    return _backView;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
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
        [_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.f]];
        _title.textColor = [UIColor blackColor];
        _title.numberOfLines = 0;
    }
    return _title;
}
- (M80AttributedLabel *)price{
    if (!_price) {
        _price = [[M80AttributedLabel alloc]init];
        _price.textAlignment = kCTTextAlignmentRight;
        _price.backgroundColor = KUIColorFromHex(0xf2f2f2);
    }
    return _price;
}
- (UILabel *)goodsNum{
    if (!_goodsNum) {
        _goodsNum = [[UILabel alloc]init];
        _goodsNum.textAlignment = NSTextAlignmentRight;
        _goodsNum.textColor = KUIColorFromHex(0x757575);
    }
    return _goodsNum;
}
- (M80AttributedLabel *)amount{
    if (!_amount) {
        _amount = [[M80AttributedLabel alloc]init];
        _amount.textAlignment = kCTTextAlignmentRight;
    }
    return _amount;
}
- (UIButton *)again{
    if (!_again) {
        _again = [[UIButton alloc]init];
        _again.titleLabel.font = KFont(14);
        [_again setTitle:@"再拼一单" forState:UIControlStateNormal];
        [_again setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_again setBackgroundColor:KUIColorFromHex(0xec6258)];
        [_again addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _again.layer.cornerRadius = 5;
        _again.tag = 50;
    }
    return _again;
}
- (UIButton *)details{
    if (!_details) {
        _details = [[UIButton alloc]init];
        [_details setTitle:@"查看团详情" forState:UIControlStateNormal];
        _details.titleLabel.font = KFont(14);
        [_details setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_details setBackgroundColor:KUIColorFromHex(0xec6258)];
        [_details addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _details.layer.cornerRadius = 5;
        _again.tag = 51;
    }
    return _details;
}
- (UIImageView *)failure{
    if (!_failure) {
        _failure = [[UIImageView alloc]init];
        [_failure setImage:[UIImage imageNamed:@"组团失败"]];
    }
    return _failure;
}
- (UIImageView *)arrow{
    if (!_arrow) {
        _arrow = [[UIImageView alloc]init];
        [_arrow setImage:[UIImage imageNamed:@"home_icon_arrow"]];
    }
    return _arrow;
}
- (UIImageView *)arrow1{
    if (!_arrow1) {
        _arrow1 = [[UIImageView alloc]init];
        [_arrow1 setImage:[UIImage imageNamed:@"home_icon_arrow"]];
    }
    return _arrow1;
}
- (void)cartButtonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onItemClick:)]) {
        [self.delegate onItemClick:sender];
    }
}
- (void)setMyGroupModel:(MyGroupModel *)myGroupModel{
    _myGroupModel = myGroupModel;
    [self.order setText:[NSString stringWithFormat:@"订单号：%@",_myGroupModel.orderno]];
    [self.groststus setText:[NSString stringWithFormat:@"%@",_myGroupModel.groststus]];
    [self.thumb setYy_imageURL:[NSURL URLWithString:_myGroupModel.thumb]];
    [self.title setText:[NSString stringWithFormat:@"%@",_myGroupModel.title]];
    
    [_price setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_myGroupModel.groupsprice] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_price appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"/%@%@",_myGroupModel.goodsnum,_myGroupModel.units] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [self.goodsNum setText:[NSString stringWithFormat:@"x%@",_myGroupModel.goodsnum]];
    
    [_amount setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"运费"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_amount appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_myGroupModel.freight] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_amount appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"元，共"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_amount appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_myGroupModel.goodsnum] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_amount appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"个商品 总额"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_amount appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_myGroupModel.groupsprice] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_amount appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"元"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    
    
    
}
- (void)setType:(NSInteger)type{
    _spellType = type;
    if (_spellType == -1) {
        _failure.hidden = NO;
        _again.hidden = NO;
    }else if (_spellType == 0){
        _failure.hidden = YES;
        _again.hidden = YES;
    }
    else{
        _failure.hidden = YES;
        _again.hidden = NO;
    }
}
@end
