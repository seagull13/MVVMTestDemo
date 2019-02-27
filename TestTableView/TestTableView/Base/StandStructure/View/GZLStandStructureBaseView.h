//
//  GZLStandStructureBaseView.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <UIKit/UIKit.h>
#import "GZLStandStructureBaseViewProtocol.h"
#import "RefreshTableView.h"
@interface GZLStandStructureBaseView : UIView <GZLStandStructureBaseViewProtocol>

/** 代理 */
@property (weak, nonatomic)id<GZLStandStructureBaseViewProtocol> delegate;
/** tableView */
@property (weak, nonatomic)RefreshTableView *mainTableView;
/**数据源 */
@property (copy, nonatomic) NSArray *dataList;

/** 分割线颜色 */
@property(nonatomic,strong)UIColor  *separatorColor;

@property(nonatomic,assign)UITableViewCellSeparatorStyle   separatorStyle;


-(instancetype)initWithFrame:(CGRect)frame iSNotEstimatedRowHeight:(BOOL)iSNotEstimatedRow;

@property(nonatomic,assign) BOOL  isNotNeedTempDictCell;

@property(nonatomic,assign) UIEdgeInsets  contentInset;

/** 头部下拉刷新 */
@property(nonatomic,copy)void (^headerRefreshBlock)();
/** 尾部下拉刷新 */
@property(nonatomic,copy)void (^footerRefreshBlock)();
/** 头部尾部下拉刷新 */
@property(nonatomic,copy)void (^headerAndFooterRefreshBlock)();

-(void)setDataList:(NSArray *)dataList performWithoutAnimation:(BOOL)animat;
/** 单纯头部刷新 */
- (void)setupRefreshHeader;
/** 单纯尾部刷新 */
- (void)setupRefreshFooter;
/** 头部尾部都可以刷新 */
- (void)setupRefresh;

/** 停止刷新刷新 */
- (void)stopRefresh;
/** isBeginRefresh 是否开始刷新 */
@property (assign, nonatomic)BOOL isBeginRefresh;

@end
