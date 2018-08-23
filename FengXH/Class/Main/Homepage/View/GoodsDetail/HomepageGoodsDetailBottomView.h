//
//  HomepageGoodsDetailBottomView.h
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoodsDetailBottomBlock)(NSInteger index);

@interface HomepageGoodsDetailBottomView : UIView

@property(nonatomic , strong)GoodsDetailBottomBlock bottomBlock;

//关注按钮
@property(nonatomic,strong)UIButton *attentionBtn;

@end
