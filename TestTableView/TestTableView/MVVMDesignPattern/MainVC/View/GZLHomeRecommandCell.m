//
//  GZLHomeRecommandCell.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/23.
// Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLHomeRecommandCell.h"
#import <Masonry/Masonry.h>

#import <SDWebImage.h>
#import "GZLMainBaseDataModel.h"
#import "Masonry.h"
@interface GZLHomeRecommandCell()
/** *  */
@property(nonatomic,strong)UIImageView  *catalogImageV;
/** *  */
@property(nonatomic,strong)UILabel     *textLabel;

@end
@implementation GZLHomeRecommandCell

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

    [self.catalogImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.mas_equalTo(5);
    }];

    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.catalogImageV.mas_bottom).mas_offset(3);
        make.centerX.mas_equalTo(self.contentView);
    }];

}

-(void)bindViewModel:(id)viewModel{
    if ([viewModel isKindOfClass:Hotel.class]) {
        Hotel *model = viewModel;
        [self.catalogImageV sd_setImageWithURL:[NSURL URLWithString:model.pic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.catalogImageV.image = image;
        }];
    }else if ([viewModel isKindOfClass:RotateAdsVos.class]){
        RotateAdsVos *model = viewModel;
        [self.catalogImageV sd_setImageWithURL:[NSURL URLWithString:model.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.catalogImageV.image = image;
            [self.catalogImageV sizeToFit];
        }];
        self.textLabel.text = model.title;
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

-(UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
@end
