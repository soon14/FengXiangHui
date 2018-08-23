//
//  AllCategoryDataModel.h
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AllCategoryDataChildrenModel,AllCategoryDataChildren1708Model;

@interface AllCategoryDataModel : NSObject

/** result */
@property(nonatomic , strong)NSArray *result;

@end


@interface AllCategoryDataResultModel : NSObject

/** id */
@property(nonatomic , copy)NSString *categoryID;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;
/** name */
@property(nonatomic , copy)NSString *name;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** parentid */
@property(nonatomic , copy)NSString *parentid;
/** isrecommand */
@property(nonatomic , copy)NSString *isrecommand;
/** description */
@property(nonatomic , copy)NSString *category_description;
/** displayorder */
@property(nonatomic , copy)NSString *displayorder;
/** enabled */
@property(nonatomic , copy)NSString *enabled;
/** ishome */
@property(nonatomic , copy)NSString *ishome;
/** advimg */
@property(nonatomic , copy)NSString *advimg;
/** advurl */
@property(nonatomic , copy)NSString *advurl;
/** level */
@property(nonatomic , copy)NSString *level;
/** children */
@property(nonatomic , strong)NSArray *children;
/** title */
@property(nonatomic , copy)NSString *title;
@end



@interface AllCategoryDataChildrenModel : NSObject

/** id */
@property(nonatomic , copy)NSString *categoryChildrenID;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;
/** name */
@property(nonatomic , copy)NSString *name;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** parentid */
@property(nonatomic , copy)NSString *parentid;
/** isrecommand */
@property(nonatomic , copy)NSString *isrecommand;
/** description */
@property(nonatomic , copy)NSString *category_children_description;
/** displayorder */
@property(nonatomic , copy)NSString *displayorder;
/** enabled */
@property(nonatomic , copy)NSString *enabled;
/** ishome */
@property(nonatomic , copy)NSString *ishome;
/** advimg */
@property(nonatomic , copy)NSString *advimg;
/** advurl */
@property(nonatomic , copy)NSString *advurl;
/** level */
@property(nonatomic , copy)NSString *level;
/** 1708 */
@property(nonatomic , strong)AllCategoryDataChildren1708Model *category_children_1708;

@end



@interface AllCategoryDataChildren1708Model : NSObject

/** level */
@property(nonatomic , copy)NSString *level;

@end





