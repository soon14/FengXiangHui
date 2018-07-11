//
//  HomepageDataModel.m
//  FengXH
//
//  Created by sun on 2018/7/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageDataModel.h"

@implementation HomepageDataModel

@end


@implementation HomepageDataBannerModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataBannerDataModel class]};
}

@end

@implementation HomepageDataBannerDataModel

@end


@implementation HomepageDataMenuFirstModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataMenuDataModel class]};
}

@end

@implementation HomepageDataMenuSecondModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataMenuDataModel class]};
}

@end

@implementation HomepageDataMenuDataModel

@end


@implementation HomepageDataNoticeModel

@end

@implementation HomepageDataNoticeDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataNoticeDataDetailsModel class]};
}

@end

@implementation HomepageDataNoticeDataDetailsModel

@end


@implementation HomepageDataPicturewModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPicturewDataModel class]};
}

@end

@implementation HomepageDataPicturewDataModel

@end


@implementation HomepageDataSecondKillModel

@end

@implementation HomepageDataSecondKillDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":[HomepageDataSecondKillGoodsModel class]};
}

@end

@implementation HomepageDataSecondKillGoodsModel

@end


@implementation HomepageDataCategoryModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataCategoryDataModel class]};
}

@end

@implementation HomepageDataCategoryDataModel

@end





