//
//  SpellOrderView.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellOrderListDataModel;

@interface SpellOrderView : UIView
//顶部订单号部分的view
@property(nonatomic,strong)UIView *topView;
//订单号
@property(nonatomic,strong)UILabel *orderNumLab;
//状态
@property(nonatomic,strong)UILabel *statusLab;
//商品view
@property(nonatomic,strong)UIView *goodsView;
//商品图片
@property(nonatomic,strong)UIImageView *goodsImgView;
//商品名字
@property(nonatomic,strong)UILabel *goodsNameLab;
//单价
@property(nonatomic,strong)UILabel *goodsSinglePriceLab;
//商品数量
@property(nonatomic,strong)UILabel *goodsCountLab;
//总额
@property(nonatomic,strong)UILabel *allPriceLab;


@property(nonatomic,strong)SpellOrderListDataModel *dataModel;


-(instancetype)initWithType:(NSInteger)type  andFrame:(CGRect)frame;//0待付款 1待发货 2待收货 3已完成

@end
