//
//  GZLMainRecommandModel.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GZLMainBaseDataModel.h"
@interface DestinationList :NSObject
@property (nonatomic , copy) NSArray<RotateAdsVos *>              * rotateAdsVos;
@property (nonatomic , copy) NSString              * headImage;
@property (nonatomic , copy) NSString              * title;

@end

@interface TagNames :NSObject

@end

@interface ProductAdsRefVoList :NSObject
@property (nonatomic , copy) NSArray<TagNames *>              * tagNames;
@property (nonatomic , copy) NSString              * productDesc;
@property (nonatomic , copy) NSString              * visaRate;
@property (nonatomic , copy) NSString              * subType;
@property (nonatomic , copy) NSString              * hotelLevel;
@property (nonatomic , copy) NSString              * imgSrc;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * scenicLevel;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * pdId;
@property (nonatomic , copy) NSString              * pdName;
@property (nonatomic , copy) NSString              * deptPlaceName;

@end

@interface RecommendList :NSObject
@property (nonatomic , copy) NSArray<ProductAdsRefVoList *>              * productAdsRefVoList;
@property (nonatomic , copy) NSString              * headImage;
@property (nonatomic , copy) NSString              * title;
@end
@interface PicTag :NSObject

@end
@interface SalePromotionVoList :NSObject
@property (nonatomic , copy) NSArray<NSString *>              * departureDates;
@property (nonatomic , copy) NSString              * subType;
@property (nonatomic , copy) NSString              * saleEndTime;
@property (nonatomic , copy) NSString              * secKillType;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * preSaleStartTime;
@property (nonatomic , copy) NSString              * currentTime;
@property (nonatomic , copy) NSString              * productNumLimitPer;
@property (nonatomic , copy) NSString              * scenicId;
@property (nonatomic , copy) NSString              * prodId;
@property (nonatomic , copy) NSString              * childPrice;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * prodPicUrl;
@property (nonatomic , copy) NSString              * preSaleStartTimeStr;
@property (nonatomic , copy) NSString              * saleEndTimeStr;
@property (nonatomic , copy) NSString              * saleStartTimeStr;
@property (nonatomic , copy) NSString              * firstDepartureDate;
@property (nonatomic , copy) NSString              * minPrice;
@property (nonatomic , copy) NSString              * salePromotionId;
@property (nonatomic , copy) NSString              * departureDateStr;
@property (nonatomic , copy) NSString              * prodType;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * saleStartTime;
@property (nonatomic , copy) NSString              * hotelId;
@property (nonatomic , copy) NSArray<PicTag *>              * picTag;

@end

@interface SeckillList :NSObject
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSArray<SalePromotionVoList *>              * salePromotionVoList;

@end

@interface GZLMainRecommandContentModel :NSObject
@property (nonatomic , copy) NSArray<RotateAdsVos *>              * advImageThird;
@property (nonatomic , copy) NSArray<DestinationList *>              * destinationList;
@property (nonatomic , copy) NSArray<RecommendList *>              * recommendList;
@property (nonatomic , copy) NSArray<SeckillList *>              * seckillList;
@end

@interface GZLMainRecommandModel : NSObject
@property (nonatomic , strong) GZLMainRecommandContentModel              * content;
@property (nonatomic , copy) NSString              * resultCode;
@property (nonatomic , copy) NSString              * resultMsg;
@end
