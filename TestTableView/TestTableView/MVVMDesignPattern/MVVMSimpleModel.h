//
//  MVVMSimpleModel.h
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVMSimpleModel : NSObject
/*** 姓名 */
@property(strong,nonatomic) NSString *name;
/*** 高度 */
@property(strong,nonatomic) NSString *height;
/*** 体重  */
@property(nonatomic,assign) double  weight;

@end

NS_ASSUME_NONNULL_END
