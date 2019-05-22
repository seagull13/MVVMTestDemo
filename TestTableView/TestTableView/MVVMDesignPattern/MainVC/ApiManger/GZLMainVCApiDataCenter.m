//
//  GZLMainVCApiDataCenter.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainVCApiDataCenter.h"

@implementation GZLMainVCBaseDataManger
- (NSString *)serviceType{

    return @"https://m.gzl.cn/app-web/";
}
- (NSString *)urlPath{
    return @"native/";
}

- (NSString *)methodName{

    return @"homePage/getDecorationForFirst.json";
}
- (CTAPIManagerRequestType)requestType{

    return CTAPIManagerRequestTypePost;
}
//接口调试方法
- (void)APITestMethod:(NSString *)urlString params:(NSDictionary *)params date:(id)requestData
{
    NSLog(@"MainVCFirstManager--TEST-- \n url:%@,\n params:%@,\n requestData:%@ \n message:%@", urlString, params, requestData, requestData[@"message"]);
}


@end

@implementation GZLMainVCRecommandDataManger
- (NSString *)serviceType{

    return @"https://m.gzl.cn/app-web/";
}
- (NSString *)urlPath{
    return @"native/";
}

- (NSString *)methodName{

    return @"homePage/getDecorationForRecommend.json";
}
- (CTAPIManagerRequestType)requestType{

    return CTAPIManagerRequestTypePost;
}
//接口调试方法
- (void)APITestMethod:(NSString *)urlString params:(NSDictionary *)params date:(id)requestData
{
    NSLog(@"MainVCSecondManager--TEST-- \n url:%@,\n params:%@,\n requestData:%@ \n message:%@", urlString, params, requestData, requestData[@"message"]);
}
@end
@interface GZLMainVCApiDataCenter ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
/*** 基础数据  */
@property(nonatomic,strong)GZLMainVCBaseDataManger  *baseDataManger;
/*** 推荐数据  */
@property(nonatomic,strong)GZLMainVCRecommandDataManger  *recommandDataManger;

/** *   */
@property(nonatomic,copy)void(^success)(id resposeData);
/** *   */
@property(nonatomic,copy)void(^failer)(id resposeData);


@end
@implementation GZLMainVCApiDataCenter


+(instancetype)creatBaseDataMangerWithSuccess:(void(^)(id resposeData))success Failer:(void(^)(id resposeData))failer{
    GZLMainVCApiDataCenter *center = [[GZLMainVCApiDataCenter alloc]init];
    center.success = success;
    center.failer = failer;
    [center.baseDataManger loadData];
    return center;
}

+(instancetype)creatRecommandDataMangerWithSuccess:(void(^)(id resposeData))success Failer:(void(^)(id resposeData))failer{
    GZLMainVCApiDataCenter *center = [[GZLMainVCApiDataCenter alloc]init];
    center.success = success;
    center.failer = failer;
    [center.recommandDataManger loadData];
    return center;
}

-(void)refreshLoadBaseData{
    [self.baseDataManger loadData];
}
-(void)refreshLoadRecommandData{
    [self.recommandDataManger loadData];
}

-(NSDictionary *)paramsForApi:(GZLAPIBaseManager *)manager{
    return nil;
}

-(void)managerCallAPIDidSuccess:(GZLAPIBaseManager *)manager{
    if (self.baseDataManger == manager) {
        self.success(manager.fetchedRawData);
    }else{
        self.success(manager.fetchedRawData);
    }
}

-(void)managerCallAPIDidFailed:(GZLAPIBaseManager *)manager{
    if (self.baseDataManger == manager) {
        self.failer(manager.fetchedRawData);
    }else{
        self.failer(manager.fetchedRawData);
    }
}
-(GZLMainVCBaseDataManger *)baseDataManger{
    if (!_baseDataManger) {
        _baseDataManger = [[GZLMainVCBaseDataManger alloc]initSettingDelegateAndParamSource:self];
    }
    return _baseDataManger;
}
-(GZLMainVCRecommandDataManger *)recommandDataManger{
    if (!_recommandDataManger) {
        _recommandDataManger = [[GZLMainVCRecommandDataManger alloc]initSettingDelegateAndParamSource:self];
    }
    return _recommandDataManger;
}
@end
