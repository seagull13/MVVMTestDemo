//
//  GZLStandStructureBaseViewProtocol.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2018/4/18.
//

#import <Foundation/Foundation.h>

@protocol GZLStandStructureBaseViewProtocol <NSObject>

@optional

/**
 刷新某个组

 @param indexPath indexPath
 */
- (void)gZLStandStructureBaseCellNeedsReloadSection:(NSIndexPath *)indexPath;

/**
 刷新到某一行 或者刷新整个tableView

 @param indexPath indexPath
 */
- (void)gZLStandStructureBaseCellNeedsReload:(NSIndexPath *)indexPath;


/**
 滚动到某一个cell

 @param cell cell
 @param scrollPosition 滚动的位置
 @param animated 是否需要动画
 @param indexPath indexPath
 */
- (void)gZLStandStructureBaseCellNeedsScrollToCell:(UITableViewCell *)cell atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated Reload:(NSIndexPath *)indexPath;

/**
 每一行的行高

 @param tableView tableView
 @param indexPath indexPath
 @return 行高
 */
- (CGFloat)gZLStandStructureTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 每组的头部高度

 @param tableView tableView
 @param section 组
 @return 每组的头部高度
 */
-(CGFloat)gZLStandStructureTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

/**
 返回cell

 @param tableView tableView
 @param indexPath idnexPath
 @return 返回cell
 */
- (UITableViewCell *)gZLStandStructureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional

/**
 点击cell做的事

 @param parameter 回传的参数
 @param indexPath indexPath
 */
-(void)gZLStandStructureBaseCellDidClickWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath;

/**
 cell 里子View  或者自己点击所做事的回调事假  点击事件

 @param parameter 回传的参数
 @param indexPath indexPath
 */
-(void)gZLStandStructureBaseCellCallBcakWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath;


-(void)gZLStandStructureTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark -------------------
#pragma mark scrollViewDelegate(tableView)

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
@required

@end
