//
//  GZLMainBaseDataModel.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RotateAdsVos :NSObject
/***  子标题*/
@property (nonatomic , copy) NSString              * subTitle;
/***  标题*/
@property (nonatomic , copy) NSString              * title;
/***  链接*/
@property (nonatomic , copy) NSString              * href;
/***  图片 */
@property (nonatomic , copy) NSString              * picUrl;
@end

@interface Hotel :NSObject
/***  图片*/
@property (nonatomic , copy) NSString              * pic;
/***  子类型 */
@property (nonatomic , copy) NSString              * subType;
@end

@interface HomeCatalogList :NSObject
/***  酒店*/
@property (nonatomic , copy) NSArray<Hotel *>              * hotel;
/***  门票签证邮轮*/
@property (nonatomic , copy) NSArray<Hotel *>              * ticketVisaCruise;
/***  跟团*/
@property (nonatomic , copy) NSArray<Hotel *>              * productGroup;
/***  自由行  */
@property (nonatomic , copy) NSArray<Hotel *>              * fixedFreeTravel;
@end
@interface GZLBaseContenModel :NSObject
/***  第三屏*/
@property (nonatomic , copy) NSArray<RotateAdsVos *>              * advImageThird;
/***  第二屏*/
@property (nonatomic , copy) NSArray<RotateAdsVos *>              * advImageSecond;
/***  第一屏*/
@property (nonatomic , copy) NSArray<RotateAdsVos *>              * advImageFirst;
/***  广告*/
@property (nonatomic , copy) NSArray<RotateAdsVos *>              * rotateAdsVos;

@property (nonatomic , strong) HomeCatalogList              * homeCatalogList;
@end

@interface GZLMainBaseDataModel : NSObject
@property (nonatomic , copy) NSString              * resultCode;
@property (nonatomic , strong) GZLBaseContenModel              * content;
@property (nonatomic , copy) NSString              * fromCache;
@property (nonatomic , copy) NSString              * resultMsg;
@end
