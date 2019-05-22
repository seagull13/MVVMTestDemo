//
//  MVVMBindViewModelProtocol.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/22.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MVVMBindViewModelProtocol <NSObject>
-(void)bindViewModel:(id)viewModel;
@end

NS_ASSUME_NONNULL_END
