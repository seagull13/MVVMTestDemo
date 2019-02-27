//
//  GZLStandStructureBaseCell.m
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/1.
// Copyright © 2017年 moxuyou. All rights reserved.
//

#import "GZLStandStructureBaseCell.h"



@interface  GZLStandStructureBaseCell()
///** indexPath */
//@property(nonatomic,strong)NSIndexPath  *indexPath;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation GZLStandStructureBaseCell
#pragma clang diagnostic pop

+ (NSString *)cellReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath WithTableView:(UITableView *)tableView{
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

- (void)updateCellWithModel:(GZLStandStructureBaseCellModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
//    self.indexPath = indexPath;
//    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerNotification];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self registerNotification];
    return self;
}

- (void)dealloc {
    [self resignNotification];
  
    
}

- (void)resetData {
    
}

- (void)registerNotification {

}

- (void)resignNotification {
   
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return  self;
}
@end
