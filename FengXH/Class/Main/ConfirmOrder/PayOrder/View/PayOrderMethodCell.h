//
//  PayOrderMethodCell.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PayMethodSelectedBlock)(NSInteger index);

@interface PayOrderMethodCell : UITableViewCell

/** block */
@property(nonatomic , strong)PayMethodSelectedBlock payMethodBlock;

@end
