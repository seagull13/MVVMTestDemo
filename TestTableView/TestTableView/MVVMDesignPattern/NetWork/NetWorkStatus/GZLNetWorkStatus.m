//
//
//  GZLNetWorkStatus.m
//  GZLApp
//
//  Created by 江南布衣 on 2017/7/11.
// GZL INTERNATIONAL TRAVEL SERVICE  LTD.
//


#import "GZLNetWorkStatus.h"
#import "AFNetworking.h"

@implementation GZLNetWorkStatus

static GZLNetWorkStatus *netWorkStatus;

+ (instancetype)shareNetWorkStatus{
    
    if (netWorkStatus == nil) {
        netWorkStatus = [[GZLNetWorkStatus alloc] init];
    }
    return netWorkStatus;
}

- (void)startMonitoring{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                // 未知网络
                NSLog(@"未知网络");
                self.netWorkStatusType = kGZLNetWorkStatusTypeUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                // 没有网络(断网)
                NSLog(@"没有网络");
                self.netWorkStatusType = kGZLNetWorkStatusTypeNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // 手机自带网络
                self.netWorkStatusType = kGZLNetWorkStatusTypeWWAN;
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // WIFI
                NSLog(@"WIFI");
                self.netWorkStatusType = kGZLNetWorkStatusTypeWiFi;
                break;
        }
    }];
    
    // 3.开始监控
    [manager startMonitoring];
}

@end
