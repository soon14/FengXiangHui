//
//  HomepageSeventhItem.h
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageSeventhItem : UIView

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 秒杀价 */
@property(nonatomic , strong)UILabel *nowPriceLabel;
/** 原价 */
@property(nonatomic , strong)UILabel *originPriceLabel;

@end
