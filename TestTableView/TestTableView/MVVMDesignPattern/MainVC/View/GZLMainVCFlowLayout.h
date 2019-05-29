//
//  GZLMainVCFlowLayout.h
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/22.
//  Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GZLMainVCFlowLayout;
// 设置代理
@protocol GZLMainVCFlowLayoutDelegate<NSObject>
@required

- (CGFloat)waterFlowLayout:(GZLMainVCFlowLayout *)waterFlowLayout indexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width;

@end
@interface GZLMainVCFlowLayout : UICollectionViewFlowLayout

// 设置代理，用于从外界拿到高度
@property(nonatomic,weak) id<GZLMainVCFlowLayoutDelegate> delegate;


@end
