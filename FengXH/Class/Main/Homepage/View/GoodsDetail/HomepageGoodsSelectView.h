//
//  HomepageGoodsSelectView.h
//  FengXH
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomepageGoodsDetailModel;

typedef void(^GoodsSelectBlock)(void);

@interface HomepageGoodsSelectView : UIView
//数量
@property(nonatomic,strong)UIButton *countBtn;
//记录当前选择的按钮
@property(nonatomic,strong)UIButton *selectBtn;
//用来判断点击哪里弹出的selectView  0请选择数量 1加入购物车 2立即购买
@property(nonatomic,assign)NSInteger selectType;

@property(nonatomic,strong)HomepageGoodsDetailModel *goodsMessageModel;

@property(nonatomic,copy)GoodsSelectBlock selectBlock;

@end
