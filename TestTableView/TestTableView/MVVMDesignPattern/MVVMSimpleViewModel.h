//
//  MVVMSimpleViewModel.h
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface MVVMSimpleViewModel : NSObject
/***  名字 */
@property(nonatomic,strong)NSString  *nameString;
//绑定model
- (void)bindModel:(id)model;

//按钮点击方法的实现
- (void)changeButtonTextAction;

@end

NS_ASSUME_NONNULL_END
