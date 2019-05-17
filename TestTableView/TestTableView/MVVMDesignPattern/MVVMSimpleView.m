//
//  MVVMSimpleView.m
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "MVVMSimpleView.h"
#import "MVVMSimpleViewModel.h"
@interface MVVMSimpleView ()
/** *  名字按钮  */
@property(nonatomic,strong)UIButton  *nameButton;
/** *  viewModel */
@property(nonatomic,strong)MVVMSimpleViewModel  *viewModel;
@end

@implementation MVVMSimpleView

- (instancetype)init
{
    self = [super init];
    if(self){
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor whiteColor];
        self.nameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _nameButton.frame = CGRectMake(0, 0, 100, 50);
        _nameButton.center = CGPointMake(self.frame.size.width / 2.0, (self.frame.size.height / 3.0 * 1));
        _nameButton.backgroundColor = [UIColor orangeColor];
        [_nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nameButton addTarget:self action:@selector(nameButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nameButton];
    }
    return self;
}
//按钮点击方法
- (void)nameButtonAction
{
    if(self.viewModel){
        [self.viewModel changeButtonTextAction];
        [self.nameButton setTitle:self.viewModel.nameString forState:UIControlStateNormal];
    }
}
//绑定viewModel
- (void)bindViewModel:(id)viewModel
{
    self.viewModel = viewModel;
    [self.nameButton setTitle:self.viewModel.nameString forState:UIControlStateNormal];

}
@end
