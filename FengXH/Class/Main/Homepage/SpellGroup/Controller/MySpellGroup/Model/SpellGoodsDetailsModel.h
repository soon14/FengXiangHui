//
//  SpellGoodsDetailsModel.h
//  FengXH
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpellGoodsDetailsModel : NSObject
//id
@property(nonatomic , copy)NSString *categoryID;
//description
@property(nonatomic , copy)NSString *spell_description;
//goodsid
@property(nonatomic , copy)NSString *goodsid;
//goodsnum
@property(nonatomic , copy)NSString *goodsnum;
//groupnum
@property(nonatomic , copy)NSString *groupnum;
//groupsprice
@property(nonatomic , copy)NSString *groupsprice;
//price
@property(nonatomic , copy)NSString *price;
//sales
@property(nonatomic , copy)NSString *sales;
//singleprice
@property(nonatomic , copy)NSString *singleprice;
//teamnum
@property(nonatomic , copy)NSString *teamnum;
//units
@property(nonatomic , copy)NSString *units;
//title
@property(nonatomic , copy)NSString *title;
//freight 运费
@property(nonatomic , copy)NSString *freight;

@end
