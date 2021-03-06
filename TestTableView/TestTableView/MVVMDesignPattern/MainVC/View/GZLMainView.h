//
//  GZLMainView.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMBindViewModelProtocol.h"
@protocol GZLMainViewDelegate <NSObject>

@optional

@required

@end

@interface GZLMainView  : UIView <MVVMBindViewModelProtocol>
/** 代理 */
@property (weak, nonatomic)id<GZLMainViewDelegate> delegate;
@end
