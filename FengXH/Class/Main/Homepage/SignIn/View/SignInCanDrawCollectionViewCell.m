//
//  SignInCanDrawCollectionViewCell.m
//  FengXH
//
//  Created by sun on 2018/10/10.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInCanDrawCollectionViewCell.h"
#import "SignInResultModel.h"

@interface SignInCanDrawCollectionViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SignInCanDrawOrderCollectionViewCellDelegate>

/** collection */
@property(nonatomic , strong)UICollectionView *signCollectionView;

@end

@implementation SignInCanDrawCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = KUIColorFromHex(0xff2741);
        
        [self.contentView addSubview:self.signCollectionView];
        
    }
    return self;
}

- (void)setCanDrawArray:(NSArray *)canDrawArray {
    _canDrawArray = canDrawArray;
    [self.signCollectionView reloadData];
}


#pragma mark - collectionView
- (UICollectionView *)signCollectionView {
    if (!_signCollectionView) {
        UICollectionViewFlowLayout *_customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _signCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100) collectionViewLayout:_customLayout];
        _customLayout.minimumLineSpacing = 0;
        _customLayout.minimumInteritemSpacing = 0;
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _signCollectionView.backgroundColor = KUIColorFromHex(0xff2741);
        _signCollectionView.delegate = self;
        _signCollectionView.dataSource = self;
        _signCollectionView.showsHorizontalScrollIndicator = NO;
        [_signCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        [_signCollectionView registerClass:[SignInCanDrawOrderCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SignInCanDrawOrderCollectionViewCell class])];
    }
    return _signCollectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _canDrawArray.count;
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 110);
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.canDrawArray count] > 0) {
        SignInCanDrawOrderCollectionViewCell *orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SignInCanDrawOrderCollectionViewCell class]) forIndexPath:indexPath];
        orderCell.delegate = self;
        orderCell.canDrawOrderModel = self.canDrawArray[indexPath.item];
        return orderCell;
    }
    UICollectionViewCell *orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    return orderCell;
}

#pragma mark - delegate
- (void)SignInCanDrawOrderCollectionViewCell:(SignInCanDrawOrderCollectionViewCell *)cell signInDrawWith:(SignInResultAdvawardOrderModel *)orderModel {
    if (self.rewordBlock) {
        self.rewordBlock(orderModel.day);
    }
}

@end



@interface SignInCanDrawOrderCollectionViewCell ()

/** 天数 */
@property(nonatomic , strong)UILabel *dayLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *creditLabel;
/** 领取按钮 */
@property(nonatomic , strong)UIButton *drawButton;
/** 圆点 */
@property(nonatomic , strong)UIImageView *roundImageView;

@end

@implementation SignInCanDrawOrderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.contentView.backgroundColor = [UIColor orangeColor];
        
        [self.contentView addSubview:self.dayLabel];
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.height.mas_equalTo(20);
        }];
        
        UIView *whiteLine = [[UIView alloc] init];
        [whiteLine setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:whiteLine];
        [whiteLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dayLabel.mas_bottom).offset(8);
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(5);
        }];
        
        [self.contentView addSubview:self.roundImageView];
        [self.roundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(whiteLine.mas_centerY);
            make.width.height.mas_equalTo(14);
        }];
        
        [self.contentView addSubview:self.creditLabel];
        [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(whiteLine.mas_bottom).offset(8);
        }];
        
        [self.contentView addSubview:self.drawButton];
        [self.drawButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_creditLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(42);
            make.height.mas_equalTo(16);
        }];
    }
    return self;
}

- (void)setCanDrawOrderModel:(SignInResultAdvawardOrderModel *)canDrawOrderModel {
    _canDrawOrderModel = canDrawOrderModel;
    [self.dayLabel setText:[NSString stringWithFormat:@"%@天",_canDrawOrderModel.day]];
    [self.creditLabel setText:[NSString stringWithFormat:@"+%ld\n积分",(long)_canDrawOrderModel.credit]];
    //连续签到奖励领取
    if (_canDrawOrderModel.candraw) {
        [self.drawButton setHidden:NO];
        if (_canDrawOrderModel.drawed) {
            [self.drawButton setBackgroundColor:KUIColorFromHex(0xFC5075)];
            [self.drawButton setTitle:@"已领取" forState:UIControlStateNormal];
            [self.drawButton setTitleColor:KUIColorFromHex(0xff2741) forState:UIControlStateNormal];
        } else {
            [self.drawButton setBackgroundColor:[UIColor whiteColor]];
            [self.drawButton setTitle:@"领取" forState:UIControlStateNormal];
            [self.drawButton setTitleColor:KUIColorFromHex(0xff2741) forState:UIControlStateNormal];
        }
    } else {
        [self.drawButton setHidden:YES];
    }
    
    if (_canDrawOrderModel.drawed) {
        [self.roundImageView setImage:[UIImage imageNamed:@"signInDraw"]];
    } else {
        [self.roundImageView setImage:[UIImage imageNamed:@"signInCanDraw"]];
    }
}

#pragma mark - 领取连续签到奖励
- (void)drawButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(SignInCanDrawOrderCollectionViewCell:signInDrawWith:)]) {
        [self.delegate SignInCanDrawOrderCollectionViewCell:self signInDrawWith:self.canDrawOrderModel];
    }
}

#pragma mark - lazy
- (UIImageView *)roundImageView {
    if (!_roundImageView) {
        _roundImageView = [[UIImageView alloc] init];
    }
    return _roundImageView;
}

- (UIButton *)drawButton {
    if (!_drawButton) {
        _drawButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_drawButton.titleLabel setFont:KFont(12)];
        [_drawButton.layer setMasksToBounds:YES];
        [_drawButton.layer setCornerRadius:8];
        [_drawButton addTarget:self action:@selector(drawButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawButton;
}

- (UILabel *)creditLabel {
    if (!_creditLabel) {
        _creditLabel = [[UILabel alloc] init];
        [_creditLabel setTextColor:[UIColor whiteColor]];
        [_creditLabel setFont:KFont(12)];
        [_creditLabel setTextAlignment:NSTextAlignmentCenter];
        [_creditLabel setNumberOfLines:2];
        [_creditLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _creditLabel;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        [_dayLabel setTextColor:[UIColor whiteColor]];
        [_dayLabel setFont:KFont(12)];
    }
    return _dayLabel;
}

@end
