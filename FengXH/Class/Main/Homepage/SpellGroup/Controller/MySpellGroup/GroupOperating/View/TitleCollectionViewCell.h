//
//  TitleCollectionViewCell.h
//  FengXH
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GroupOperatingModel,TitleCollectionViewCell;
@protocol TitleCollectionViewCellDelegate <NSObject>
- (void)btnClicked:(NSInteger)sender;

@end
@interface TitleCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) GroupOperatingModel *groupOperatingModel;

@property(nonatomic , weak)id <TitleCollectionViewCellDelegate> mdelegate;
@end
