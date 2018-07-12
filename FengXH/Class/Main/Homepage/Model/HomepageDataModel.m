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


@implementation HomepageDataHotPictureModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end

@implementation HomepageDataPictureDataModel

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


@implementation HomepageDataCategorySectionImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end


@implementation HomepageDataFirstCategoryImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end

@implementation HomepageDataSecondCategoryImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end

@implementation HomepageDataThirdCategoryImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end

@implementation HomepageDataFourthCategoryImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end

@implementation HomepageDataFifthCategoryImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end

@implementation HomepageDataSixthCategoryImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end


@implementation HomepageDataFirstCategoryGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataCategoryGoodsDataModel class]};
}

@end


@implementation HomepageDataSecondCategoryGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataCategoryGoodsDataModel class]};
}

@end


@implementation HomepageDataThirdCategoryGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataCategoryGoodsDataModel class]};
}

@end


@implementation HomepageDataFourthCategoryGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataCategoryGoodsDataModel class]};
}

@end


@implementation HomepageDataFifthCategoryGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataCategoryGoodsDataModel class]};
}

@end


@implementation HomepageDataSixthCategoryGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataCategoryGoodsDataModel class]};
}

@end


@implementation HomepageDataCategoryGoodsDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id",
             @"goods_description":@"description"
             };
}

@end


@implementation HomepageDataGuessYouLikeImageModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[HomepageDataPictureDataModel class]};
}

@end


@implementation HomepageDataGuessYouLikeGoodsModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[HomepageDataGuessYouLikeGoodsDataModel class]};
}

@end


@implementation HomepageDataGuessYouLikeGoodsDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id"};
}

@end











