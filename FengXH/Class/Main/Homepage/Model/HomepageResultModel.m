//
//  HomepageResultModel.m
//  FengXH
//
//  Created by sun on 2018/10/11.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "HomepageResultModel.h"

@implementation HomepageResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"banner":[HomepageResultPictureModel class],
             @"menu":[HomepageResultPictureModel class],
             @"picturew":[HomepageResultPictureModel class],
             @"goods":[HomepageResultGoodsModel class],
             };
}

@end



@implementation HomepageResultNoticeModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"nice":[HomepageResultNoticeNiceModel class]};
}

@end

@implementation HomepageResultNoticeNiceModel

@end



@implementation HomepageResultSeckillgroupModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":[HomepageResultCommodityModel class]};
}

@end



@implementation HomepageResultGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"picture":[HomepageResultPictureModel class],
             @"list":[HomepageResultCommodityModel class]
             };
}

@end




@implementation HomepageResultPictureModel

@end



@implementation HomepageResultCommodityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id"};
}

@end
