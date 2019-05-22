//
//  GZLAPIBaseManager.h
//  GZLApp
//
//  Created by moxuyou on 2017/4/20.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <UIKit/UIKit.h>
#import "GZLNetWorkCacheManger.h"

@class GZLAPIBaseManager;

typedef NS_ENUM (NSUInteger, CTAPIManagerRequestType){
    CTAPIManagerRequestTypeGet,
    CTAPIManagerRequestTypePost,
    CTAPIManagerRequestTypePut,
    CTAPIManagerRequestTypeDelete
};

//请求回调
@protocol CTAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(GZLAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(GZLAPIBaseManager *)manager;
@end


//在reformer处理请求回来的数据
@protocol CTAPIManagerDataReformer <NSObject>
@required
- (id)manager:(GZLAPIBaseManager *)manager reformData:(NSDictionary *)data;
@end


//让manager能够获取调用API所需要的数据
@protocol CTAPIManagerParamSource <NSObject>
@required
- (NSDictionary *)paramsForApi:(GZLAPIBaseManager *)manager;
@end

/*
 GZLAPIBaseManager的派生类必须符合这些protocal
 */
@protocol CTAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (NSString *)urlPath;
- (CTAPIManagerRequestType)requestType;
//- (BOOL)shouldCache;

@optional
//调试方法,可查看API的请求URL，参数，和返回数据，方便调试接口
- (void)APITestMethod:(NSString *)urlString params:(NSDictionary *)params date:(id)requestData;

@end

@interface GZLAPIBaseManager : NSObject<CTAPIManager>


@property (nonatomic, weak) id<CTAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<CTAPIManagerParamSource> paramSource;
//@property (nonatomic, weak) id<CTAPIManagerValidator> validator;//暂时不用
@property (nonatomic, weak) NSObject<CTAPIManager> *child; //里面会调用到NSObject的方法，所以这里不用id
//@property (nonatomic, weak) id<CTAPIManagerInterceptor> interceptor;
@property (nonatomic, strong) id fetchedRawData;
@property (nonatomic, strong) NSError *errorData;
/** 用于显示遮盖的View */
@property (weak, nonatomic)UIView *hudView;
/** 是否正在加载数据 */
@property (assign, nonatomic)BOOL isLoading;
/** 缓存存放的目录 */
@property(nonatomic,assign) NSCacheFileNameType fileNameType;
/** 是否需要缓存 */
@property (assign, nonatomic)BOOL ifCache;
/** 是否需要签名 */
@property (assign, nonatomic)BOOL isSignature;
/** 是否显示错误信息 */
@property (assign, nonatomic)BOOL ifShowErronInfo;
/** 登录信息过期是否不弹登录界面 YES 不弹 NO 弹 */
@property (assign, nonatomic)BOOL noGoLoginPage;
/** 是否传递json类型的数据 */
@property (assign, nonatomic)BOOL jsonParams;
//这个方法用来获取处理后的数据
- (id)fetchDataWithReformer:(id<CTAPIManagerDataReformer>)reformer;

//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

-(instancetype)initSettingDelegateAndParamSource:(id)obj;
/** 取消之前的网络请求 */
- (void)cancelRequestBefore;

@end
