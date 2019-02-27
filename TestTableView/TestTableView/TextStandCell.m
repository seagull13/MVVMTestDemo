//
//  TextStandCell.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//

#import "TextStandCell.h"
#import "TextStandCellModel.h"
@interface TextStandCell ()


@end
@implementation TextStandCell


#pragma mark - 系统方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cellLayout];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if ( self) {
        [self cellLayout];
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self cellLayout];
    return self;
}

+(CGFloat)cellHeight{
  return 44;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (NSString *)cellReuseIdentifier {
    return  NSStringFromClass([self class]);
}
#pragma mark - 初始化
- (void)cellLayout{

}

#pragma mark - 模型处理
- (void)updateCellWithModel:(GZLStandStructureBaseCellModel *__autoreleasing *)model indexPath:(NSIndexPath *)indexPath {
    //    [super updateCellWithModel:model indexPath:indexPath];
    GZLStandStructureBaseCellModel *baseModel = *model;
    if (baseModel == nil) {
        return;
    }
    id tempDataModel = baseModel.itemList[indexPath.row];
    if (tempDataModel == nil) {
        return;
    }
    [self  dealDataWithDataModel:tempDataModel];
    
}
-(void)dealDataWithDataModel:(id)tempDataModel{
  if ([tempDataModel isKindOfClass:TextStandCellModel.class]) {
    TextStandCellModel  *cellModel  = tempDataModel;
    self.textLabel.text = [NSString stringWithFormat:@"姓名: %@ \n身高: %.2f,体重: %.2f",cellModel.name,cellModel.height,cellModel.weight];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = cellModel.textColor;
  }
}
#pragma mark - Action
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 懒加载


@end
