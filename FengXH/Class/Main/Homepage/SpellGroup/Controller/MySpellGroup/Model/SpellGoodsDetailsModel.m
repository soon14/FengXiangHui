//
//  SpellGoodsDetailsModel.m
//  FengXH
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellGoodsDetailsModel.h"

@implementation SpellGoodsDetailsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryID" : @"id",@"spell_description":@"description"};
}
@end
