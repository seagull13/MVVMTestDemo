//
//  ShopContext.h
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ShopType) {
  ShopTypeDefault,
  ShopTypeOriginal,
  ShopTypeDisCount,
  ShopTypeRediction,
};
@interface ShopContext : NSObject
-(instancetype)initWithType:(ShopType)type;
-(CGFloat)calShopPriceWithMoney:(CGFloat)money;
@end

NS_ASSUME_NONNULL_END
