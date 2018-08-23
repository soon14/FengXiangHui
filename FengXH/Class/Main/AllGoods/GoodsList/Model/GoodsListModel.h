//
//  GoodsListModel.h
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListModel : NSObject

/** pagesize */
@property(nonatomic , copy)NSString *pagesize;
/** total */
@property(nonatomic , copy)NSString *total;
/** url */
@property(nonatomic , copy)NSString *url;
/** list */
@property(nonatomic , strong)NSArray *list;

@end


@interface GoodsListCommodityModel : NSObject

/** bargain */
@property(nonatomic , copy)NSString *bargain;
/** description */
@property(nonatomic , copy)NSString *goods_description;
/** hasoption */
@property(nonatomic , copy)NSString *hasoption;
/** id */
@property(nonatomic , copy)NSString *goodsID;
/** isdiscount */
@property(nonatomic , copy)NSString *isdiscount;
/** isdiscount_discounts */
@property(nonatomic , copy)NSString *isdiscount_discounts;
/** isdiscount_time */
@property(nonatomic , copy)NSString *isdiscount_time;
/** ispresell */
@property(nonatomic , copy)NSString *ispresell;
/** marketprice */
@property(nonatomic , copy)NSString *marketprice;
/** maxprice */
@property(nonatomic , copy)NSString *maxprice;
/** minprice */
@property(nonatomic , copy)NSString *minprice;
/** productprice */
@property(nonatomic , copy)NSString *productprice;
/** sales */
@property(nonatomic , copy)NSString *sales;
/** salesreal */
@property(nonatomic , copy)NSString *salesreal;
/** sku_jdid */
@property(nonatomic , copy)NSString *sku_jdid;
/** subtitle */
@property(nonatomic , copy)NSString *subtitle;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** title */
@property(nonatomic , copy)NSString *title;
/** total */
@property(nonatomic , copy)NSString *total;
/** type */
@property(nonatomic , copy)NSString *type;
/** xykj_id */
@property(nonatomic , copy)NSString *xykj_id;

@end




