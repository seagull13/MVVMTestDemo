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
        [self baseDataCenter];
        [self recommandCenter];
    }return self;
}

-(GZLMainVCApiDataCenter *)baseDataCenter{
    if (!_baseDataCenter) {
        _baseDataCenter = [GZLMainVCApiDataCenter creatBaseDataMangerWithSuccess:^(id resposeData) {
            self.baseModel =  [GZLMainBaseDataModel modelWithDictionary:resposeData];
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
-(GZLMainBaseDataModel *)baseModel{
    if (!_baseModel) {
        _baseModel = [[GZLMainBaseDataModel alloc]init];
    }
    return _baseModel;
}
-(GZLMainRecommandModel *)recomandModel{
    if (!_recomandModel) {
        _recomandModel = [[GZLMainRecommandModel alloc]init];
    }
    return _recomandModel;
}

@end
