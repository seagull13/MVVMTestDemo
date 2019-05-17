//
//  TextExampleCell.m
//  TestTableView
//
//  Created by JiangNanBuYi on 2019/5/16.
// Copyright Guangzhou guangzhi travel international travel agency co. LTD. All rights reserved.
//

#import "TextExampleCell.h"
#import "TextStandCellModel.h"
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>
@interface TextExampleCell ()

/** *  */
@property(nonatomic,strong)YYLabel  *nameLabel;
/** *  */
@property(nonatomic,strong)YYLabel  *desLabel;
/** *  */
@property(nonatomic,strong)UIButton   *btn;
/** *   */
@property(nonatomic,strong)TextStandCellModel  *standModel;
@end
@implementation TextExampleCell


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

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

+ (NSString *)cellReuseIdentifier {
    return  NSStringFromClass([self class]);
}
#pragma mark - 初始化
- (void)cellLayout{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(16);
        make.right.mas_equalTo(self.contentView).offset(-16);
    }];

    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.left.mas_equalTo(self.nameLabel);
    }];

    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.desLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.desLabel);
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.bottom.mas_equalTo(self.contentView).offset(-16);
    }];
}

#pragma mark - 模型处理
- (void)updateCellWithModel:(GZLStandStructureBaseCellModel  *)model indexPath:(NSIndexPath *)indexPath {
    GZLStandStructureBaseCellModel *baseModel = model;
    self.indexPath = indexPath;
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
        self.standModel = cellModel;
        if (cellModel.sel.length > 0) {
            self.textLabel.text = [NSString stringWithFormat:@"描述: %@ \n方法调用:%@",cellModel.name,cellModel.sel];
        }else{
//            self.textLabel.text = [NSString stringWithFormat:@"姓名: %@ \n身高: %.2f,体重: %.2f",cellModel.name,cellModel.height,cellModel.weight];
            self.nameLabel.attributedText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"姓名: %@ ",cellModel.name] attributes:@{NSForegroundColorAttributeName:cellModel.textColor,NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightBold]}];
            self.desLabel.text = [NSString stringWithFormat:@"身高: %.2f,体重: %.2f",cellModel.height,cellModel.weight];
            self.nameLabel.textColor = cellModel.textColor;
            self.desLabel.textColor = cellModel.textColor;
        }
//        self.textLabel.numberOfLines = 0;
        self.nameLabel.numberOfLines = 0;
        self.desLabel.numberOfLines = 0;

        self.nameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 32;
        self.desLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 32;

//        self.textLabel.textColor = cellModel.textColor;
        [self.btn setTitleColor:cellModel.textColor forState:UIControlStateNormal];
//        _btn.layer.borderColor = cellModel.textColor.CGColor;
//        self.userInteractionEnabled = cellModel.sel.length > 0;
    }
}
#pragma mark - Action
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)changeClick{
    [self.standModel dealTextStandCellModel];
    //
    if ([self.delegate respondsToSelector:@selector(oyStructureTableViewCellNeedsReload:)]) {
        [self.delegate oyStructureTableViewCellNeedsReload:self.indexPath];
    }

}

#pragma mark - 懒加载
-(YYLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[YYLabel alloc]init];
        _nameLabel.displaysAsynchronously = YES;
        //        [_nameLabel sizeToFit];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(YYLabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[YYLabel alloc]init];
        _desLabel.displaysAsynchronously = YES;
//         [_desLabel sizeToFit];
        [self.contentView addSubview:_desLabel];
    }
    return _desLabel;
}
-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        _btn.layer.cornerRadius = 4;
        _btn.layer.borderWidth = 1;
        [self.contentView addSubview:_btn];
        [_btn  addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
