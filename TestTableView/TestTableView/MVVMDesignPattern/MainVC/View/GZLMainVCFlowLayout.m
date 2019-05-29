//
//  GZLMainVCFlowLayout.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/22.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainVCFlowLayout.h"
#import "MainVCViewType.h"


@interface GZLMainVCFlowLayout ()

@property (strong, nonatomic)NSMutableDictionary *maxDic;
@property (strong, nonatomic)NSMutableArray *attributesArray;
@property(nonatomic,assign)UIEdgeInsets contentInset;

/***space  */
@property(nonatomic,assign) CGFloat space;

@end

@implementation GZLMainVCFlowLayout

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.maxDic = [NSMutableDictionary dictionary];
//        //第一列和第二列的起始高度都为0
//        [self.maxDic setObject:@(0) forKey:@"maxO"];
//        [self.maxDic setObject:@(0) forKey:@"maxS"];
//        _contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//边距
//    }
//    return self;
//}
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
//    self.attributesArray = [NSMutableArray array];
    self.space =  [self.collectionView numberOfItemsInSection:MainViewTypeTravel] > 0 ? 52 : 0;

    for (int index = 0; index < [self.collectionView numberOfSections]; index++) {
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:index]; ++i) {
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:index]];
            [self.attributesArray addObject:attributes];
        }
    }
}
///**
// *这个方法返回值是一个数组(数组内存放着rect范围内所有元素的布局属性,即*UICollectionViewLayoutAttributes对象)
// * 这个方法的返回值,决定了所有rect范围内所有元素的排布
// */
//
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //获得super已经计算好的属性
    NSArray *orignal = [super layoutAttributesForElementsInRect:rect];
    NSArray *array = [[NSArray alloc] initWithArray:orignal copyItems:YES];
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    __block  UICollectionViewLayoutAttributes *layout = nil;
    [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (layoutAttributes.count > 0) {
            layout = layoutAttributes.lastObject;
        }
        obj = [self resetFrame:obj WithLaseLayout:layout];
        [layoutAttributes addObject:obj];
    }];
    return layoutAttributes;
}

-(UICollectionViewLayoutAttributes *)resetFrame:(UICollectionViewLayoutAttributes *)obj WithLaseLayout:(UICollectionViewLayoutAttributes *)lastLayout{
    CGFloat leftSpace = 6;
    CGFloat lineSpace = 1;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat tempW = floorf(([UIScreen mainScreen].bounds.size.width)  / 2.0);
    CGFloat Y = 0;
    CGFloat X = 6;
    CGPoint lastLayoutOrigin =  lastLayout.frame.origin;
    CGSize lastLayoutItemSize =  lastLayout.frame.size;
    CGPoint origin =  obj.frame.origin;
    CGSize itemSize =  obj.frame.size;
    if (obj.indexPath.section ==  MainViewTypeAD) {
        X = leftSpace;
        Y = 100;
        obj.frame = CGRectMake(X, Y, itemSize.width, itemSize.height);
    }else if (obj.indexPath.section ==  MainViewTypeTravel) {
        if (obj.indexPath.row == 0) {
            X = leftSpace;
            Y = lastLayoutOrigin.y + lastLayoutItemSize.height;
        }else if (obj.indexPath.row == 1){
            X = lastLayoutOrigin.x + lastLayoutItemSize.width + lineSpace;
            Y = lastLayoutOrigin.y;
        }else if (obj.indexPath.row == 2){
            X = lastLayoutOrigin.x + lastLayoutItemSize.width + lineSpace;
            Y = lastLayoutOrigin.y;
        }else if (obj.indexPath.row == 3){
            X =  lastLayoutItemSize.width  + lineSpace  + leftSpace;
            Y = lastLayoutItemSize.height + lastLayoutOrigin.y + lineSpace;
        }else if (obj.indexPath.row == 4){
            X = lastLayoutOrigin.x + lastLayoutItemSize.width + lineSpace * 1 ;
            Y = lastLayoutOrigin.y ;
        }
        obj.frame = CGRectMake(X, Y, itemSize.width, itemSize.height);
    }else if (obj.indexPath.section ==  MainViewTypeDecorate){
        if (obj.indexPath.row == 0) {
            X = 0;
            Y = origin.y - self.space;
        }else if (obj.indexPath.row == 1){
            X = tempW;
            Y =  lastLayoutOrigin.y;
        }else if (obj.indexPath.row == 2){
            X = 0 ;
            Y = lastLayoutOrigin.y + ceilf(screenWidth) /2;
        }else if (obj.indexPath.row == 3){
            X = tempW ;
            Y = lastLayoutOrigin.y  - ceilf(screenWidth) /2 + 95;
        }
         obj.frame = CGRectMake(X,  Y, itemSize.width, itemSize.height);
    }else{
        obj.frame = CGRectMake(origin.x, origin.y - self.space, itemSize.width,itemSize.height);
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

-(NSMutableDictionary *)maxDic{
    if (!_maxDic) {
        _maxDic = [NSMutableDictionary dictionary];
        [_maxDic setObject:@(0) forKey:@"maxX"];
        [_maxDic setObject:@(0) forKey:@"maxY"];
    }return _maxDic;
}

@end

//@interface GZLMainVCFlowLayout ()
//// 添加成员变量
//{
//    // 用来设置水平间距
//    CGFloat _horizontalMargin ;
//    // 用来设置竖直间距
//    CGFloat _verticalMargin ;
//    // 最大的列数
//    NSInteger _maxColumns ;
//    // 每个item的四边剧
//    UIEdgeInsets _insets;
//
//}
//// 加入相关属性
//// 保存每一列的高度
//@property (strong, nonatomic) NSMutableArray *perColumnMaxHeights;
//// 保存所有元素的相关属性
//@property (strong, nonatomic) NSMutableArray *layoutAtts;
//// 保存所有元素的相关属性
//@property (assign, nonatomic) BOOL isChangeColumn;
//
//@end
//
//@implementation GZLMainVCFlowLayout
//
//- (instancetype)init
//{
//    if (self = [super init]) {
//
//        // 当外界没有数据则按初始化数据执行
//        _maxColumns = 3;
//        _horizontalMargin = 1;
//        _verticalMargin = 1;
//
//        _insets = UIEdgeInsetsMake(0, 6, 0, 6);
//    }
//
//    return self;
//
//}
//
//- (NSMutableArray *)layoutAtts
//{
//    if (!_layoutAtts) {
//        _layoutAtts = [NSMutableArray array];
//    }
//
//    return _layoutAtts;
//}
//
//- (NSMutableArray *)perColumnMaxHeights
//{
//    if (!_perColumnMaxHeights) {
//        _perColumnMaxHeights = [NSMutableArray array];
//
//    }
//
//    return _perColumnMaxHeights;
//
//}
//
//// 因为在 “layoutAttributesForElementsInRect”可能调用多次，计算多次， 而导致每次的随机数，都不一样， 而造成覆盖现象
//// 所以在 预布局中处理， 可以只计算一次
//- (void)prepareLayout
//{
//    [self.perColumnMaxHeights removeAllObjects];
//    [self.layoutAtts removeAllObjects];
//    self.perColumnMaxHeights = [NSMutableArray arrayWithCapacity:10];
//    for (int i = 0; i < _maxColumns; i ++) {
//        [self.perColumnMaxHeights addObject:@(_insets.top)];
//    }
//
////    // 初始化数组高度,因为第一行,不需要按照高度大小添加
//    CGFloat W = (self.collectionView.frame.size.width - _insets.left - _insets.right - (_maxColumns - 1) * _horizontalMargin ) / _maxColumns;
//    CGFloat H = 0.0 ;
//    CGFloat X,Y;
//    UICollectionViewLayoutAttributes *lastLayoutAtt = nil;
//    for (int i = 0; i < [self.collectionView numberOfSections]; ++i) {
//        if (i == MainViewTypeTravel || i == MainViewTypeFreedomTravel || i == MainViewTypeJD || i == MainViewTypeVisa) {
//            _maxColumns = 3;
//            _horizontalMargin = 1;
//            _verticalMargin = 1;
//            _insets = UIEdgeInsetsMake(0, 6, 0, 6);
//            W = (self.collectionView.frame.size.width - _insets.left - _insets.right - (_maxColumns - 1) * _horizontalMargin ) / _maxColumns;
//            self.isChangeColumn = YES;
//        }else if (i == MainViewTypeOther ) {
//            _maxColumns = 4;
//            _horizontalMargin = 0;
//            _verticalMargin = 0;
//            _insets = UIEdgeInsetsMake(0, 6, 0, 6);
//            W = (self.collectionView.frame.size.width - _insets.left - _insets.right - (_maxColumns - 1) * _horizontalMargin ) / _maxColumns;
//            self.isChangeColumn = YES;
//        }else{
//            _maxColumns = 2;
//            _horizontalMargin = 0;
//            _verticalMargin = 0;
//            _insets = UIEdgeInsetsMake(0, 0, 0, 0);
//            W = (self.collectionView.frame.size.width - _insets.left - _insets.right - (_maxColumns - 1) * _horizontalMargin ) / _maxColumns;
//            self.isChangeColumn = YES;
//        }
//        if (self.isChangeColumn) {
//            [self.perColumnMaxHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                obj =  @(lastLayoutAtt.frame.origin.y + lastLayoutAtt.frame.size.height);
//            }];
//        }
//        for (int j = 0; j < [self.collectionView numberOfItemsInSection:i]; ++j) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
//            UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//            // 求出高度最小的列， 计算出 Y值
//            Y = [self.perColumnMaxHeights[[self minColumn]] floatValue]+ _verticalMargin;
//            // 计算出 X 值
//            X = _insets.left +[self minColumn] * (W + _horizontalMargin) ;
//            // 通过代理计算出 高度
//            if ([self.delegate respondsToSelector:@selector(waterFlowLayout:indexPath:withWidth:)]) {
//                H = [self.delegate waterFlowLayout:self indexPath:indexPath withWidth:W];
//            }
//            // 将新算出来的高度，替换 原来数组中对应的最低高度位置
//              [self.perColumnMaxHeights replaceObjectAtIndex:[self minColumn] withObject:@(Y + H)];
//
//            layoutAtt.frame = CGRectMake(X, Y, W, H);
//            lastLayoutAtt = layoutAtt;
//            [self.layoutAtts addObject:layoutAtt];
//        }
//         self.isChangeColumn = NO;
//    }
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//
//    return self.layoutAtts;
//}
//
//// 计算最小高度的列
//- (NSInteger)minColumn
//{
//    NSInteger minColumn = 0;
//
//    CGFloat minHeight = [self.perColumnMaxHeights[0] floatValue];
//
//    for (int i = 1; i < self.perColumnMaxHeights.count; i ++) {
//
//        CGFloat height = [self.perColumnMaxHeights[i] floatValue];
//        if (height < minHeight) {
//            minHeight = height;
//            minColumn = i;
//        }
//    }
//
//    return minColumn;
//}
//
//// 计算最大高度的列 ，（用在设置 contensize）
//- (NSInteger)maxColumn
//{
//    NSInteger maxColumn = 0;
//
//    CGFloat maxHeight = [self.perColumnMaxHeights[0] floatValue];
//
//    for (int i = 1; i < self.perColumnMaxHeights.count; i ++) {
//
//        CGFloat height = [self.perColumnMaxHeights[i] floatValue];
//        if (height > maxHeight) {
//            maxHeight = height;
//            maxColumn = i;
//        }
//    }
//
//    return maxColumn;
//}
//
//
//- (CGSize)collectionViewContentSize
//{
//
//
//    if (self.perColumnMaxHeights.count == 0) {
//
//        return CGSizeZero;
//    }
//
//    return CGSizeMake(self.collectionView.bounds.size.width,  [self.perColumnMaxHeights[[self maxColumn]] floatValue] + _insets.bottom);
//
//
//}
//
//- (void)setHorzontalMargin:(CGFloat)horizontalMargin
//{
//    _horizontalMargin = horizontalMargin;
//
//}
//- (void)setVerticalMargin:(CGFloat)verticalMargin
//{
//
//    _verticalMargin = verticalMargin;
//
//}
//
//- (void)setMaxColumns:(NSInteger)maxColumns
//{
//
//    if (maxColumns == 0) {
//        return;
//    }
//    _maxColumns = maxColumns;
//
//}
//-(void)setInserts:(UIEdgeInsets)inserts
//{
//    _insets = inserts;
//
//}
//
//@end
