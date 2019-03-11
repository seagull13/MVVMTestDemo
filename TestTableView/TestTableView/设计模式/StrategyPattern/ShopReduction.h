//
//  ShopReduction.h
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalDiscountStrategy.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopReduction : NSObject<CalDiscountStrategy>
-(instancetype)initWithReduction:(CGFloat)reduction;
@end

NS_ASSUME_NONNULL_END
