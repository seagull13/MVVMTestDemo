//
//  GZLNetWorkStatus.h
//  GZLApp
//
//  Created by 江南布衣 on 2017/7/11.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,GZLNetWorkStatusType) {
    kGZLNetWorkStatusTypeUnknown = 0,//未知网络
    kGZLNetWorkStatusTypeNotReachable = 1,//没有网络
    kGZLNetWorkStatusTypeWWAN = 2,//手机
    kGZLNetWorkStatusTypeWiFi = 3,//WiFi
};

@interface GZLNetWorkStatus : NSObject

+ (instancetype)shareNetWorkStatus;
/** 网络状态 */
@property(nonatomic, assign) GZLNetWorkStatusType netWorkStatusType;
/** 开始监控网络状态 */
- (void)startMonitoring;
@end
