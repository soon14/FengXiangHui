//
//  MyFocusResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFocusResultModel : NSObject

/** list */
@property(nonatomic , strong)NSArray *list;

@end



@interface MyFocusResultListModel : NSObject

/** 选择状态 */
@property(nonatomic , assign)BOOL selected;
/** focusID */
@property(nonatomic , copy)NSString *focusID;
/** goodsid */
@property(nonatomic , copy)NSString *goodsid;
/** title */
@property(nonatomic , copy)NSString *title;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** 现价 */
@property(nonatomic , copy)NSString *marketprice;
/** 原价 */
@property(nonatomic , copy)NSString *productprice;
/** merchid */
@property(nonatomic , copy)NSString *merchid;
/** 商店名 */
@property(nonatomic , copy)NSString *merchname;


@end
