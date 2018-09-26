//
//  MerchantsUnionHeaderView.h
//  FengXH
//
//  Created by sun on 2018/9/25.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MerchantsUnionHeaderViewBlock)(NSInteger index);

@interface MerchantsUnionHeaderView : UICollectionReusableView

/** textField */
@property(nonatomic , strong)UITextField *searchTextField;
/** block */
@property(nonatomic , strong)MerchantsUnionHeaderViewBlock headerViewBlock;

@end

NS_ASSUME_NONNULL_END
