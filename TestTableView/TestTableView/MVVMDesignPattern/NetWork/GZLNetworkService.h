//
//  GZLNetworkService.h
//  GZLApp
//
//  Created by moxuyou on 2017/6/22.
//  GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessCallback)(id responseObject);
typedef void(^FailCallback)(NSError *error);
@interface GZLNetworkService : NSObject

//+ (instancetype)sharedInstance;
//
//- (void)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(SuccessCallback)success fail:(FailCallback)fail;
//- (void)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(SuccessCallback)success fail:(FailCallback)fail;

@end
