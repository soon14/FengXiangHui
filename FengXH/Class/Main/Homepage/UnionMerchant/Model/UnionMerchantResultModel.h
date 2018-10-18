//
//  UnionMerchantResultModel.h
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnionMerchantResultModel : NSObject

/** items */
@property(nonatomic , strong)NSArray *items;

@end


@interface UnionMerchantResultItemsModel : NSObject

/** itemsID */
@property(nonatomic , copy)NSString *itemsID;
/** items */
@property(nonatomic , strong)NSArray *items;

@end


@interface UnionMerchantResultItemsItemsModel : NSObject

/** 商户名 */
@property(nonatomic , copy)NSString *name;
/** 商户 id */
@property(nonatomic , copy)NSString *merchid;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** title */
@property(nonatomic , copy)NSString *title;
/** subtitle */
@property(nonatomic , copy)NSString *subtitle;
/** price */
@property(nonatomic , copy)NSString *price;
/** gid */
@property(nonatomic , copy)NSString *gid;
/** total */
@property(nonatomic , copy)NSString *total;
/** type */
@property(nonatomic , copy)NSString *type;
/** desc */
@property(nonatomic , copy)NSString *desc;

@end

NS_ASSUME_NONNULL_END
