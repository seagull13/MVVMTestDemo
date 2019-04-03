//
//  MVVMSimpleView.h
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVMSimpleView : UIView

//绑定viewModel
- (void)bindViewModel:(id)viewModel;
@end

NS_ASSUME_NONNULL_END
