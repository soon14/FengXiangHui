//
//  SpellHomeModel.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellHomeModel.h"

@implementation SpellHomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryID" : @"id",@"spell_description":@"description"};
}
@end
