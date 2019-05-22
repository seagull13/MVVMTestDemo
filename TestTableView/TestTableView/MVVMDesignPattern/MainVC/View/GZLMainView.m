//
//  GZLMainView.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainView.h"
#import "Masonry.h"
#import "GZLMainVCDataViewModel.h"

@interface GZLMainView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/***ViewModel  */
@property(nonatomic,strong) GZLMainVCDataViewModel *viewModel;
/*** collectionView  */
@property(nonatomic,strong)UICollectionView  *mainCollectionView;
@end

typedef NS_ENUM(NSUInteger, MainViewType) {
    MainViewTypeAD = 0,
    MainViewTypeTravel = 1,
    MainViewTypeFreedomTravel,
    MainViewTypeJD,
    MainViewTypeVisa,
};

@implementation GZLMainView
#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpGZLMainView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpGZLMainView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

#pragma mark - 初始化
- (void)setUpGZLMainView{
    self.backgroundColor = UIColor.whiteColor;
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark bindViewModel
-(void)bindViewModel:(id)viewModel{
    if ([viewModel isKindOfClass:GZLMainVCDataViewModel.class]) {
        self.viewModel = viewModel;
        [self.mainCollectionView reloadData];
    }else{

    }
}

#pragma mark Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return MainViewTypeVisa + 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger items = 0;
    GZLBaseContenModel *model = self.viewModel.baseModel.content;
    switch (section) {
        case MainViewTypeAD:
//            items = model.rotateAdsVos.count > 0 ? 1 : 0;
            break;
        case MainViewTypeTravel:
            items = model.homeCatalogList.productGroup.count;
            break;
        case MainViewTypeFreedomTravel:
            items = model.homeCatalogList.fixedFreeTravel.count;
            break;
        case MainViewTypeJD:
            items = model.homeCatalogList.hotel.count;
            break;
        case MainViewTypeVisa:
            items = model.homeCatalogList.ticketVisaCruise.count;
            break;

        default:
            break;
    }
    return items;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell<MVVMBindViewModelProtocol> *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GZLMainHomeCatalogCelll" forIndexPath:indexPath];
    HomeCatalogList *homeCatalogList = self.viewModel.baseModel.content.homeCatalogList;
    switch (indexPath.section) {
        case MainViewTypeAD:

            break;
        case MainViewTypeTravel:
            [cell bindViewModel:homeCatalogList.productGroup[indexPath.item]];
            break;
        case MainViewTypeFreedomTravel:
            [cell bindViewModel:homeCatalogList.fixedFreeTravel[indexPath.item]];
            break;
        case MainViewTypeJD:
            [cell bindViewModel:homeCatalogList.hotel[indexPath.item]];
            break;
        case MainViewTypeVisa:
            [cell bindViewModel:homeCatalogList.ticketVisaCruise[indexPath.item]];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    switch (indexPath.section) {
        case MainViewTypeAD:
            break;
        case MainViewTypeTravel:
            if (indexPath.item == 0) {
                 itemSize = CGSizeMake(ceilf(([UIScreen mainScreen].bounds.size.width  - 12 - 3)  / 3.0), 146);
            }else{
                 itemSize = CGSizeMake(ceilf(([UIScreen mainScreen].bounds.size.width  - 12 - 3)  / 3.0), 70);
            }
            break;
        case MainViewTypeFreedomTravel:
        case MainViewTypeJD:
        case MainViewTypeVisa:
            itemSize = CGSizeMake(ceilf(([UIScreen mainScreen].bounds.size.width  - 12 - 3)  / 3.0), 70);
            break;
        default:
            break;
    }
    return itemSize;
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return CGSizeMake(0, 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 6, 0, 6);
}
/**
 这里我用代理设置以下间距 感兴趣可以自己调整值看看差别
 */
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}


#pragma mark  懒加载
- (UICollectionView *)mainCollectionView{

    if (_mainCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection  = UICollectionViewScrollDirectionVertical;
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = UIColor.whiteColor;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        NSArray *dataModelArray = @[@"GZLMainHomeCatalogCelll",];
        for (NSString *cellClassName in dataModelArray) {
            [_mainCollectionView registerClass:NSClassFromString(cellClassName) forCellWithReuseIdentifier:cellClassName];
        }
        [self addSubview:_mainCollectionView];
    }
    return _mainCollectionView;
}


@end
