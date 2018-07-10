//
//  HomepageFifthCell.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FifthCellBlock)(NSInteger index);

@interface HomepageFifthCell : UICollectionViewCell

/** block */
@property(nonatomic , strong)FifthCellBlock fifthCellBlock;

@end
