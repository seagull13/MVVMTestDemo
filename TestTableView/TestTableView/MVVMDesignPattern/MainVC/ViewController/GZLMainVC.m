//
//  GZLMainVC.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "GZLMainVC.h"
#import "GZLMainVCDataViewModel.h"
@interface GZLMainVC ()
/** *  viewModel */
@property(nonatomic,strong)GZLMainVCDataViewModel  *mainViewModel;

@end
@implementation GZLMainVC
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseUI];
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
    [self.mainViewModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(baseModel))];
    [self.mainViewModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(recomandModel))];
    NSLog(@"%s", __func__);
}


#pragma mark - 初始化
- (void)setupBaseUI{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.mainViewModel addObserver:self forKeyPath:NSStringFromSelector(@selector(baseModel)) options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:nil];
    [self.mainViewModel addObserver:self forKeyPath:NSStringFromSelector(@selector(recomandModel)) options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(baseModel))]) {

        [self test];
    }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(recomandModel))]){
        [self test];
    }
}
-(void)test{
    GZLMainBaseDataModel *model = self.mainViewModel.baseModel;
    self.view.backgroundColor = UIColor.redColor;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
#pragma mark - 数据源
#pragma mark - 

#pragma mark - 代理
#pragma mark -


#pragma mark - 通知


#pragma mark - Action
#pragma mark - 懒加载

-(GZLMainVCDataViewModel *)mainViewModel{
    if (!_mainViewModel) {
        _mainViewModel = [[GZLMainVCDataViewModel alloc]init];
    }return _mainViewModel;
}
@end
