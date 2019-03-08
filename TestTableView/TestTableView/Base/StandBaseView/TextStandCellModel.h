//
//  textStandCellModel.h
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TextStandCellModel : NSObject
/** 名字 */
@property(nonatomic,strong)NSString  *name;
/** 身高 */
@property(nonatomic,assign)double  height;
/** 体重 */
@property(nonatomic,assign)double  weight;

/** detailColor */
@property(nonatomic,strong)UIColor  *detailColor;
/** textColor */
@property(nonatomic,strong)UIColor  *textColor;
@end

NS_ASSUME_NONNULL_END
