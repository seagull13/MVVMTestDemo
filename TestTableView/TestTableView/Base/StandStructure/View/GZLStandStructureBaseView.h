//
//  GZLStandStructureBaseView.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <UIKit/UITableView.h>
#import "OYStructureTableViewProtocol.h"
@interface GZLStandStructureBaseView : UIView <OYStructureTableViewProtocol>
/**代理 协议 */
@property (weak, nonatomic)id<OYStructureTableViewProtocol> delegate;
/**tableView */
@property (weak, nonatomic)UITableView *mainTableView;
/**数据源 */
@property (copy, nonatomic) NSArray *dataList;

-(instancetype)initWithFrame:(CGRect)frame iSNotEstimatedRowHeight:(BOOL)iSNotEstimatedRow;
@end
