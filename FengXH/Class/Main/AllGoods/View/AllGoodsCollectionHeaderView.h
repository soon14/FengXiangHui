//
//  AllGoodsCollectionHeaderView.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AllGoodsHeaderClickBlock)(NSInteger index);

@interface AllGoodsCollectionHeaderView : UICollectionReusableView

/** imageURL */
@property(nonatomic , copy)NSString *imageURLString;
/** block */
@property(nonatomic , strong)AllGoodsHeaderClickBlock clickBlock;

@end
