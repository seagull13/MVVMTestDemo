//
//  GZLHomeRecommandCell.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/23.
// Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMBindViewModelProtocol.h"
@protocol GZLHomeRecommandCellDelegate <NSObject>
@required
@optional
@end
@interface GZLHomeRecommandCell : UICollectionViewCell<MVVMBindViewModelProtocol>
/** 代理 */
@property (weak, nonatomic)id<GZLHomeRecommandCellDelegate> delegate;
@end
