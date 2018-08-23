//
//  SpellOrderCommentGradeCell.h
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarGradeViewDelegate;

@interface SpellOrderCommentGradeCell : UICollectionViewCell

@property (nonatomic, assign) id <StarGradeViewDelegate> delegate;

@end

@protocol StarGradeViewDelegate <NSObject>

- (void)didSelectedIndex:(NSString *)index;

@end
