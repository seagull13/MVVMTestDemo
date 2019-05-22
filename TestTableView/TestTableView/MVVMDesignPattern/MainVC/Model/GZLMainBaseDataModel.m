//
//  GZLMainBaseDataModel.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainBaseDataModel.h"

@implementation RotateAdsVos



@end
@implementation Hotel

 
@end
@implementation HomeCatalogList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"hotel" : [Hotel class],
             @"ticketVisaCruise" : [Hotel class],
             @"productGroup" : [Hotel class],
             @"fixedFreeTravel" : [Hotel class],
             };
}
@end

@implementation GZLBaseContenModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rotateAdsVos" : [RotateAdsVos class],
             @"advImageFirst" : [RotateAdsVos class],
             @"advImageSecond" : [RotateAdsVos class],
             @"advImageThird" : [RotateAdsVos class],
             @"homeCatalogList" : [HomeCatalogList class],
             };
}
@end
@implementation GZLMainBaseDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"content" : [GZLBaseContenModel class],
             };
}
@end
