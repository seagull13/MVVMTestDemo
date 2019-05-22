//
//  GZLMainVCDataViewModel.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZLMainBaseDataModel.h"
#import "GZLMainRecommandModel.h"


@interface GZLMainVCDataViewModel : NSObject

/** *  baseModel */
@property(nonatomic,strong)GZLMainBaseDataModel  *baseModel;
/** * recomandModel */
@property(nonatomic,strong)GZLMainRecommandModel  *recomandModel;


@end
