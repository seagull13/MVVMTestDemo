//
//  GZLStandStructureBaseHeadAndFootView.m
//  GZLApp
//
//  Created by JiangNanBuYi on 2017/12/15.
//

#import "GZLStandStructureBaseHeadAndFootView.h"
#import "GZLStandStructureBaseCellModel.h"
@implementation GZLStandStructureBaseHeadAndFootView
+ (NSString *)baseHeadAndFootViewReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

+ (instancetype)createBaseHeadAndFootViewWithSection:(NSInteger)section{
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return nil;
}

- (void)updateBaseHeadAndFootViewWithModel:(GZLStandStructureBaseCellModel *__autoreleasing *)model
                  section:(NSInteger)section {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
}

+ (CGFloat)createBaseHeadAndFootViewHeight{
    
    return 0.01;
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
@end
