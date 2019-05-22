//
//  GZLAPIBaseManager.m
//  GZLApp
//
//  Created by moxuyou on 2017/4/20.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import "GZLAPIBaseManager.h"
#import "AFNetworking.h"
@interface GZLAPIBaseManager ()

@property (nonatomic, strong) NSString *successMessageString;
/**  */
@property (strong, nonatomic)AFHTTPSessionManager *sessionManager;
/** json类型参数的请求 */
@property (strong, nonatomic)AFHTTPSessionManager *jsonSessionManager;
/** 当前请求manager */
@property (strong, nonatomic)AFHTTPSessionManager *currentSessionManager;
/** 队列 */
@property (strong, nonatomic) NSOperationQueue *queue;
@end

@implementation GZLAPIBaseManager


-(instancetype)initSettingDelegateAndParamSource:(id)obj{
    self = [super init];
    if ([self conformsToProtocol:@protocol(CTAPIManager)])
        {
        self.child = (id<CTAPIManager>)self;
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
        self.delegate = obj;
        self.paramSource = obj;
        }else{
            NSAssert(NO, @"子类必须要实现CTAPIManager这个protocol。");
        }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if ([self conformsToProtocol:@protocol(CTAPIManager)])
    {
        self.child = (id<CTAPIManager>)self;
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }else{
        NSAssert(NO, @"子类必须要实现CTAPIManager这个protocol。");
    }
    return self;
}
- (AFHTTPSessionManager *)jsonSessionManager{
    
    if (_jsonSessionManager == nil) {
        //        AFURLRequestSerialization
        _jsonSessionManager = [AFHTTPSessionManager manager];
        
        _jsonSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        _jsonSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        _jsonSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [_jsonSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [_jsonSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_sessionManager.requestSerializer setTimeoutInterval:50.f];
    }
    return _jsonSessionManager;
}
- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
//        AFURLRequestSerialization
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
//        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/javascript",@"application/x-json",@"text/html", @"application/json", nil];
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
        [_sessionManager.requestSerializer setTimeoutInterval:50.f];
    }
    return _sessionManager;
}

#pragma mark - calling api
- (NSInteger)loadData{
    if (self.isLoading) {//添加拦截，防止在请求没回来的时候重复请求
        return 0;
    }
    if (self.ifCache) {//是否需要缓存
        
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getCacheData) object:nil];
        [self.queue addOperation:op];
    }
    
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    
    switch (self.child.requestType)
    {
        case CTAPIManagerRequestTypeGet:
            
            break;
        case CTAPIManagerRequestTypePost:
            [self callReauest:params];
            break;
        case CTAPIManagerRequestTypePut:
            
            break;
        case CTAPIManagerRequestTypeDelete:
            
            break;
            
        default:
            break;
    }
    
    return 1;
}

- (void)callReauest:(NSDictionary *)params
{
    
    self.currentSessionManager = self.jsonParams ? self.jsonSessionManager : self.sessionManager;
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", self.child.serviceType, self.child.urlPath, self.child.methodName];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if (self.isLoading) {//添加拦截，防止在请求没回来的时候重复请求
        return;
    }else{
        self.isLoading = YES;
//        if (self.hudView) {//添加加载遮盖

//        }
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary *headDict = [NSMutableDictionary dictionaryWithDictionary:self.currentSessionManager.requestSerializer.HTTPRequestHeaders];
    //公共参数配置
    headDict[@"channel"] = @"iOS";
//    headDict[@"phoneType"] = [LXHTools shareTools].iphoneType;
//    headDict[@"access-token"] = [LXHTools shareTools].accessToken;
//    headDict[@"siteId"] = [LXHTools shareTools].siteId;
//    headDict[@"version"] = [LXHTools getCurrentShortVersion];
//    headDict[@"userId"] = [LXHTools shareTools].userId;
//    headDict[@"userName"] = [LXHTools shareTools].userModel.userName;
//    headDict[@"memberId"] = [LXHTools shareTools].memeberId;
//    headDict[@"systemVersion"] =  [[UIDevice currentDevice] systemVersion]; //系统版本号
//    headDict[@"phoneModel"] =  [LXHTools shareTools].iphoneType; //手机型号

    //签名
//    if (self.isSignature) {
//        headDict = [self paramsSignatureWithParams:params HeadDict:headDict];
//    }
    [self.currentSessionManager.requestSerializer setValue:headDict forKey:@"mutableHTTPRequestHeaders"];

    [self.currentSessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //DLog(@"AFNResponseObject:=====wch=====%@", responseObject);
        [self successedOnCallingAPI:task responseObject:responseObject];
        
        if ([self.child respondsToSelector:@selector(APITestMethod:params:date:)])
        {
            [self .child APITestMethod:urlString params:params date:self.fetchedRawData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedOnCallingAPI:task error:error];
        
        if ([self.child respondsToSelector:@selector(APITestMethod:params:date:)])
        {
            [self.child APITestMethod:urlString params:params date:self.fetchedRawData];
        }
    }];
    
}

//static NSString *PRIVATE_KEY = @"$*RxTlB3jJSKJWwIP&4@qT8T4b%nC3WdQ!O3amysFUJ5PFf01jssJr8hEj&X%$U4i!hB";
//-(NSMutableDictionary *)paramsSignatureWithParams:(NSDictionary *)params HeadDict:(NSMutableDictionary *)headDict {
//    NSString *timestamp = [NSString stringWithFormat:@"%.0f",[NSDate getCurrentTimestamp] * 1000];
//    headDict[@"timestamp"] = timestamp;  //时间戳
//    NSString *nonce = [NSString stringWithFormat:@"%u",arc4random_uniform(10000)];
//    __block NSString *basestring = @"";
//
//    NSArray *sortArray = [params.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        return[obj1 compare:obj2 options:NSNumericSearch];//正序
//    }];
//
//    [sortArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (!kStringIsEmpty(obj) &&  !kStringIsEmpty([params objGetStrForKey:obj])) {
//            basestring = basestring.addString(obj).addString(@"=").addString([params objGetStrForKey:obj]);
//        }
//    }];
//
//    if (kStringIsEmpty(basestring)) {
//        return  headDict;
//    }
//    basestring = basestring.addString(PRIVATE_KEY);
//    basestring = basestring.addString(timestamp);
//    basestring = basestring.addString(nonce);
//    basestring = [[basestring  MD5ForLower32Bate] MD5ForLower32Bate];
//
//    headDict[@"nonce"] = nonce;  //随机数
//    headDict[@"signature"] =  basestring; //签名
//    return headDict;
//}

#pragma mark - public methods

/**使用reformer调用代理方法，把解析后的数据回调到此方法，然后在返回给调用者*/

- (id)fetchDataWithReformer:(id<CTAPIManagerDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
    
}

- (void)successedOnCallingAPI:(NSURLSessionDataTask *)task responseObject:(id)responseObject
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.fetchedRawData = responseObject;
    self.isLoading = NO;
    if (![[responseObject objectForKey:@"fromCache"] isEqualToString:@"1"] && [[responseObject objectForKey:@"resultCode"] isEqualToString:@"00100000"] && self.ifCache) {
        
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(writeCacheData) object:nil];
        [self.queue addOperation:op];
    }
    if ([[self.fetchedRawData objectForKey:@"resultCode"]  isEqualToString:@"00100000"]){

        self.successMessageString = [self.fetchedRawData objectForKey:@"resultMsg"];
        
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)])
        {
            [self.delegate managerCallAPIDidSuccess:self];
        }
    }else if([[self.fetchedRawData objectForKey:@"resultCode"] isEqualToString:@"00100009"]){//accessToken过期了
        //AccessToken过期跳转登录界面
        
        if (!self.noGoLoginPage) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noGoLoginPage" object:self];
            [self.delegate managerCallAPIDidFailed:self];
        }
    }else{
        NSDictionary *errorDic = self.fetchedRawData;
        if (self.ifShowErronInfo && [errorDic objectForKey:@"resultMsg"] != nil) {
//            [MBManager showBriefAlert:[errorDic objGetStrForKey:@"resultMsg"]];
        }

        [self.delegate managerCallAPIDidFailed:self];
    }
    NSLog(@"message:%@", self.fetchedRawData[@"resultMsg"]);
}


- (void)failedOnCallingAPI:(NSURLSessionDataTask *)task error:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.isLoading = NO;
    self.errorData = error;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)])
        {
            [self.delegate managerCallAPIDidFailed:self];
        }
    });
}

#pragma mark - CTAPIManager
- (NSString *)methodName{
    
    return nil;
}
- (NSString *)serviceType{
    
    return nil;
}
- (NSString *)urlPath{
    
    return nil;
}
- (CTAPIManagerRequestType)requestType{
    
    return CTAPIManagerRequestTypeGet;
}

#pragma mark - Action

- (void)getCacheData{
    
    NSLog(@"%@", [NSThread currentThread]);
    NSString *key = [NSString stringWithFormat:@"%@%@", self.urlPath, self.methodName];
    if (key.length >0) {
        //key = [key stringByReplacingOccurrencesOfString:@".json" withString:@".plist"];
    }else{
        NSLog(@"缓存路径为空");
        return;
    }
    NSData *receiveData = [[GZLNetWorkCacheManger shareInstance] readCacheDataWithKey:key andType:self.fileNameType];
    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSData *data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if (jsonDict.allKeys.count <= 0) {
        
        return;
    }
    NSMutableDictionary *callBackDict = [NSMutableDictionary dictionaryWithDictionary:jsonDict];
    callBackDict[@"fromCache"] = @"1";
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self successedOnCallingAPI:nil responseObject:callBackDict];
    });
    
}

- (void)writeCacheData{
    
    NSLog(@"%@", [NSThread currentThread]);
    NSString *key = [NSString stringWithFormat:@"%@%@", self.urlPath, self.methodName];
    if (key.length >0) {
        //key = [key stringByReplacingOccurrencesOfString:@".json" withString:@".plist"];
    }else{
        NSLog(@"缓存路径为空");
        return;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.fetchedRawData options:NSJSONWritingPrettyPrinted error:nil];
    [[GZLNetWorkCacheManger shareInstance] writeCacheData:data withKey:key andType:self.fileNameType];
}
/** 取消之前的网络请求 */
- (void)cancelRequestBefore{
    
    [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.sessionManager.operationQueue cancelAllOperations];
}
@end
