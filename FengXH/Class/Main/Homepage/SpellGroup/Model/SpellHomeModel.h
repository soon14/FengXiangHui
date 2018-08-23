//
//  SpellHomeModel.h
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpellHomeModel : NSObject
//id
@property(nonatomic , copy)NSString *categoryID;
//thumb
@property(nonatomic , copy)NSString *thumb;
//title
@property(nonatomic , copy)NSString *title;
//price
@property(nonatomic , copy)NSString *price;
//groupsprice
@property(nonatomic , copy)NSString *groupsprice;
//goodsnum
@property(nonatomic , copy)NSString *goodsnum;
//groupnum
@property(nonatomic , copy)NSString *groupnum;
//units
@property(nonatomic , copy)NSString *units;
//description
@property(nonatomic , copy)NSString *spell_description;

@end
