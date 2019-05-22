//
//  GZLMainRecommandModel.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainRecommandModel.h"

@implementation DestinationList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rotateAdsVos" : [RotateAdsVos class],
             };
}


@end
@implementation TagNames



@end

@implementation ProductAdsRefVoList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tagNames" : [TagNames class], 
             };
}

@end
@implementation RecommendList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"productAdsRefVoList" : [ProductAdsRefVoList class],
             };
}

@end
@implementation PicTag


@end
@implementation SalePromotionVoList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"picTag" : [PicTag class],
             };
}

@end
@implementation SeckillList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"salePromotionVoList" : [SalePromotionVoList class],
             };
}

@end

@implementation GZLMainRecommandContentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"advImageThird" : [RotateAdsVos class],
             @"destinationList" : [DestinationList class],
             @"recommendList" : [RecommendList class],
             @"seckillList" : [SeckillList class],
             };
}


@end

@implementation GZLMainRecommandModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"content" : [GZLMainRecommandContentModel class],
             };
}


@end
