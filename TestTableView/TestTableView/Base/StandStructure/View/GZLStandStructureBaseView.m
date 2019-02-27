//
//  GZLStandStructureBaseView.m
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import "GZLStandStructureBaseView.h"

#import "GZLStandStructureBaseCellModel.h"
#import "GZLStandStructureBaseCell.h"
#import "GZLStandStructureBaseHeadAndFootView.h"
#import "GZLStandStructureBaseViewProtocol.h"

#import "objc/runtime.h"
#import "objc/message.h"
id (*objc_gZLStandStructureBaseViewMsgSendGetCellIdentifier)(id self, SEL _cmd) = (void *) objc_msgSend;
CGFloat (*gZLStandStructureBaseViewMsgSendGetCellHeight)(id self, SEL _cmd) = (void *) objc_msgSend;
id (*objc_gZLStandStructureBaseViewMsgSendCreateCellWithIndexPath)(id self, SEL _cmd, NSIndexPath *,UITableView *) = (void *)objc_msgSend;
id (*objc_gZLStandStructureBaseViewMsgSendGetBaseHeadAndFootViewReuseIdentifier)(id self, SEL _cmd) = (void *) objc_msgSend;
CGFloat (*gZLStandStructureBaseViewMsgSendGetCreateBaseHeadAndFootViewHeight)(id self, SEL _cmd) = (void *) objc_msgSend;
id (*objc_gZLStandStructureBaseViewMsgSendCreateBaseHeadAndFootViewWithSection)(id self, SEL _cmd, NSInteger ) = (void *)objc_msgSend;

@interface GZLStandStructureBaseView ()<GZLStandStructureBaseViewProtocol,UITableViewDataSource,UITableViewDelegate,GZLStandStructureBaseHeadAndFootViewDelegate,UIGestureRecognizerDelegate>

/**
 储存cell的字典
 */
@property (strong, nonatomic) NSMutableDictionary *templateCellDict;

@property (strong, nonatomic) NSMutableDictionary *templateCellIsLoadModelDict;

@property (strong, nonatomic) NSMutableDictionary *templateHeadAndFootViewDict;
/** 是否需要 自动计算预估行高*/
@property(nonatomic,assign) BOOL  iSNotEstimatedRowHeight;

@end
@implementation GZLStandStructureBaseView


#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setUpGZLStandStructureBaseView];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setUpGZLStandStructureBaseView];
}

- (void)layoutSubviews{
  [super layoutSubviews];
  self.mainTableView.frame = self.bounds;

}
-(instancetype)initWithFrame:(CGRect)frame iSNotEstimatedRowHeight:(BOOL)iSNotEstimatedRow{
  self = [super initWithFrame:frame];
  if (self) {
    self.iSNotEstimatedRowHeight = iSNotEstimatedRow;
    [self setUpGZLStandStructureBaseView];
  }
  return self;
}
#pragma mark - 初始化
- (void)setUpGZLStandStructureBaseView{
  [self mainTableView];

}

#pragma mark -------------------
#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  GZLStandStructureBaseCellModel *model = _dataList[section];
  if (model.multipleDifferentCells) {
    return model.containerCellClassArray.count;
  }
  return model.itemList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return _dataList.count;
}
#pragma mark -------------------
#pragma mark 加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  //1.首先看外界的代理是否实现了 加载cell的数据源的方法
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureTableView:cellForRowAtIndexPath:)]) {
    return   [self.delegate gZLStandStructureTableView:tableView cellForRowAtIndexPath:indexPath];
  }

  //2.防止数组越界
  if (indexPath.section >  _dataList.count - 1  ) {
    UITableViewCell *tempCell = [[UITableViewCell alloc]init];
    return tempCell;
  }
  //正常数据
  GZLStandStructureBaseCellModel *model = _dataList[indexPath.section];
  //3.加载数据源cell
  GZLStandStructureBaseCell *cell  = [self getTableViewCellWithTableView:tableView cellForRowAtIndexPath:indexPath WithModel:model];
  //4.比对模型 假如模型数据发生变化 则进入更新数据源
  [cell updateCellWithModel:&model indexPath:indexPath];
  return cell;
}

-(GZLStandStructureBaseCell *)getTableViewCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath WithModel:(GZLStandStructureBaseCellModel *)model{
  Class cellClazz ;
  //1.加载cell 的类名
  if (model.multipleDifferentCells) {
    //2.防止数组越界
    if (indexPath.row > model.containerCellClassArray.count - 1 ) {
      GZLStandStructureBaseCell *tempCell = [[GZLStandStructureBaseCell alloc]init];
      return tempCell;
    }
    cellClazz = NSClassFromString( model.containerCellClassArray[indexPath.row]);
  }else{
    cellClazz = NSClassFromString(model.containerCellClass);
  }
  //3.取出cell标识符
  NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetCellIdentifier(cellClazz, NSSelectorFromString(@"cellReuseIdentifier"));
  identifier = [NSString stringWithFormat:@"%@-%2ld-%2ld",identifier,(long)indexPath.section,(long)indexPath.row];

  GZLStandStructureBaseCell *cell = [self.templateCellDict objectForKey:identifier];
  if (cell == nil) {
    cell =  [((GZLStandStructureBaseCell *)[cellClazz alloc]) initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.delegate = self;
    [self.templateCellDict setObject:cell forKey:identifier];
  }
  return cell;
}

#pragma mark -------------------
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  //1.是否外界设置代理回调
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureTableView:heightForRowAtIndexPath:)]) {
    CGFloat height = [self.delegate gZLStandStructureTableView:tableView heightForRowAtIndexPath:indexPath];
    return  height;
  }
  GZLStandStructureBaseCellModel *model = _dataList[indexPath.section];
  Class cellClazz  ;
  if (model.multipleDifferentCells) {
    //2.防止数组越界
    if (indexPath.row >   model.containerCellClassArray.count - 1  ) {
      return 0.01;
    }
    cellClazz = NSClassFromString( model.containerCellClassArray[indexPath.row]);
  }else{
    //2.防止数组越界
    if (indexPath.section >  _dataList.count - 1  ) {
      return 0.01;
    }
    cellClazz = NSClassFromString(model.containerCellClass);
  }

  NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetCellIdentifier(cellClazz, NSSelectorFromString(@"cellReuseIdentifier"));
  identifier = [NSString stringWithFormat:@"%@-%2ld-%2ld",identifier,(long)indexPath.section,(long)indexPath.row];
  GZLStandStructureBaseCell *cell = [self.templateCellDict objectForKey:identifier];

  if (cell == nil) {
    cell = [((GZLStandStructureBaseCell *)[cellClazz alloc]) initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.delegate = self;
    [self.templateCellDict setObject:cell forKey:identifier];
  }
  //3.是否开启自动计算行高
  if (model.isAutoRowheight) {
    return  UITableViewAutomaticDimension;
  }
  //4.是否设置cell 的固定高度
  if ([(id)cellClazz respondsToSelector:@selector(cellHeight)]) {
    CGFloat cellHeight = gZLStandStructureBaseViewMsgSendGetCellHeight(cellClazz, NSSelectorFromString(@"cellHeight"));
    return cellHeight;
  }
  [cell updateCellWithModel:&model indexPath:indexPath];
  return  cell.frame.size.height;
}


#pragma mark -------------------
#pragma mark SectionFootView  和 SectionHeadView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  GZLStandStructureBaseCellModel *model = _dataList[section];
  Class headViewClazz =  NSClassFromString(model.headViewCellClass);
  NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetBaseHeadAndFootViewReuseIdentifier(headViewClazz, NSSelectorFromString(@"baseHeadAndFootViewReuseIdentifier"));
  if (identifier.length == 0 ||identifier == nil) {
    return  ({
      UIView *headView = [[UIView alloc]init];
      headView.backgroundColor = [UIColor clearColor];
      headView;
    });
  }
  GZLStandStructureBaseHeadAndFootView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];

  if (!headView) {
    headView = objc_gZLStandStructureBaseViewMsgSendCreateBaseHeadAndFootViewWithSection(headViewClazz, NSSelectorFromString(@"createBaseHeadAndFootViewWithSection:"), section);
    headView.delegate = self;
  }
  //update
  [headView updateBaseHeadAndFootViewWithModel:&model section:section];
  return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  GZLStandStructureBaseCellModel *model = _dataList[section];

  Class footViewClazz =  NSClassFromString(model.footViewCellClass);
  NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetBaseHeadAndFootViewReuseIdentifier(footViewClazz, NSSelectorFromString(@"baseHeadAndFootViewReuseIdentifier"));
  if (identifier.length == 0 ||identifier == nil) {
    return  ({
      UIView *footView = [[UIView alloc]init];
      footView.backgroundColor = [UIColor clearColor];
      footView;
    });
  }
  GZLStandStructureBaseHeadAndFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
  if (!footView) {
    footView = objc_gZLStandStructureBaseViewMsgSendCreateBaseHeadAndFootViewWithSection(footViewClazz, NSSelectorFromString(@"createBaseHeadAndFootViewWithSection:"), section);
    footView.delegate = self;
  }
  //update
  [footView updateBaseHeadAndFootViewWithModel:&model section:section];
  return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureTableView:heightForHeaderInSection:)]) {
    return [self.delegate gZLStandStructureTableView:tableView heightForHeaderInSection:section];
  }
  GZLStandStructureBaseCellModel *model = _dataList[section];
  Class headViewClazz =  NSClassFromString(model.headViewCellClass);
  if ([(id)headViewClazz respondsToSelector:@selector(createBaseHeadAndFootViewHeight)]) {
    CGFloat cellHeight = gZLStandStructureBaseViewMsgSendGetCreateBaseHeadAndFootViewHeight(headViewClazz, NSSelectorFromString(@"createBaseHeadAndFootViewHeight"));
    return cellHeight;
  }
  NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetBaseHeadAndFootViewReuseIdentifier(headViewClazz, NSSelectorFromString(@"baseHeadAndFootViewReuseIdentifier"));
  if (identifier.length == 0 ||identifier == nil) {
    if (model.headBaseSectionHeight > 0) {
      return model.headBaseSectionHeight;
    }
    return  0.001;
  }
  GZLStandStructureBaseHeadAndFootView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];

  if (!headView) {
    headView = objc_gZLStandStructureBaseViewMsgSendCreateBaseHeadAndFootViewWithSection(headViewClazz, NSSelectorFromString(@"createBaseHeadAndFootViewWithSection:"), section);
    headView.delegate = self;
  }
  //update
  [headView updateBaseHeadAndFootViewWithModel:&model section:section];
  //calculate
  NSLayoutConstraint *calculateCellConstraint = [NSLayoutConstraint constraintWithItem:headView.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.bounds.size.width];
  NSLayoutConstraint *calculateCellConstraintHeight = [NSLayoutConstraint constraintWithItem:headView.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:headView.bounds.size.height];
  [headView.contentView addConstraint:calculateCellConstraint];
  [headView.contentView addConstraint:calculateCellConstraintHeight];
  CGSize headViewSize = [headView.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  [headView.contentView removeConstraint:calculateCellConstraint];
  return headViewSize.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  GZLStandStructureBaseCellModel *model = _dataList[section];

  Class footViewClazz =  NSClassFromString(model.footViewCellClass);
  if ([(id)footViewClazz respondsToSelector:@selector(createBaseHeadAndFootViewHeight)]) {
    CGFloat cellHeight = gZLStandStructureBaseViewMsgSendGetCreateBaseHeadAndFootViewHeight(footViewClazz, NSSelectorFromString(@"createBaseHeadAndFootViewHeight"));
    return cellHeight;
  }

  NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetBaseHeadAndFootViewReuseIdentifier(footViewClazz, NSSelectorFromString(@"baseHeadAndFootViewReuseIdentifier"));
  if (identifier.length == 0 ||identifier == nil) {
    if (model.footBaseSectionHeight > 0) {
      return model.footBaseSectionHeight;
    }
    return  0.001;
  }
  GZLStandStructureBaseHeadAndFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
  if (!footView) {
    footView = objc_gZLStandStructureBaseViewMsgSendCreateBaseHeadAndFootViewWithSection(footViewClazz, NSSelectorFromString(@"createBaseHeadAndFootViewWithSection:"), section);
    footView.delegate = self;
  }
  //update
  [footView updateBaseHeadAndFootViewWithModel:&model section:section];
  //calculate
  NSLayoutConstraint *calculateCellConstraint = [NSLayoutConstraint constraintWithItem:footView.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.bounds.size.width];
  NSLayoutConstraint *calculateCellConstraintHeight = [NSLayoutConstraint constraintWithItem:footView.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:footView.bounds.size.height];
  [footView.contentView addConstraint:calculateCellConstraint];
  [footView.contentView addConstraint:calculateCellConstraintHeight];
  CGSize footViewSize = [footView.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  [footView.contentView removeConstraint:calculateCellConstraint];
  return footViewSize.height;
}


#pragma mark -------------------
#pragma mark scrollViewDelegate
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
  if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
    [self.delegate scrollViewWillBeginDragging:scrollView];
  }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
    [self.delegate scrollViewDidEndDecelerating:scrollView];
  }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
    [self.delegate scrollViewWillBeginDragging:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
    [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
  }
};

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [self.delegate scrollViewDidScroll:scrollView];
  }
}
#pragma mark -------------------
#pragma mark GZLStandStructureBaseViewProtocol
-(void)gZLStandStructureBaseCellNeedsReload:(NSIndexPath *)indexPath{

  if ([self.delegate respondsToSelector:@selector(gZLStandStructureBaseCellNeedsReload:)]) {
    [self.delegate gZLStandStructureBaseCellNeedsReload:indexPath];
  }else{
    [UIView performWithoutAnimation:^{ // 解决刷新跳动问题
      [_mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
  }

}

-(void)gZLStandStructureBaseCellNeedsReloadSection:(NSIndexPath *)indexPath{
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureBaseCellNeedsReloadSection:)]) {
    [self.delegate gZLStandStructureBaseCellNeedsReloadSection:indexPath];
  }else{
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [UIView performWithoutAnimation:^{
      [_mainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }];
  }

}


-(void)gZLStandStructureBaseCellDidClickWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath{

  if ([self.delegate respondsToSelector:@selector(gZLStandStructureBaseCellDidClickWithParameter:withIndexPath:)]) {
    [self.delegate gZLStandStructureBaseCellDidClickWithParameter:parameter withIndexPath:indexPath];
  }
}

-(void)gZLStandStructureBaseCellNeedsScrollToCell:(UITableViewCell *)cell atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated Reload:(NSIndexPath *)indexPath{
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureBaseCellNeedsScrollToCell:atScrollPosition:animated:Reload:)]) {
    [self.delegate gZLStandStructureBaseCellNeedsScrollToCell:cell atScrollPosition:scrollPosition animated:animated Reload:indexPath];
  }else{
    [_mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
  }
}

-(void)gZLStandStructureBaseCellCallBcakWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath{
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureBaseCellCallBcakWithParameter:withIndexPath:)]) {
    [self.delegate gZLStandStructureBaseCellCallBcakWithParameter:parameter withIndexPath:indexPath];
  }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  if ([self.delegate respondsToSelector:@selector(gZLStandStructureTableView:willDisplayCell:forRowAtIndexPath:)]) {
    [self.delegate gZLStandStructureTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
  }
}
#pragma mark -------------------
#pragma mark 基础设置
-(void)setDataList:(NSArray *)dataList performWithoutAnimation:(BOOL)animat{
  _dataList =  dataList;
  if (animat) {
    [UIView performWithoutAnimation:^{
      [self.mainTableView reloadData];
    }];
  }
}

-(void)setDataList:(NSArray *)dataList{
  _dataList = dataList;
  if (dataList.count == 0) {
    return;
  }
  [UIView performWithoutAnimation:^{
    [self.mainTableView reloadData];
  }];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
  _mainTableView.backgroundColor = backgroundColor;
}

-(void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle{
  _separatorStyle = separatorStyle;
  _mainTableView.separatorStyle = separatorStyle;
}
-(void)setSeparatorColor:(UIColor *)separatorColor{
  _separatorColor = separatorColor;
  _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  _mainTableView.separatorColor = separatorColor;
}

-(void)setContentInset:(UIEdgeInsets)contentInset{
  _contentInset = contentInset;
  _mainTableView.contentInset = contentInset;
}



-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  return YES;
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
  if (_mainTableView == nil) {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsZero;
    if (!self.iSNotEstimatedRowHeight) {
      tableView.rowHeight = UITableViewAutomaticDimension;
      tableView.estimatedRowHeight = 44.0;//推测高度，必须有，可以随便写多少
      tableView.estimatedSectionHeaderHeight = 0;
      tableView.estimatedSectionFooterHeight = 0;
      //            tableView.estimatedRowHeight = 0;
    }else{
      tableView.estimatedSectionHeaderHeight = 0;
      tableView.estimatedSectionFooterHeight = 0;
    }
    [self addSubview:tableView];
    _mainTableView = tableView;
  }
  return _mainTableView;
}
#pragma mark -------------------
#pragma mark private method
-(NSMutableDictionary *)templateCellDict{
  if (!_templateCellDict) {
    _templateCellDict = [NSMutableDictionary dictionary];
  }
  return _templateCellDict;
}
-(NSMutableDictionary *)templateCellIsLoadModelDict{
  if (!_templateCellIsLoadModelDict) {
    _templateCellIsLoadModelDict = [NSMutableDictionary dictionary];
  }
  return _templateCellIsLoadModelDict;
}
-(NSMutableDictionary *)templateHeadAndFootViewDict{
  if (!_templateHeadAndFootViewDict) {
    _templateHeadAndFootViewDict = [NSMutableDictionary dictionary];
  }
  return _templateHeadAndFootViewDict;
}


@end

