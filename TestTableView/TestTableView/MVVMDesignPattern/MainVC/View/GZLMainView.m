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
@interface GZLMainView ()
/***ViewModel  */
@property(nonatomic,strong) GZLMainVCDataViewModel *viewModel;
/*** collectionView  */
@property(nonatomic,strong)UICollectionView  *mainCollectionView;

@end
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

}

#pragma mark bindViewModel
-(void)bindViewModel:(id)viewModel{
    if ([viewModel isKindOfClass:GZLMainVCDataViewModel.class]) {
        self.viewModel = viewModel;
    }else{

    }
}

#pragma mark  懒加载
- (UICollectionView *)mainCollectionView{

    if (_mainCollectionView == nil) {
        _mainCollectionView = [[UICollectionView alloc]init];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        NSArray *dataModelArray = @[@"GZLMainPageControlViewCell", @"MainGTViewCell", @"GZLMainZYXViewCell", @"GZLMainJDViewCell", @"GZLMainQZYLPQViewCell", @"MainQTViewCell", @"GZLMainNewViewCell", @"GZLMainTJViewCell", @"GZLMainMSViewCell", @"GZLMainADViewCell", @"MainHotPlaceViewCell", @"GZLMainRMSectionViewCell", @"GZLAllChanelsListDetailCell"];
        for (NSString *cellClassName in dataModelArray) {
            [_mainCollectionView registerClass:NSClassFromString(cellClassName) forCellWithReuseIdentifier:cellClassName];
        }
        [self addSubview:_mainCollectionView];
    }
    return _mainCollectionView;
}


@end
