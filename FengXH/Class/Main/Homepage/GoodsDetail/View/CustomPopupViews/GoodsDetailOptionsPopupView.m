//
//  GoodsDetailCartPopupView.m
//  FengXH
//
//  Created by sun on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailOptionsPopupView.h"
#import "GoodsDetailResultModel.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "GoodsDetailOptionsHeaderView.h"
#import "GoodsDetailOptionsSelectCell.h"
#import "GoodsDetailOptionsIDNumberCell.h"
#import "GoodsDetailOptionsNumberCell.h"

@interface GoodsDetailOptionsPopupView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** 商品图 */
@property(nonatomic , strong)UIImageView *goodsIcon;
/** 商品编号 */
@property(nonatomic , strong)UILabel *goodssnLabel;
/** 商品价格 */
@property(nonatomic , strong)UILabel *goodsPriceLabel;
/** 收起按钮 */
@property(nonatomic , strong)UIButton *backButton;
/** 确定按钮 */
@property(nonatomic , strong)UIButton *confirmButton;
/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;
/** 身份证输入框 */
@property(nonatomic , strong)UITextField *IDTextField;
/** 商品数量输入框 */
@property(nonatomic , strong)UITextField *goodsNumTextField;

@end

@implementation GoodsDetailOptionsPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        self.contentHeight = 500 + KBottomHeight;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.goodsIcon];
        [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(20);
            make.width.height.mas_equalTo(100);
        }];
        
        [self.contentView addSubview:self.goodssnLabel];
        [self.goodssnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_goodsIcon.mas_bottom);
            make.left.mas_equalTo(_goodsIcon.mas_right).offset(20);
            make.height.mas_equalTo(15);
        }];
        
        [self.contentView addSubview:self.goodsPriceLabel];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsIcon.mas_right).offset(20);
            make.bottom.mas_equalTo(_goodssnLabel.mas_top).offset(-10);
        }];
        
        [self.contentView addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-15);
            make.width.height.mas_equalTo(25);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(_goodsIcon.mas_bottom).offset(19.5);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.contentView addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(45+KBottomHeight);
        }];
        
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)setGoodsDetailResultModel:(GoodsDetailResultModel *)goodsDetailResultModel {
    _goodsDetailResultModel = goodsDetailResultModel;
    [self.goodsIcon setYy_imageURL:[NSURL URLWithString:_goodsDetailResultModel.thumb]];
    if (_goodsDetailResultModel.goodssn && _goodsDetailResultModel.goodssn.length > 0) {
        [self.goodssnLabel setText:[NSString stringWithFormat:@"商品编号：%@",_goodsDetailResultModel.goodssn]];
    }
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"¥%.2lf",[_goodsDetailResultModel.marketprice floatValue]]];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *leftLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 140, KMAINSIZE.width, 360-(45+KBottomHeight)) collectionViewLayout:leftLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[GoodsDetailOptionsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([GoodsDetailOptionsHeaderView class])];
        [_collectionView registerClass:[GoodsDetailOptionsSelectCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsDetailOptionsSelectCell class])];
        [_collectionView registerClass:[GoodsDetailOptionsIDNumberCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsDetailOptionsIDNumberCell class])];
        [_collectionView registerClass:[GoodsDetailOptionsNumberCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsDetailOptionsNumberCell class])];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: return self.goodsDetailResultModel.options.count; break;
        case 1:
        case 2:
        case 3: return 1; break;
        default: return 0; break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                return CGSizeMake(KMAINSIZE.width, 30);
            }
        } break;
        default:
            break;
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        switch (indexPath.section) {
            case 0: {
                if ([self.goodsDetailResultModel.options count] > 0) {
                    GoodsDetailOptionsHeaderView *RView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([GoodsDetailOptionsHeaderView class]) forIndexPath:indexPath];
                    return RView;
                }
            } break;
            default:
                break;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                GoodsDetailResultOptionsModel *optionsModel = self.goodsDetailResultModel.options[indexPath.item];
                return CGSizeMake([self calculateItemWidth:optionsModel.title]+20, 30);
            }
        } break;
        case 1: {
            if (self.goodsDetailResultModel.diyformid == 4) {
                return CGSizeMake(KMAINSIZE.width, 45);
            }
        } break;
        case 2: {
            return CGSizeMake(KMAINSIZE.width, 45);
        } break;
        case 3: {
            return CGSizeMake(KMAINSIZE.width, 30);
        } break;
        default: break;
    }
    return CGSizeMake(KMAINSIZE.width, 1);
}

//设置每组的cell的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                return UIEdgeInsetsMake(5, 20, 10, 20);
            }
        } break;
        default:
            break;
    }
    return UIEdgeInsetsZero;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                return 10;
            }
        } break;
        default: break;
    }
    return CGFLOAT_MIN;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                return 15;
            }
        } break;
        default:
            break;
    }
    return CGFLOAT_MIN;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                GoodsDetailOptionsSelectCell *selectCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsDetailOptionsSelectCell class]) forIndexPath:indexPath];
                return selectCell;
            }
        } break;
        case 1: {
            if (self.goodsDetailResultModel.diyformid == 4) {
                GoodsDetailOptionsIDNumberCell *IDCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsDetailOptionsIDNumberCell class]) forIndexPath:indexPath];
                return IDCell;
            }
        } break;
        case 2: {
            GoodsDetailOptionsNumberCell *numberCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsDetailOptionsNumberCell class]) forIndexPath:indexPath];
            return numberCell;
        } break;
        default:
            break;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                GoodsDetailResultOptionsModel *optionsModel = self.goodsDetailResultModel.options[indexPath.item];
                GoodsDetailOptionsSelectCell *selectCell = (GoodsDetailOptionsSelectCell *)cell;
                selectCell.optionsModel = optionsModel;
            }
        } break;
        case 1: {
            if (self.goodsDetailResultModel.diyformid == 4) {
                GoodsDetailOptionsIDNumberCell *IDCell = (GoodsDetailOptionsIDNumberCell *)cell;
                self.IDTextField = IDCell.IDTextField;
            }
        } break;
        case 2: {
            GoodsDetailOptionsNumberCell *numberCell = (GoodsDetailOptionsNumberCell *)cell;
            self.goodsNumTextField = numberCell.numTextField;
        }
            
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if ([self.goodsDetailResultModel.options count] > 0) {
                GoodsDetailResultOptionsModel *optionsModel = self.goodsDetailResultModel.options[indexPath.item];
                if (optionsModel.selected == NO) {
                    for (GoodsDetailResultOptionsModel *tempModel in self.goodsDetailResultModel.options) {
                        tempModel.selected = NO;
                    }
                    optionsModel.selected = !optionsModel.selected;
                    [self.goodsIcon setYy_imageURL:[NSURL URLWithString:optionsModel.thumb]];
                    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"¥%.2lf",[optionsModel.marketprice floatValue]]];
                    [self.collectionView reloadData];
                }
            }
        } break;
            
        default:
            break;
    }
}

#pragma mark - 计算文字宽度
- (CGFloat )calculateItemWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要指定高度*/ options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

#pragma mark - 收起
- (void)backButtonAction:(UIButton *)sender {
    [self removeView];
}

#pragma mark - 确定
- (void)confirmButtonAction:(UIButton *)sender {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
        NSMutableArray *selectOptionsArray = [NSMutableArray array];
        if ([self.goodsDetailResultModel.options count] > 0) {
            //如果有多规格必须选择一种规格
            for (GoodsDetailResultOptionsModel *tempModel in self.goodsDetailResultModel.options) {
                if (tempModel.selected == YES) {
                    [selectOptionsArray addObject:tempModel];
                    break;
                }
            }
            if ([selectOptionsArray count] < 1) {
                [DBHUD ShowInView:[UIApplication sharedApplication].keyWindow withTitle:@"请选择一种规格"];
                return;
            }
        }
        if (self.goodsDetailResultModel.diyformid == 4) {
            //购买商品要求输入身份证账号用于清关
            if (self.IDTextField.text.length != 18) {
                [DBHUD ShowInView:[UIApplication sharedApplication].keyWindow withTitle:@"请输入正确的身份证账号用于商品清关"];
                return;
            }
            [[NSUserDefaults standardUserDefaults] setObject:self.IDTextField.text forKey:KUserIDCardNumber];
        }
        GoodsDetailResultOptionsModel *selectedModel = [selectOptionsArray firstObject];
        if (self.optionsSelectedBlock) {
            self.optionsSelectedBlock(selectedModel, [[NSUserDefaults standardUserDefaults] objectForKey:KUserIDCardNumber], self.goodsNumTextField.text);
        }
        [self removeView];
    } else {
        [DBHUD ShowInView:[UIApplication sharedApplication].keyWindow withTitle:@"请先前往个人中心登录或注册"];
    }
    
}


#pragma mark - lazy
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundColor:KRedColor];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:KFont(14)];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        [_goodsPriceLabel setTextColor:KRedColor];
        [_goodsPriceLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }
    return _goodsPriceLabel;
}

- (UILabel *)goodssnLabel {
    if (!_goodssnLabel) {
        _goodssnLabel = [[UILabel alloc] init];
        [_goodssnLabel setTextColor:KUIColorFromHex(0x999999)];
        [_goodssnLabel setFont:KFont(12)];
    }
    return _goodssnLabel;
}

- (UIImageView *)goodsIcon {
    if (!_goodsIcon) {
        _goodsIcon = [[UIImageView alloc] init];
//        [_goodsIcon setBackgroundColor:KTableBackgroundColor];
    }
    return _goodsIcon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
