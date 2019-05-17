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
#import "OYStructureTableViewProtocol.h"
#import "objc/runtime.h"
#import "objc/message.h"
#import <UITableView+FDTemplateLayoutCell.h>
id (*objc_gZLStandStructureBaseViewMsgSendGetCellIdentifier)(id self, SEL _cmd) = (void *) objc_msgSend;
CGFloat (*gZLStandStructureBaseViewMsgSendGetCellHeight)(id self, SEL _cmd) = (void *) objc_msgSend;
id (*objc_gZLStandStructureBaseViewMsgSendCreateCellWithIndexPath)(id self, SEL _cmd, NSIndexPath *,UITableView *) = (void *)objc_msgSend;
id (*objc_gZLStandStructureBaseViewMsgSendGetBaseHeadAndFootViewReuseIdentifier)(id self, SEL _cmd) = (void *) objc_msgSend;
CGFloat (*gZLStandStructureBaseViewMsgSendGetCreateBaseHeadAndFootViewHeight)(id self, SEL _cmd) = (void *) objc_msgSend;
id (*objc_gZLStandStructureBaseViewMsgSendCreateBaseHeadAndFootViewWithSection)(id self, SEL _cmd, NSInteger ) = (void *)objc_msgSend;
@interface GZLStandStructureBaseView ()<OYStructureTableViewProtocol,UITableViewDataSource,UITableViewDelegate,GZLStandStructureBaseHeadAndFootViewDelegate>
/** 是否需要 自动计算预估行高*/
@property(nonatomic,assign) BOOL  iSNotEstimatedRowHeight;
@end
@implementation GZLStandStructureBaseView

#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame{
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
-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    if (dataList.count == 0)  return;
    [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GZLStandStructureBaseCellModel *model = obj;
        if (model.multipleDifferentCells) {
            [model.containerCellClassArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.mainTableView registerClass:NSClassFromString(obj) forCellReuseIdentifier:obj];
            }];
        }else{
            [self.mainTableView registerClass:NSClassFromString(model.containerCellClass) forCellReuseIdentifier:model.containerCellClass];
        }
    }];
    [UIView performWithoutAnimation:^{
        [self.mainTableView reloadData];
    }];
}
#pragma mark -------------------
#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GZLStandStructureBaseCellModel *model = _dataList[section];
    return model.multipleDifferentCells ? model.containerCellClassArray.count : model.itemList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataList.count;
}
#pragma mark -------------------
#pragma mark 加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.首先看外界的代理是否实现了 加载cell的数据源的方法
    if ([self.delegate respondsToSelector:@selector(oyStructureTableView:cellForRowAtIndexPath:)]) {
        return   [self.delegate oyStructureTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    GZLStandStructureBaseCellModel *model = _dataList[indexPath.section];
    id cell = [tableView dequeueReusableCellWithIdentifier:objc_gZLStandStructureBaseViewMsgSendGetCellIdentifier([self getCellClassNameWithIndexPath:indexPath], @selector(cellReuseIdentifier))];
    ((GZLStandStructureBaseCell *)cell).delegate = self;
    ((GZLStandStructureBaseCell *)cell).fd_isTemplateLayoutCell = YES;
    //4.比对模型 假如模型数据发生变化 则进入更新数据源
    [((GZLStandStructureBaseCell *)cell) updateCellWithModel:model indexPath:indexPath];
    return ((GZLStandStructureBaseCell *)cell);
}

-(Class)getCellClassNameWithIndexPath:(NSIndexPath *)indexPath{
    Class cellClazz ;
    //2.防止数组越界
    if (indexPath.section >  _dataList.count - 1  ) {
        @throw [NSException exceptionWithName:@"数据源数据越界" reason:@"indexPath.section >  _dataList.count - 1 " userInfo:nil];
        return cellClazz;
    }
    //正常数据
    GZLStandStructureBaseCellModel *model = _dataList[indexPath.section];
    //1.加载cell 的类名
    if (model.multipleDifferentCells) {
        //2.防止数组越界
        if (indexPath.row > model.containerCellClassArray.count - 1 ) {
            @throw [NSException exceptionWithName:@"数据源数据越界" reason:@"indexPath.row > model.containerCellClassArray.count - 1 " userInfo:nil];
            return cellClazz;
        }
        cellClazz = NSClassFromString( model.containerCellClassArray[indexPath.row]);
    }else{
        cellClazz = NSClassFromString(model.containerCellClass);
    }
    return cellClazz;
}
#pragma mark -------------------
#pragma mark 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.是否外界设置代理回调
    if ([self.delegate respondsToSelector:@selector(oyStructureTableView:heightForRowAtIndexPath:)]) {
        CGFloat height = [self.delegate oyStructureTableView:tableView heightForRowAtIndexPath:indexPath];
        return  height;
    }
    GZLStandStructureBaseCellModel * model = _dataList[indexPath.section];
    NSString *identifier = objc_gZLStandStructureBaseViewMsgSendGetCellIdentifier([self getCellClassNameWithIndexPath:indexPath], @selector(cellReuseIdentifier));
    GZLStandStructureBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //3.是否开启自动计算行高
    __weak __typeof(model)weakModel = model;
    if (model.isAutoRowheight) {
        return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(GZLStandStructureBaseCell *cell) {
            @autoreleasepool {
                [cell updateCellWithModel:weakModel indexPath:indexPath];
            }
        }];
    }
    Class cellClass = [self getCellClassNameWithIndexPath:indexPath];
    //4.是否设置cell 的固定高度
    if ([(id)cellClass respondsToSelector:@selector(cellHeight)]) {
        CGFloat cellHeight = gZLStandStructureBaseViewMsgSendGetCellHeight([cellClass getCellClassNameWithIndexPath:indexPath], NSSelectorFromString(@"cellHeight"));
        return cellHeight;
    }
    [cell updateCellWithModel:weakModel indexPath:indexPath];
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
    if ([self.delegate respondsToSelector:@selector(oyStructureTableView:heightForHeaderInSection:)]) {
        return [self.delegate oyStructureTableView:tableView heightForHeaderInSection:section];
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
#pragma mark OYStructureTableViewProtocol
-(void)oyStructureTableViewCellNeedsReload:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(oyStructureTableViewCellNeedsReload:)]) {
        [self.delegate oyStructureTableViewCellNeedsReload:indexPath];
    }else{
        [UIView performWithoutAnimation:^{ // 解决刷新跳动问题
            [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }

}
-(void)oyStructureTableViewCellNeedsReloadSection:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(oyStructureTableViewCellNeedsReloadSection:)]) {
        [self.delegate oyStructureTableViewCellNeedsReloadSection:indexPath];
    }else{
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [UIView performWithoutAnimation:^{
            [self.mainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }];
    }

}

-(void)oyStructureTableViewCellDidClickWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(oyStructureTableViewCellDidClickWithParameter:withIndexPath:)]) {
        [self.delegate oyStructureTableViewCellDidClickWithParameter:parameter withIndexPath:indexPath];
    }
}

-(void)oyStructureTableViewCellNeedsScrollToCell:(UITableViewCell *)cell atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated Reload:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(oyStructureTableViewCellNeedsScrollToCell:atScrollPosition:animated:Reload:)]) {
        [self.delegate oyStructureTableViewCellNeedsScrollToCell:cell atScrollPosition:scrollPosition animated:animated Reload:indexPath];
    }else{
        [_mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    }
}

-(void)oyStructureTableViewCellCallBcakWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(oyStructureTableViewCellCallBcakWithParameter:withIndexPath:)]) {
        [self.delegate oyStructureTableViewCellCallBcakWithParameter:parameter withIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(oyStructureTableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate oyStructureTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
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
@end



