//
//  GZLMainView.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/21.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainView.h"
#import "Masonry.h"
@interface GZLMainView ()

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




@end
