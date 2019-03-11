//
//  ShopDiscount.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "ShopDiscount.h"
@interface  ShopDiscount()

@property(nonatomic,assign) CGFloat   discount;

@end
@implementation ShopDiscount

-(instancetype)initWithDiscount:(CGFloat)discount{
  self = [super init];
  if (self) {
    self.discount = discount;
  }
  return self;
}


-(CGFloat)calDiscountWithMoney:(CGFloat)money{
  return money * self.discount;

}
@end
