//
//  HomepageFifthCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageFifthCell.h"

@implementation HomepageFifthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemWith = KMAINSIZE.width/3;
        
        [self.contentView addSubview:self.leftItem];
        [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWith);
        }];
        
        [self.contentView addSubview:self.middleItem];
        [self.middleItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(itemWith);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(itemWith);
        }];
        
        [self.contentView addSubview:self.rightItem];
        [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_offset(0);
            make.width.mas_equalTo(itemWith);
        }];
        
    }
    return self;
}

- (void)setPicturewModel:(HomepageDataPicturewModel *)picturewModel {
    _picturewModel = picturewModel;
    if (_picturewModel.data.count>0) {
        HomepageDataPicturewDataModel *picterewModel = _picturewModel.data[0];
        [self.leftItem setYy_imageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picterewModel.imgurl]]];
    }
    if (_picturewModel.data.count>1) {
        HomepageDataPicturewDataModel *picterewModel = _picturewModel.data[1];
        [self.middleItem setYy_imageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picterewModel.imgurl]]];
    }
    if (_picturewModel.data.count>2) {
        HomepageDataPicturewDataModel *picterewModel = _picturewModel.data[2];
        [self.rightItem setYy_imageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picterewModel.imgurl]]];
    }
    
}

#pragma mark - 图片被点击
- (void)imageClickAction:(UITapGestureRecognizer *)sender {
    if (self.fifthCellBlock) {
        self.fifthCellBlock(sender.view.tag);
    }
}

#pragma mark - lazy
- (UIImageView *)rightItem {
    if (!_rightItem) {
        _rightItem = [[UIImageView alloc] init];
        [_rightItem setContentMode:UIViewContentModeScaleAspectFill];
        [_rightItem setUserInteractionEnabled:YES];
        [_rightItem setTag:2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)];
        [_rightItem addGestureRecognizer:tap];
    }
    return _rightItem;
}

- (UIImageView *)middleItem {
    if (!_middleItem) {
        _middleItem = [[UIImageView alloc] init];
        [_middleItem setContentMode:UIViewContentModeScaleAspectFill];
        [_middleItem setUserInteractionEnabled:YES];
        [_middleItem setTag:1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)];
        [_middleItem addGestureRecognizer:tap];
    }
    return _middleItem;
}

- (UIImageView *)leftItem {
    if (!_leftItem) {
        _leftItem = [[UIImageView alloc] init];
        [_leftItem setContentMode:UIViewContentModeScaleAspectFill];
        [_leftItem setUserInteractionEnabled:YES];
        [_leftItem setTag:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)];
        [_leftItem addGestureRecognizer:tap];
    }
    return _leftItem;
}


@end
