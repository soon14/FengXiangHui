//
//  HomepageNinthItem.h
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NinthItemBlock)(NSInteger index);
typedef void (^NinthItemCartBlock)(NSInteger index);

@interface HomepageNinthItem : UIView

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名称 */
@property(nonatomic , strong)UILabel *goodsTitleLabel;
/** 现价 */
@property(nonatomic , strong)UILabel *nowPriceLabel;
/** 原价 */
@property(nonatomic , strong)UILabel *originPriceLabel;
/** 购物车按钮 */
@property(nonatomic , strong)UIButton *cartButton;
/** block */
@property(nonatomic , strong)NinthItemBlock ninthItemBlock;
/** 购物车点击 block */
@property(nonatomic , strong)NinthItemCartBlock ninthItemCartBlock;

@end
