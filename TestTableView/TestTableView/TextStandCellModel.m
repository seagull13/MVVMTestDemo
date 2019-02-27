//
//  textStandCellModel.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "TextStandCellModel.h"

@implementation TextStandCellModel
-(instancetype)init{
  self = [super init];
  if (self) {
    self.textColor = [self randomColor];
    self.detailColor = [self randomColor];
  }
  return self;
}

-(UIColor *)randomColor{
  return [UIColor  colorWithRed:arc4random_uniform(255) /255.0 green:arc4random_uniform(255) /255.0 blue:arc4random_uniform(255) /255.0 alpha:1];
}
@end
