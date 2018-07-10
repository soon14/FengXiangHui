//
//  HomepageSecondCell.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageThirdItem.h"

typedef void (^HomeThirdCellBlock)(NSInteger index);

@interface HomepageThirdCell : UICollectionViewCell

@property(nonatomic , strong)NSArray *recentyLotteries;
/** block */
@property(nonatomic , strong)HomeThirdCellBlock thirdCellBlock;

@end
