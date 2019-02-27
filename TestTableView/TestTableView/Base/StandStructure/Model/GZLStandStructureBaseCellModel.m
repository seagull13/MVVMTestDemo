//
//
//  GZLStandStructureBaseCellModel.m
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import "GZLStandStructureBaseCellModel.h"

@implementation GZLStandStructureBaseCellModel
-(NSMutableDictionary *)saveParameter{
    if (!_saveParameter) {
        _saveParameter = [NSMutableDictionary dictionary];
    }
    return _saveParameter;
}


@end
