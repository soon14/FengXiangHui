//
//  HomepageLikeHeaderView.m
//  FengXH
//
//  Created by sun on 2018/10/11.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "HomePageLikeHeaderView.h"
#import "HomepageResultModel.h"

@interface HomePageLikeHeaderView ()

/** imageV */
@property(nonatomic , strong)UIImageView *pictureImageView;

@end

@implementation HomePageLikeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.pictureImageView];
        [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setPictureModel:(HomepageResultPictureModel *)pictureModel {
    _pictureModel = pictureModel;
    [self.pictureImageView setYy_imageURL:[NSURL URLWithString:_pictureModel.imgurl]];
}

#pragma mark 懒加载
- (UIImageView *)pictureImageView {
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
        [_pictureImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _pictureImageView;
}

@end
