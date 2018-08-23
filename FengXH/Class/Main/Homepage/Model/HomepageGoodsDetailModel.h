//
//  HomepageGoodsDetailModel.h
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomepageShopdetailModel,HomepageGoodsDiscountsModel,HomepageGoodsOptionsModel;

@interface HomepageGoodsDetailModel : NSObject

//商品id
@property(nonatomic,copy)NSString *goodsId;///

//商品缩略图
@property(nonatomic,copy)NSString *thumb;///
//顶部banner展示图片
@property(nonatomic,strong)NSArray *thumb_url;///
//商品名称
@property(nonatomic,copy)NSString *title;///
//子标题
@property(nonatomic,copy)NSString *subtitle;///
//商品原价
@property(nonatomic,copy)NSString *productprice;///
//商品现价
@property(nonatomic,copy)NSString *marketprice;///
//包邮
@property(nonatomic,assign)BOOL issendfree;///
//运费
@property(nonatomic,copy)NSString *dispatchprice;///
//正品保证
@property(nonatomic,assign)BOOL quality;///
//已出售数
@property(nonatomic,copy)NSString *sales;///
//商品所在城市 如为空则显示商城所在
@property(nonatomic,copy)NSString *city;///
//二维码分享图
@property(nonatomic,copy)NSString *share_image;///
//已关注1
@property(nonatomic,assign)BOOL isFavorite;///
//商品单位
@property(nonatomic,copy)NSString *unit;///
//商品详情
@property(nonatomic,strong)NSArray *content;///

//折扣
@property(nonatomic,strong)HomepageGoodsDiscountsModel *discounts;///

//店铺详情
@property(nonatomic,strong)HomepageShopdetailModel *shopdetail;///

// 启用商品规则 0 不启用 1 启用
@property(nonatomic,assign)BOOL hasoption;///
//选择商品规格
@property(nonatomic,strong)NSArray *options;////




//可以加入  购物车
@property(nonatomic,assign)BOOL canAddCart;///?
//商品库存
@property(nonatomic,copy)NSString *total;///?

//分享链接
@property(nonatomic,copy)NSString *share_url;///




@end



@interface HomepageShopdetailModel : NSObject
//1和2 有值就显示1和2  没有就显示进店逛逛
@property(nonatomic,copy)NSString *btntext1;

@property(nonatomic,copy)NSString *btntext2;

@property(nonatomic,copy)NSString *btnurl1;
//店铺地址
@property(nonatomic,copy)NSString *btnurl2;
//店铺描述
@property(nonatomic,copy)NSString *shopDescription;
//头像
@property(nonatomic,copy)NSString *logo;
//名字
@property(nonatomic,copy)NSString *shopname;

@end


@interface HomepageGoodsDiscountsModel : NSObject
//
@property(nonatomic,copy)NSString *type;
//折扣打几折
@property(nonatomic,copy)NSString *discountsDefault;
//
@property(nonatomic,copy)NSString *default_pay;

@end


@interface HomepageGoodsOptionsModel : NSObject
//价钱
@property(nonatomic,copy)NSString *marketprice;
//title
@property(nonatomic,copy)NSString *titleStr;
//缩略图
@property(nonatomic,copy)NSString *thumb;
//商品id
@property(nonatomic,copy)NSString *goodsid;
//商品编码
@property(nonatomic,copy)NSString *goodssn;
//id
@property(nonatomic,copy)NSString *optionsId;
//商品条码
@property(nonatomic,copy)NSString *productsn;
//规格设置
@property(nonatomic,copy)NSString *specs;
//商品库存
@property(nonatomic,copy)NSString *stock;
//
@property(nonatomic,copy)NSString *uniacid;

@end


