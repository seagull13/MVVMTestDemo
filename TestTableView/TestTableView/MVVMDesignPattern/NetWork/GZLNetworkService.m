//
//  GZLNetworkService.m
//  GZLApp
//
//  Created by moxuyou on 2017/6/22.
//  GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import "GZLNetworkService.h"
#import "CTServiceFactory.h"
#import "CTRequestGenerator.h"
#import "AFNetworking.h"
#import "CTLogger.h"
#import "NSURLRequest+CTNetworkingMethods.h"

static NSString * const kAXApiProxyDispatchItemKeyCallbackSuccess = @"kAXApiProxyDispatchItemCallbackSuccess";
static NSString * const kAXApiProxyDispatchItemKeyCallbackFail = @"kAXApiProxyDispatchItemCallbackFail";

@interface GZLNetworkService ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end
@implementation GZLNetworkService
#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
        [_sessionManager.requestSerializer setTimeoutInterval:15.f];
    }
    return _sessionManager;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static GZLNetworkService *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GZLNetworkService alloc] init];
    });
    return sharedInstance;
}
//
//- (void)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(SuccessCallback)success fail:(FailCallback)fail{
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_HTTPS_URL, methodName];
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    [self.sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        fail(error);
//    }];
//}
//
//- (void)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(SuccessCallback)success fail:(FailCallback)fail{
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_HTTPS_URL, methodName];
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSMutableDictionary *headDict = [NSMutableDictionary dictionaryWithDictionary:self.sessionManager.requestSerializer.HTTPRequestHeaders];
//    //公共参数配置
//    headDict[@"channel"] = @"iOS";
//    headDict[@"phoneType"] = [LXHTools shareTools].iphoneType;
//    headDict[@"access-token"] = [LXHTools shareTools].accessToken;
//    headDict[@"siteId"] = [LXHTools shareTools].siteId;
//    headDict[@"version"] = [LXHTools getCurrentShortVersion];
//    headDict[@"userId"] = [LXHTools shareTools].userId;
//    headDict[@"userName"] = [LXHTools shareTools].userModel.userName;
//    headDict[@"memberId"] = [LXHTools shareTools].memeberId;
//    headDict[@"systemVersion"] =  [[UIDevice currentDevice] systemVersion]; //系统版本号
//    headDict[@"phoneModel"] =  [LXHTools shareTools].iphoneType; //手机型号
//    
//    [self.sessionManager.requestSerializer setValue:headDict forKey:@"mutableHTTPRequestHeaders"];
//    [self.sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        if ([dict[@"resultCode"] isEqualToString:@"00100000"]) {
//            
//            success(dict);
//        }else{
//            fail(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        fail(error);
//    }];
//}
//

@end
