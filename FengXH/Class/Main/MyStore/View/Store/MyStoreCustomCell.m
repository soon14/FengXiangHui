//
//  MyStoreCustomCell.m
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyStoreCustomCell.h"
#import "MyStoreCustomCellItem.h"
#import "MyStoreResultModel.h"

@interface MyStoreCustomCell ()

/** 店主佣金 */
@property(nonatomic , strong)MyStoreCustomCellItem *shopCommisionItem;
/** 佣金明细 */
@property(nonatomic , strong)MyStoreCustomCellItem *commisionDetailItem;
/** 提现明细 */
@property(nonatomic , strong)MyStoreCustomCellItem *withdrawDetailItem;
/** 我的团队 */
@property(nonatomic , strong)MyStoreCustomCellItem *myTeamItem;
/** 推广海报 */
@property(nonatomic , strong)MyStoreCustomCellItem *posterItem;
/** 城市合伙人 */
@property(nonatomic , strong)MyStoreCustomCellItem *cityParterItem;
/** 股东分红 */
@property(nonatomic , strong)MyStoreCustomCellItem *dividendItem;

@end

@implementation MyStoreCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWidth = (KMAINSIZE.width/3);
        
        [self.contentView addSubview:self.shopCommisionItem];
        [self.shopCommisionItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(0);
            make.width.height.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.commisionDetailItem];
        [self.commisionDetailItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(itemWidth);
            make.width.height.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.withdrawDetailItem];
        [self.withdrawDetailItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_offset(0);
            make.width.height.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.myTeamItem];
        [self.myTeamItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_offset(itemWidth);
            make.width.height.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.posterItem];
        [self.posterItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(itemWidth);
            make.width.height.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.cityParterItem];
        [self.cityParterItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(itemWidth);
            make.right.mas_offset(0);
            make.width.height.mas_equalTo(itemWidth);
        }];
        
        [self.contentView addSubview:self.dividendItem];
        [self.dividendItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_equalTo(_myTeamItem.mas_bottom);
            make.width.height.mas_equalTo(itemWidth);
        }];
    }
    return self;
}

#pragma mark - action
- (void)itemClickAction:(UITapGestureRecognizer *)sender {
    if (self.itemClickBlock) {
        self.itemClickBlock(sender.view.tag);
    }
}

- (void)setResultModel:(MyStoreResultModel *)resultModel {
    _resultModel = resultModel;
    NSMutableAttributedString *attributedString_1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",_resultModel.withdraw]];
    [attributedString_1 addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, _resultModel.withdraw.length)];
    [self.shopCommisionItem.detailLabel setAttributedText:attributedString_1];
    
    NSMutableAttributedString *attributedString_2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@笔",_resultModel.order]];
    [attributedString_2 addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, _resultModel.order.length)];
    [self.shopCommisionItem.detailLabel setAttributedText:attributedString_2];
    
    NSMutableAttributedString *attributedString_3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@笔",_resultModel.log]];
    [attributedString_3 addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, _resultModel.log.length)];
    [self.shopCommisionItem.detailLabel setAttributedText:attributedString_3];
    
    NSMutableAttributedString *attributedString_4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人",_resultModel.down]];
    [attributedString_4 addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, _resultModel.down.length)];
    [self.shopCommisionItem.detailLabel setAttributedText:attributedString_4];
}

#pragma mark - lazy
- (MyStoreCustomCellItem *)dividendItem {
    if (!_dividendItem) {
        _dividendItem = [[MyStoreCustomCellItem alloc] init];
        [_dividendItem.icon setImage:[UIImage imageNamed:@"dividend"]];
        [_dividendItem.titleLabel setText:@"股东分红"];
        [_dividendItem setTag:6];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_dividendItem addGestureRecognizer:tap];
    }
    return _dividendItem;
}

- (MyStoreCustomCellItem *)cityParterItem {
    if (!_cityParterItem) {
        _cityParterItem = [[MyStoreCustomCellItem alloc] init];
        [_cityParterItem.icon setImage:[UIImage imageNamed:@"cityPartner"]];
        [_cityParterItem.titleLabel setText:@"城市合伙人"];
        [_cityParterItem setTag:5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_cityParterItem addGestureRecognizer:tap];
    }
    return _cityParterItem;
}

- (MyStoreCustomCellItem *)posterItem {
    if (!_posterItem) {
        _posterItem = [[MyStoreCustomCellItem alloc] init];
        [_posterItem.icon setImage:[UIImage imageNamed:@"poster"]];
        [_posterItem.titleLabel setText:@"推广海报"];
        [_posterItem setTag:4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_posterItem addGestureRecognizer:tap];
    }
    return _posterItem;
}

- (MyStoreCustomCellItem *)myTeamItem {
    if (!_myTeamItem) {
        _myTeamItem = [[MyStoreCustomCellItem alloc] init];
        [_myTeamItem.icon setImage:[UIImage imageNamed:@"myTeam"]];
        [_myTeamItem.titleLabel setText:@"我的团队"];
        [_myTeamItem setTag:3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_myTeamItem addGestureRecognizer:tap];
    }
    return _myTeamItem;
}

- (MyStoreCustomCellItem *)withdrawDetailItem {
    if (!_withdrawDetailItem) {
        _withdrawDetailItem = [[MyStoreCustomCellItem alloc] init];
        [_withdrawDetailItem.icon setImage:[UIImage imageNamed:@"withdrawDetails"]];
        [_withdrawDetailItem.titleLabel setText:@"提现明细"];
        [_withdrawDetailItem setTag:2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_withdrawDetailItem addGestureRecognizer:tap];
    }
    return _withdrawDetailItem;
}

- (MyStoreCustomCellItem *)commisionDetailItem {
    if (!_commisionDetailItem) {
        _commisionDetailItem = [[MyStoreCustomCellItem alloc] init];
        [_commisionDetailItem.icon setImage:[UIImage imageNamed:@"commissionDetails"]];
        [_commisionDetailItem.titleLabel setText:@"佣金明细"];
        [_commisionDetailItem setTag:1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_commisionDetailItem addGestureRecognizer:tap];
    }
    return _commisionDetailItem;
}

- (MyStoreCustomCellItem *)shopCommisionItem {
    if (!_shopCommisionItem) {
        _shopCommisionItem = [[MyStoreCustomCellItem alloc] init];
        [_shopCommisionItem.icon setImage:[UIImage imageNamed:@"shopCommission"]];
        [_shopCommisionItem.titleLabel setText:@"店主佣金"];
        [_shopCommisionItem setTag:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [_shopCommisionItem addGestureRecognizer:tap];
    }
    return _shopCommisionItem;
}

@end
