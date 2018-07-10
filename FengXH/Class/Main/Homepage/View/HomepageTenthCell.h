//
//  HomepageTenthCell.h
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageTenthCell : UICollectionViewCell

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

@end
