//
//  GZLMainVCDataViewModel.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainVCDataViewModel.h"
#import "GZLMainVCApiDataCenter.h"
#import <YYKit/NSObject+YYModel.h>
@interface GZLMainVCDataViewModel()
/***  基础数据 */
@property(nonatomic,strong)GZLMainVCApiDataCenter  *baseDataCenter;
/***  推荐数据 */
@property(nonatomic,strong)GZLMainVCApiDataCenter  *recommandCenter;
@end
@implementation GZLMainVCDataViewModel
-(instancetype)init{
    self = [super init];
    if (self) {
        [self readData];
        [self baseDataCenter];
        [self recommandCenter];
    }return self;
}

-(void)cacheData:(id)data{
    [data writeToFile:[self getCacheDataPath] atomically:YES];
}
-(void)readData{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[self getCacheDataPath]];
    self.baseModel =  [GZLMainBaseDataModel modelWithDictionary:dic];
}
-(NSString *)getCacheDataPath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"GZLMainVCBaseDataApiDataCenter.plist"];
}

-(GZLMainVCApiDataCenter *)baseDataCenter{
    if (!_baseDataCenter) {
        _baseDataCenter = [GZLMainVCApiDataCenter creatBaseDataMangerWithSuccess:^(id resposeData) {
            self.baseModel =  [GZLMainBaseDataModel modelWithDictionary:resposeData];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self cacheData:resposeData];
            });
        } Failer:^(id resposeData) {

        }];
    }return _baseDataCenter;
}

-(GZLMainVCApiDataCenter *)recommandCenter{
    if (!_recommandCenter) {
        _recommandCenter = [GZLMainVCApiDataCenter creatRecommandDataMangerWithSuccess:^(id resposeData) {
             self.recomandModel =  [GZLMainRecommandModel modelWithDictionary:resposeData];
        } Failer:^(id resposeData) {

        }];
    }return _recommandCenter;
}

@end
