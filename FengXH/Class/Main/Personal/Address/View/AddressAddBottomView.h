//
//  AddressAddBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddAdressButtonBlock)(UIButton *sender);

@interface AddressAddBottomView : UIView

/** block */
@property(nonatomic , strong)AddAdressButtonBlock addBlock;

@end
