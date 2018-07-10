//
//  HomepageNinthCell.h
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NinthCellBlock)(NSInteger index);

@interface HomepageNinthView : UIView

@property(strong,nonatomic) UIScrollView * direct;

+ (instancetype)direcWithtFrame:(CGRect)frame
                 GoodsInfoArray:(NSArray *)goodsInfoArray
                     NinthBlock:(NinthCellBlock)ninthBlock
                 CartClickBlock:(NinthCellBlock)cartBlock;

@end
