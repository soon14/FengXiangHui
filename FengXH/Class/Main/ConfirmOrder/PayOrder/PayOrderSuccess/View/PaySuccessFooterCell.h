//
//  PaySuccessFooterCell.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PaySuccessFooterBlock)(NSInteger index);

@interface PaySuccessFooterCell : UITableViewCell

/** block */
@property(nonatomic , strong)PaySuccessFooterBlock backBlock;

@end
