//
//  GZLNetWorkCacheManger.h
//  GZLApp
//
//  Created by 江南布衣 on 2017/7/10.
//
//

#import <Foundation/Foundation.h>

//存入文件名路径的主目录
typedef NS_OPTIONS(NSUInteger, NSCacheFileNameType) {
    NSCacheFileNameTypeCaches = 0,       // 一般缓存存放的位置
    NSCacheFileNameTypeDocuments = 1,    //用户重要的数据的存放位置 同步iCould
    NSCacheFileNameTypePreferences = 2,  //用户的一些偏好设置
    NSCacheFileNameTypeTmp  = 3          //临时文件的存储   退出应用是将会删除该目录
};


@interface GZLNetWorkCacheManger : NSObject

+ (instancetype)shareInstance;

//@property(nonatomic,assign) NSCacheFileNameType  fileNameType;


/**
 写入缓存

 @param data 写入的数据
 @param key URL  存取的唯一标识符
 @param type 缓存路径类型
 */
- (void)writeCacheData:(NSData *)data withKey:(NSString *)key andType:(NSCacheFileNameType)type;


/**
 读取缓存

 @param key URL  存取的唯一标识符
 @param type 缓存路径类型
 @return 读取的数据
 */
- (NSData *)readCacheDataWithKey:(NSString *)key andType:(NSCacheFileNameType)type;


/**
 根据唯一标识符删除缓存数据

 @param key  存取的唯一标识符
 @param type 缓存路径类型
 */
- (void)deleteCacheDataWithKey:(NSString *)key andType:(NSCacheFileNameType)type;


/**
 删除缓存文件  仅仅针对于Cache 层的
 */
-(void)clearAllCacheFile;

@end
