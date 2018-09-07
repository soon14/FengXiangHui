//
//  ArticleListTitleModel.h
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticleCategoryResultArticleModel;

@interface ArticleCategoryResultModel : NSObject

/** 主题 */
@property(nonatomic , strong)ArticleCategoryResultArticleModel *article;
/** 标题 */
@property(nonatomic , strong)NSArray *categorys;

@end



@interface ArticleCategoryResultArticleModel : NSObject

/** article_image */
@property(nonatomic , copy)NSString *article_image;
/** article_keyword */
@property(nonatomic , copy)NSString *article_keyword;
/** article_message */
@property(nonatomic , copy)NSString *article_message;
/** article_shownum */
@property(nonatomic , copy)NSString *article_shownum;
/** article_source */
@property(nonatomic , copy)NSString *article_source;
/** article_temp */
@property(nonatomic , copy)NSString *article_temp;
/** article_title */
@property(nonatomic , copy)NSString *article_title;
/** banner */
@property(nonatomic , copy)NSString *banner;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;

@end


@interface ArticleCategoryResultCategoryModel : NSObject

/** category_name */
@property(nonatomic , copy)NSString *category_name;
/** displayorder */
@property(nonatomic , copy)NSString *displayorder;
/** id */
@property(nonatomic , copy)NSString *categoryID;
/** isshow */
@property(nonatomic , copy)NSString *isshow;
/** merchid */
@property(nonatomic , copy)NSString *merchid;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;

@end
