//
//  MyStoreHeaderCell.h
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStoreResultModel;

typedef void (^MyStoreWithdrawBlock)(UIButton *sender);

@interface MyStoreHeaderCell : UITableViewCell

/** model */
@property(nonatomic , strong)MyStoreResultModel *resultModel;
/** block */
@property(nonatomic , strong)MyStoreWithdrawBlock withdrawBlock;

@end
