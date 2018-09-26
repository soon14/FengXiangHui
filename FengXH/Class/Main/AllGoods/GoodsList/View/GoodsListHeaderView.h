//
//  GoodsListHeaderView.h
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GoodsListHeaderViewBlock)(NSInteger index);

@interface GoodsListHeaderView : UIView

/** textField */
@property(nonatomic , strong)UITextField *searchTextField;
/** block */
@property(nonatomic , strong)GoodsListHeaderViewBlock headerViewBlock;

@end
