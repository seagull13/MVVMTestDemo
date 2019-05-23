//
//  GZLMainVCFlowLayout.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainVCFlowLayout.h"

@implementation GZLMainVCFlowLayout
/**
 *  用来做布局的初始化
 *  注意: 一定要调用 [super prepareLayout]
 */
- (void)prepareLayout{

    [super prepareLayout];
    //设置内边距
    self.sectionInset = UIEdgeInsetsMake(0, 6, 0, 6);
    //设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}
/**
 *这个方法返回值是一个数组(数组内存放着rect范围内所有元素的布局属性,即*UICollectionViewLayoutAttributes对象)
 * 这个方法的返回值,决定了所有rect范围内所有元素的排布
 */

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //获得super已经计算好的属性
    NSArray *orignal = [super layoutAttributesForElementsInRect:rect];
    NSArray *array = [[NSArray alloc] initWithArray:orignal copyItems:YES];
    [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj = [self resetFrame:obj];
    }];
    return array;
}
-(UICollectionViewLayoutAttributes *)resetFrame:(UICollectionViewLayoutAttributes *)obj{
    CGFloat leftSpace = 6;
    CGFloat lineSpace = 1;
    CGFloat tempHeight = 50;
    CGFloat W = floorf(([UIScreen mainScreen].bounds.size.width  - 12 - 2)  / 3.0);
    CGFloat H = 50;
    CGFloat Y = 0;
    CGFloat X = 6;
    if (obj.indexPath.section ==  1) {
        if (obj.indexPath.row == 0) {
            H = tempHeight * 2 + lineSpace;
            X = leftSpace;
            Y = 0;
        }else if (obj.indexPath.row == 1){
            H = tempHeight;
            X = W + lineSpace + leftSpace;
            Y = 0;
        }else if (obj.indexPath.row == 3){
            H = tempHeight;
            X = 2 * (W + lineSpace) + leftSpace;
            Y = 0;
        }else if (obj.indexPath.row == 2){
            H = tempHeight;
            X = W + lineSpace + leftSpace;
            Y = tempHeight + lineSpace;
        }else if (obj.indexPath.row == 4){
            H = tempHeight;
            X = 2 * (W + lineSpace) + leftSpace;
            Y = tempHeight + lineSpace;
        }
        obj.frame = CGRectMake(X, Y, W, H);
    }else {
        obj.frame = CGRectMake(obj.frame.origin.x, obj.frame.origin.y - 52, obj.frame.size.width, obj.frame.size.height);
    }


    return obj;
}

/**
 *  当collectionView的显示范围发生改变的时候,是否需要刷新重新布局
 *一但重新刷新布局,就会调用
 *1.prepareLayout
 *2.layoutAttributesForElementsInRect:(CGRect)rect 方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 *  这个方法的返回值,决定了contentView停止滚动时的偏移量
 *  参数:
 *  proposedContentOffset 原本情况下,collctionView停止滚动时最终的偏移量
 *  velocity:滚动速率,通过这个参数可以了解滚动的方向
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
//    //计算出最终显示的矩形框
//    CGRect rect ;
//    rect.origin.x = proposedContentOffset.x;
//    rect.origin.y = 0;
//    rect.size = self.collectionView.frame.size;
//
//    //获得super已经计算好的属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    //计算CollectionView 最中心点x 的值
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width/2;
//
//    //存放最小的间距
//    CGFloat minSpace = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attr in array) {
//
//        if (ABS(minSpace) > ABS(attr.center.x - centerX)) {
//
//            minSpace = attr.center.x - centerX;
//        }
//    }
//
//    //修改原有的偏移量
//    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}
@end
