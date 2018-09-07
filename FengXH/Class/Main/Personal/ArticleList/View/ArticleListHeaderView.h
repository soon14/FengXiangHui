//
//  ArticleListHeaderView.h
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ArticleListTypeButtonBlock)(NSInteger index);

@interface ArticleListHeaderView : UIView

/** 全部 */
@property(nonatomic , strong)UIButton *allButton;
/** 福利 */
@property(nonatomic , strong)UIButton *welfareButton;
/** 口碑 */
@property(nonatomic , strong)UIButton *mouthButton;
/** 好物 */
@property(nonatomic , strong)UIButton *goodButton;
/** 资讯 */
@property(nonatomic , strong)UIButton *newsButton;
/** 移动线 */
@property(nonatomic , strong)UIView *moveLine;

/** block */
@property(nonatomic , strong)ArticleListTypeButtonBlock articleTypeBlock;

@end
