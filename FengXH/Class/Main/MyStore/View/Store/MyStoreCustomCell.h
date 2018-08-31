//
//  MyStoreCustomCell.h
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStoreResultModel;

typedef void (^MyStoreCustomCellBlock)(NSInteger index);

@interface MyStoreCustomCell : UITableViewCell

/** block */
@property(nonatomic , strong)MyStoreCustomCellBlock itemClickBlock;
/** model */
@property(nonatomic , strong)MyStoreResultModel *resultModel;

@end
