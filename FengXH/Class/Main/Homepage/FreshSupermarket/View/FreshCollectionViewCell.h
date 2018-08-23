//
//  FreshCollectionViewCell.h
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreshCollectionViewCell : UICollectionViewCell
- (void)setData:(NSString *)imgStr AndRecommended:(NSString *)recommendStr AndTitle:(NSString *)titleStr AndPrice:(NSString *)price;
@end
