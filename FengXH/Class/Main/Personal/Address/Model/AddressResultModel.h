//
//  AddressResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressResultModel : NSObject

/** 地址列表 */
@property(nonatomic , strong)NSMutableArray *list;

@end


@interface AddressResultListModel : NSObject

/** 地址被选中 */
@property(nonatomic , assign)BOOL selected;
/** 地址ID */
@property(nonatomic , copy)NSString *addressID;
/** 公众号ID */
@property(nonatomic , copy)NSString *uniacid;
/** openid */
@property(nonatomic , copy)NSString *openid;
/** 收件人姓名 */
@property(nonatomic , copy)NSString *realname;
/** 手机号 */
@property(nonatomic , copy)NSString *mobile;
/** 省 */
@property(nonatomic , copy)NSString *province;
/** 市 */
@property(nonatomic , copy)NSString *city;
/** 区 */
@property(nonatomic , copy)NSString *area;
/** 乡镇 */
@property(nonatomic , copy)NSString *town;
/** 详细地址 */
@property(nonatomic , copy)NSString *address;
/** 默认   0否     1是 */
@property(nonatomic , assign)NSInteger isdefault;
/** 邮编 预留 */
@property(nonatomic , copy)NSString *zipcode;
/** 是否删除 0否 1是 接口只查未删除 */
@property(nonatomic , copy)NSString *deleted;
/** 街道  */
@property(nonatomic , copy)NSString *street;
/** 数据值 预留 */
@property(nonatomic , copy)NSString *datavalue;
/** 街道数据值 预留 */
@property(nonatomic , copy)NSString *streetdatavalue;
/** areas */
@property(nonatomic , copy)NSString *areas;
/** place */
@property(nonatomic , copy)NSString *place;
/** fxh_api */
@property(nonatomic , copy)NSString *fxh_api;

@end


