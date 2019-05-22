//
//  GZLMainHomeCatalogCelll.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/22.
// Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMBindViewModelProtocol.h"
@protocol GZLMainHomeCatalogCelllDelegate <NSObject>

@required

@optional

@end
@interface GZLMainHomeCatalogCelll  : UICollectionViewCell <MVVMBindViewModelProtocol>

/** 代理 */
@property (weak, nonatomic)id<GZLMainHomeCatalogCelllDelegate> delegate;

@end
