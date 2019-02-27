//
//  GZLStandStructureBaseCellModel.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <Foundation/Foundation.h>

@interface GZLStandStructureBaseCellModel : NSObject

/** 基础模型 */
@property(nonatomic,strong)id  baseModel;
/** 保留的参数 */
@property(nonatomic,strong)NSMutableDictionary  *saveParameter;
/** 每组cell的名字 */
@property (copy, nonatomic) NSString *containerCellClass;
/** 每组头部的类名 */
@property(nonatomic,strong)NSString  *headViewCellClass;
/** 每组尾部的类名 */
@property(nonatomic,strong)NSString  *footViewCellClass;
@property (copy, nonatomic) NSString *regionTitle;
/** titleCode */
@property(nonatomic,strong)NSString  *titleCode;
/**模型数组*/
@property (strong, nonatomic) NSArray *itemList;
@property (assign, nonatomic) BOOL isShowAll;
/**是否自动计算行高  */
@property(nonatomic,assign)BOOL  isAutoRowheight;
/**是否自动计算行高  */
@property(nonatomic,assign)BOOL  isCacheCellHeight;
/** foot 高度(假定没有头部,距离顶部有点间距 尾部类似 例如距离  是10)*/
@property(nonatomic,assign) float  footBaseSectionHeight;
/**head 高度(假定没有头部,距离顶部有点间距 尾部类似 例如距离  是10) */
@property(nonatomic,assign) float  headBaseSectionHeight;
/** 是否同一个组有多个不同的cell*/
@property(nonatomic,assign) BOOL  multipleDifferentCells;
/** 同一个组有不同的cell   不同cell 的数组 */
@property(nonatomic,strong)NSArray  *containerCellClassArray;


@end


