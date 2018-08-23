//
//  MyFootprintResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFootprintResultModel : NSObject

/** list */
@property(nonatomic , strong)NSArray *list;

@end



@interface MyFootprintResultListModel : NSObject

/** 是否被选择 */
@property(nonatomic , assign)BOOL selected;
/** id */
@property(nonatomic , copy)NSString *footprintID;
/** 商品 id */
@property(nonatomic , copy)NSString *goodsid;
/** title */
@property(nonatomic , copy)NSString *title;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** 现价 */
@property(nonatomic , copy)NSString *marketprice;
/** 原价 */
@property(nonatomic , copy)NSString *productprice;
/** 时间 */
@property(nonatomic , copy)NSString *createtime;
/** 店家 id */
@property(nonatomic , copy)NSString *merchid;
/** 店铺名称 */
@property(nonatomic , copy)NSString *merchname;

@end
