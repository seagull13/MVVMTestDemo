//
//  GZLStandStructureBaseHeadAndFootView.h
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/15.
//

#import <UIKit/UIKit.h>


@class GZLStandStructureBaseCellModel;
@class GZLStandStructureBaseCell;
@protocol GZLStandStructureBaseHeadAndFootViewDelegate <NSObject>
@optional

@end

@interface GZLStandStructureBaseHeadAndFootView : UITableViewHeaderFooterView
@property (weak, nonatomic) id<GZLStandStructureBaseHeadAndFootViewDelegate> delegate;
+ (NSString *)baseHeadAndFootViewReuseIdentifier;
+ (instancetype)createBaseHeadAndFootViewWithSection:(NSInteger)section;
- (void)updateBaseHeadAndFootViewWithModel:(GZLStandStructureBaseCellModel **)model section:(NSInteger )section ;

+ (CGFloat)createBaseHeadAndFootViewHeight;


/** baseMdoel */
@property(nonatomic,strong)GZLStandStructureBaseCellModel  *baseModel;
@end
