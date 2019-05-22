//
//  GZLMainHomeCatalogCelll.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/22.
// Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLMainHomeCatalogCelll.h"
#import <Masonry/Masonry.h>
#import <SDWebImage.h>
#import "GZLMainBaseDataModel.h"
@interface GZLMainHomeCatalogCelll()
/** *  */
@property(nonatomic,strong)UIImageView  *catalogImageV;
@end
@implementation GZLMainHomeCatalogCelll

#pragma mark - 系统方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cellLayout];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self cellLayout];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cellLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

#pragma mark - 初始化
- (void)cellLayout{
    self.backgroundColor =  UIColor.lightGrayColor;
    [self.catalogImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}

-(void)bindViewModel:(id)viewModel{
    if ([viewModel isKindOfClass:Hotel.class]) {
        Hotel *model = viewModel;
        [self.catalogImageV sd_setImageWithURL:[NSURL URLWithString:model.pic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.catalogImageV.image = image;
        }];
    }
}
#pragma mark - Action


#pragma mark - 懒加载
-(UIImageView *)catalogImageV{
    if(!_catalogImageV){
        _catalogImageV = [[UIImageView alloc]init];
        [self addSubview:_catalogImageV];
    }
    return _catalogImageV;
}

@end
