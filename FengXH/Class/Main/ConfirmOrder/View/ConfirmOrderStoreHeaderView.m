//
//  ConfirmOrderStoreHeaderView.m
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderStoreHeaderView.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderStoreHeaderView ()

/** storeName */
@property(nonatomic , strong)UILabel *storeNameLabel;

@end

@implementation ConfirmOrderStoreHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *storeImageView = [[UIImageView alloc] init];
        [storeImageView setImage:[UIImage imageNamed:@"personal_wodexiaodian"]];
        [storeImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:storeImageView];
        [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(16);
        }];
        
        [self.contentView addSubview:self.storeNameLabel];
        [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(storeImageView.mas_right).offset(8);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setStoreModel:(ConfirmOrderCreatResultGoodsListModel *)storeModel {
    _storeModel = storeModel;
    [self.storeNameLabel setText:_storeModel.shopname];
}


#pragma mark - lazy
- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc] init];
        [_storeNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_storeNameLabel setFont:KFont(15)];
    }
    return _storeNameLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
