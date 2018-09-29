//
//  IntegralRecordDetailResultModel.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordDetailResultModel.h"

@implementation IntegralRecordDetailResultModel

@end


@implementation IntegralRecordDetailResultExpressModel

@end


@implementation IntegralRecordDetailResultAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"addressID" : @"id"};
}

@end


@implementation IntegralRecordDetailResultGoodsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id"};
}

@end
