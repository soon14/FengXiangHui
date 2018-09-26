//
//  GoodsListViewController.h
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsListViewController : BaseViewController

/** 分类 ID */
@property(nonatomic , copy)NSString *categatoryId;
/** 搜索关键词 */
@property(nonatomic , copy)NSString *searchKeywords;

@end
