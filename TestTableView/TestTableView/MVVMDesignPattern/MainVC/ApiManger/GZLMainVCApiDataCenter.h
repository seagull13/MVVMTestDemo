//
//  GZLMainVCApiDataCenter.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//

#import <Foundation/NSObject.h>
#import "GZLAPIBaseManager.h"
@interface GZLMainVCBaseDataManger : GZLAPIBaseManager

@end
@interface GZLMainVCRecommandDataManger : GZLAPIBaseManager

@end

@interface GZLMainVCApiDataCenter : NSObject

-(void)refreshLoadBaseData;
-(void)refreshLoadRecommandData;

/**

 页面基础数据
 @param success 成功回调
 @param failer 失败回调
 @return GZLMainVCApiDataCenter 实例
 */
+(instancetype)creatBaseDataMangerWithSuccess:(void(^)(id resposeData))success Failer:(void(^)(id resposeData))failer;

/**
 页面推荐数据

 @param success 成功回调
 @param failer 失败回调
 @return GZLMainVCApiDataCenter 实例
 */
+(instancetype)creatRecommandDataMangerWithSuccess:(void(^)(id resposeData))success Failer:(void(^)(id resposeData))failer;
@end
