//
//  MVVMSimpleViewModel.m
//  TestTableView
//
//  Created by 江南布衣 on 2019/4/3.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "MVVMSimpleViewModel.h"
#import "MVVMSimpleModel.h"
@interface MVVMSimpleViewModel ()

@property (nonatomic, strong) MVVMSimpleModel *model;

@property (nonatomic, assign) BOOL            isClick;

@end

@implementation MVVMSimpleViewModel
-(void)bindModel:(id)model{
    self.model = model;
    self.nameString = self.model.name;
    
}
-(void)changeButtonTextAction{
    _isClick = !_isClick;
    NSString *name = @"";
    switch (arc4random_uniform(6)) {
        case 0:
            name = @"欧小阳";
            break;
        case 1:
             name = @"欧阳";
            break;
        case 2:
             name = @"殴打小朋友";
            break;
        case 3:
//             name = @"陈小姐";
            break;
        case 4:
//             name = @"陈姑娘";
            break;
        case 5:
             name = @"喜欢";
            break;
        default:
            break;
    }
    
    if(_isClick){
        self.model.name = @"火之玉";
    }else{
        self.model.name = @"欧大侠";
    }
    self.model.name = name;
    self.nameString = self.model.name;
}

@end
