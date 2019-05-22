//
//  MVVMSimpleView.m
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "MVVMSimpleView.h"
#import "MVVMSimpleViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry.h>
@interface MVVMSimpleView ()
/** *  名字按钮  */
@property(nonatomic,strong)UIButton  *nameButton;
/** *  描述  */
@property(nonatomic,strong)UILabel  *desLabel;
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
        _nameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _nameButton.frame = CGRectMake(0, 0, 100, 50);
        _nameButton.center = CGPointMake(self.frame.size.width / 2.0, (self.frame.size.height / 3.0 * 1));
        _nameButton.backgroundColor = [UIColor orangeColor];
        [_nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nameButton addTarget:self action:@selector(nameButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nameButton];

        _desLabel = [[UILabel alloc]init];
        _desLabel.textColor = [UIColor blueColor] ;
        _desLabel.numberOfLines  = 0;
        _desLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 32;
        [self addSubview:_desLabel];
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(100);
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
        }];
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.desLabel.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
    }
    return self;
}
//按钮点击方法
- (void)nameButtonAction
{
    if(self.viewModel){
        [self.viewModel changeButtonTextAction];
        [self setModelData];

    }
}
//绑定viewModel
- (void)bindViewModel:(id)viewModel{
    self.viewModel = viewModel;
    [self setModelData];
}
-(void)setModelData{
    [self.nameButton setTitle:self.viewModel.nameString forState:UIControlStateNormal];
    self.desLabel.text = self.viewModel.desString;
    self.desLabel.numberOfLines = self.viewModel.isClick ? 0 : 2;
}
@end
