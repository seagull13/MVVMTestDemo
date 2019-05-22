//
//  MVVMSimpleVC.m
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "MVVMSimpleVC.h"
#import "MVVMSimpleView.h"
#import "MVVMSimpleViewModel.h"
#import "MVVMSimpleModel.h"
@interface MVVMSimpleVC ()

/** *  MVVMSimpleView */
@property(nonatomic,strong)MVVMSimpleView  *simpleView;

@end
@implementation MVVMSimpleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建视图
    [self.view addSubview:self.simpleView];
    self.simpleView.frame = self.view.bounds;
    
    MVVMSimpleModel *model = [[MVVMSimpleModel alloc]init];
    //初始化
    model.name = @"欧耶";
    /*绑定关系*/
    //viewModel绑定model
    MVVMSimpleViewModel *simpleViewModel = [[MVVMSimpleViewModel alloc]init];
    [simpleViewModel  bindModel:model];
    //view绑定viewModel
    [self.simpleView bindViewModel:simpleViewModel];
    // Do any additional setup after loading the view.
}
-(MVVMSimpleView *)simpleView{
    if (!_simpleView ) {
        MVVMSimpleView *simpleView = [[MVVMSimpleView alloc]init];
        _simpleView = simpleView;
    }return _simpleView;
}
@end
