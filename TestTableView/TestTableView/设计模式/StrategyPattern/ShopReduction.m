//
//  ShopReduction.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "ShopReduction.h"
@interface  ShopReduction()
@property(nonatomic,assign) CGFloat   reduction;
@end
@implementation ShopReduction
-(instancetype)initWithReduction:(CGFloat)reduction{
  self = [super init];
  if (self) {
    self.reduction = reduction;
  }
  return self;
}

-(CGFloat)calDiscountWithMoney:(CGFloat)money{
  return money - self.reduction;
}
@end
