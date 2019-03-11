//
//  CalDiscountStrategy.h
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol CalDiscountStrategy <NSObject>

//@property(nonatomic,assign)CGFloat price;


-(CGFloat)calDiscountWithMoney:(CGFloat)money;

@end

NS_ASSUME_NONNULL_END
