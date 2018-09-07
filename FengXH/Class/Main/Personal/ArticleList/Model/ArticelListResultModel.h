//
//  ArticelListResultModel.h
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticelListResultArticleModel,ArticelListResultArticlesModel;

@interface ArticelListResultModel : NSObject

/** article */
@property(nonatomic , strong)ArticelListResultArticleModel *article;
/** list */
@property(nonatomic , strong)ArticelListResultArticlesModel *articles;


@end


@interface ArticelListResultArticleModel : NSObject

/** uniacid */
@property(nonatomic , copy)NSString *uniacid;
/** article_message */
@property(nonatomic , copy)NSString *article_message;
/** article_title */
@property(nonatomic , copy)NSString *article_title;
/** article_image */
@property(nonatomic , copy)NSString *article_image;
/** article_shownum */
@property(nonatomic , copy)NSString *article_shownum;
/** article_keyword */
@property(nonatomic , copy)NSString *article_keyword;
/** article_temp */
@property(nonatomic , copy)NSString *article_temp;
/** article_source */
@property(nonatomic , copy)NSString *article_source;

@end

@interface ArticelListResultArticlesModel : NSObject

/** list */
@property(nonatomic , strong)NSArray *list;
/** total */
@property(nonatomic , assign)NSInteger total;
/** psize */
@property(nonatomic , assign)NSInteger psize;

@end


@interface ArticelListResultArticlesListModel : NSObject

/** articleID */
@property(nonatomic , copy)NSString *articleID;
/** article_title */
@property(nonatomic , copy)NSString *article_title;
/** resp_img */
@property(nonatomic , copy)NSString *resp_img;
/** article_rule_credit */
@property(nonatomic , copy)NSString *article_rule_credit;
/** article_rule_money */
@property(nonatomic , copy)NSString *article_rule_money;
/** article_author */
@property(nonatomic , copy)NSString *article_author;
/** article_date_v */
@property(nonatomic , copy)NSString *article_date_v;
/** resp_desc */
@property(nonatomic , copy)NSString *resp_desc;
/** article_category */
@property(nonatomic , copy)NSString *article_category;
/** category_name */
@property(nonatomic , copy)NSString *category_name;

@end




