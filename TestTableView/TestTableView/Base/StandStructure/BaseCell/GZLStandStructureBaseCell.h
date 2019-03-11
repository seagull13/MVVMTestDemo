//
//  GZLStandStructureBaseCell.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "GZLStandStructureBaseViewProtocol.h"
#import "GZLStandStructureBaseCellModel.h"

@interface GZLStandStructureBaseCell : UITableViewCell  <GZLStandStructureBaseViewProtocol>
@property (weak, nonatomic) id<GZLStandStructureBaseViewProtocol> delegate;
/**
 标记位
 @return  标记位
 */
+ (NSString *)cellReuseIdentifier;
/**
 返回的行高

 @return 返回的行高
 */
+ (CGFloat)cellHeight;

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath WithTableView:(UITableView *)tableView;

/**
 更新数据源
 @param model 基础模型
 @param indexPath indePath
 */
- (void)updateCellWithModel:(GZLStandStructureBaseCellModel **)model indexPath:(NSIndexPath *)indexPath;

/**
 重设数据源
 */
- (void)resetData;
/** baseModel */
@property(nonatomic,strong)GZLStandStructureBaseCellModel  *baseModel;

/** tempDataModel */
@property(nonatomic,strong)id  tempDataModel;
/** 下标 */
@property(nonatomic,strong)NSIndexPath  *indexPath;
@end

