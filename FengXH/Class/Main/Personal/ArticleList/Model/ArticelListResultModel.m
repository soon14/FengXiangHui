//
//  ArticelListResultModel.m
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ArticelListResultModel.h"

@implementation ArticelListResultModel

@end

@implementation ArticelListResultArticleModel

@end

@implementation ArticelListResultArticlesModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[ArticelListResultArticlesListModel class]};
}

@end

@implementation ArticelListResultArticlesListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"articleID" : @"id"};
}

@end


