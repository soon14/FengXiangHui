//
//  AllCategoryDataModel.m
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AllCategoryDataModel.h"

@implementation AllCategoryDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"result":[AllCategoryDataResultModel class]};
}

@end

@implementation AllCategoryDataResultModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryID" : @"id",
             @"category_description":@"description"
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"children":[AllCategoryDataChildrenModel class]};
}

@end


@implementation AllCategoryDataChildrenModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryChildrenID" : @"id",
             @"category_children_description":@"description",
             @"category_children_1708":@"1708"
             };
}

@end


@implementation AllCategoryDataChildren1708Model

@end
