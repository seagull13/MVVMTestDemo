//
//  ShopContext.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "ShopContext.h"

#import "CalDiscountStrategy.h"
#import "ShopOriginal.h"
#import "ShopDiscount.h"
#import "ShopReduction.h"

@interface ShopContext ()
/** id */
@property(nonatomic,strong)id<CalDiscountStrategy>  shopModel;
@end

@implementation ShopContext

-(instancetype)initWithType:(ShopType)type{
  self = [super init];
  switch (type) {
    case ShopTypeOriginal:
      self.shopModel = [[ShopOriginal alloc]init];
      break;
    case ShopTypeDisCount:
      self.shopModel = [[ShopDiscount alloc]initWithDiscount:0.8];
      break;
    case ShopTypeRediction:
      self.shopModel = [[ShopReduction alloc]initWithReduction:30];
      break;
    default:
      break;
  }
  return self;
}

-(CGFloat)calShopPriceWithMoney:(CGFloat)money{
  CGFloat price  = [self.shopModel calDiscountWithMoney:money];
  NSLog(@"结果是%f",price);
  return price;

}
@end
