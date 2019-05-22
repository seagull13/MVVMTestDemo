//
//  GZLMainVC.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "GZLMainVC.h"
#import "GZLMainVCDataViewModel.h"
#import "GZLMainView.h"
#import <Masonry/Masonry.h>
@interface GZLMainVC ()
/** *  viewModel */
@property(nonatomic,strong)GZLMainVCDataViewModel  *mainViewModel;
/** *  mainView */
@property(nonatomic,strong)GZLMainView  *mainView;
@end
@implementation GZLMainVC
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseUI];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)dealloc{
    [self removeMVVMObserve];
    NSLog(@"%s", __func__);
}
-(void)removeMVVMObserve{
    [self.mainViewModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(baseModel))];
    [self.mainViewModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(recomandModel))];
}
-(void)addMVVMObserve{
    [self.mainViewModel addObserver:self forKeyPath:NSStringFromSelector(@selector(baseModel)) options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:nil];
    [self.mainViewModel addObserver:self forKeyPath:NSStringFromSelector(@selector(recomandModel)) options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:nil];
}
#pragma mark - 初始化
- (void)setupBaseUI{
    self.view.backgroundColor = UIColor.whiteColor;
    [self addMVVMObserve];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self.mainView bindViewModel:self.mainViewModel];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 代理
#pragma mark -
#pragma mark - Action
#pragma mark - 懒加载
-(GZLMainVCDataViewModel *)mainViewModel{
    if (!_mainViewModel) {
        _mainViewModel = [[GZLMainVCDataViewModel alloc]init];
    }return _mainViewModel;
}

-(GZLMainView *)mainView{
    if (!_mainView) {
        _mainView = [[GZLMainView alloc]init];
        [self.view addSubview:_mainView];
        [_mainView bindViewModel:self.mainViewModel];
    }return _mainView;
}
@end
