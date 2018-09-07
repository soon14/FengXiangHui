//
//  ArticleListTitleModel.m
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ArticleCategoryResultModel.h"

@implementation ArticleCategoryResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"categorys":[ArticleCategoryResultCategoryModel class]};
}

@end

@implementation ArticleCategoryResultArticleModel

@end

@implementation ArticleCategoryResultCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryID" : @"id"};
}

@end



