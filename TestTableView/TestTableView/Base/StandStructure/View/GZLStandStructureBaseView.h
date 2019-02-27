//
//  GZLStandStructureBaseView.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <UIKit/UIKit.h>
#import "GZLStandStructureBaseViewProtocol.h"

@interface GZLStandStructureBaseView : UIView <GZLStandStructureBaseViewProtocol>
/** 代理 */
@property (weak, nonatomic)id<GZLStandStructureBaseViewProtocol> delegate;
/** tableView */
@property (weak, nonatomic)UITableView *mainTableView;
/**数据源 */
@property (copy, nonatomic) NSArray *dataList;
/** 分割线颜色 */
@property(nonatomic,strong)UIColor  *separatorColor;
@property(nonatomic,assign)UITableViewCellSeparatorStyle   separatorStyle;
-(instancetype)initWithFrame:(CGRect)frame iSNotEstimatedRowHeight:(BOOL)iSNotEstimatedRow;
@property(nonatomic,assign) BOOL  isNotNeedTempDictCell;
@property(nonatomic,assign) UIEdgeInsets  contentInset;
-(void)setDataList:(NSArray *)dataList performWithoutAnimation:(BOOL)animat;
@end
