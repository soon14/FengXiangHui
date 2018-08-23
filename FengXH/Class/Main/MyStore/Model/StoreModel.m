//
//  StoreModel.m
//  FengXH
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([self.umobile  isEqual:[NSNull null]]||self.umobile == nil || self.umobile == NULL) {
        
        self.umobile=@"";
        
    }
    return YES;
}
@end
