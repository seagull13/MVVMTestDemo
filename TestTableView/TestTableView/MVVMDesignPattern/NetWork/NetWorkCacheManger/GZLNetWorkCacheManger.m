//
//  GZLNetWorkCacheManger.m
//  GZLApp
//
//  Created by 江南布衣 on 2017/7/10.
//
//

#import "GZLNetWorkCacheManger.h"

@interface GZLNetWorkCacheManger ()

//  缓存路径
@property(nonatomic,strong)NSString  *cachePath;
//  缓存路径
@property(nonatomic,strong)NSString   *documentPath;
//  偏好设置路径
@property(nonatomic,strong)NSString   *preferencesPath;
//  临时路径
@property(nonatomic,strong)NSString   *tmpPath;


@end

@implementation GZLNetWorkCacheManger
static GZLNetWorkCacheManger *cacheManger;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheManger = [[self alloc] init];
        cacheManger.cachePath = [self fileNameForGZL:@"GZL" withFileNameType:NSCacheFileNameTypeCaches];
        cacheManger.documentPath = [self fileNameForGZL:@"GZL" withFileNameType:NSCacheFileNameTypeDocuments];
        cacheManger.preferencesPath = [self fileNameForGZL:@"GZL" withFileNameType:NSCacheFileNameTypePreferences];
        cacheManger.tmpPath = [self fileNameForGZL:@"GZL" withFileNameType:NSCacheFileNameTypeTmp];
        
    });
    return cacheManger;
}


// 写缓存
// withCacheFileDirectoryType:(NSCacheFileNameType)fileNameType

- (void)writeCacheData:(NSData *)data withKey:(NSString *)key andType:(NSCacheFileNameType)type {
    
    NSString *cachesPath =  [self fileNameWithKey:key andType:type];
    NSRange rage = [cachesPath rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *fileName = [cachesPath substringWithRange:NSMakeRange(0, rage.location)];
    
    // 判读缓存数据是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        
        // 文件不存在就创建
//        [data writeToFile:fileName atomically:YES];
    }else{
        NSError  *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
    // 存储新的缓存数据
    [data writeToFile:cachesPath atomically:YES];
}


// 读缓存

- (NSData *)readCacheDataWithKey:(NSString *)key andType:(NSCacheFileNameType)type{
    
    NSString *cachesPath =  [self fileNameWithKey:key andType:type];
    // 判读缓存数据是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        
        // 读取缓存数据
        return [NSData dataWithContentsOfFile:cachesPath];
    }
    
    return nil;
}

// 删缓存

- (void)deleteCacheDataWithKey:(NSString *)key andType:(NSCacheFileNameType)type{
    
    NSString *cachesPath =  [self fileNameWithKey:key andType:type];
    
    // 判读缓存数据是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        
        // 删除缓存数据
        [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:nil];
    }
  
}

- (NSString *)fileNameWithKey:(NSString *)key andType:(NSCacheFileNameType)type
{
    // 设置存储路径
    NSString *cachesPath;   // = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:key];
    
    switch (type) {
        case NSCacheFileNameTypeDocuments:
        {
            cachesPath = [self.documentPath  stringByAppendingString:[NSString stringWithFormat:@"/%@",key]]; //[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:key];
        }
            break;
        case NSCacheFileNameTypePreferences:
        {
            cachesPath =  [self.preferencesPath  stringByAppendingString:[NSString stringWithFormat:@"/%@",key]];//[NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:key];
        }
            break;
        case NSCacheFileNameTypeTmp:
        {
            cachesPath = [self.tmpPath  stringByAppendingString:[NSString stringWithFormat:@"/%@",key]]; //[NSTemporaryDirectory() stringByAppendingString:key];
        }
            break;
            
            
        default:
        {
            cachesPath = [self.cachePath  stringByAppendingString:[NSString stringWithFormat:@"/%@",key]];//[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:key];
        }
            break;
    }

    return cachesPath;
}



-(void)clearAllCacheFile
{
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES)[0];
    
     [[NSFileManager defaultManager]  removeItemAtPath:self.cachePath error:nil];
     [[NSFileManager defaultManager]  removeItemAtPath:self.documentPath error:nil];
     [[NSFileManager defaultManager]  removeItemAtPath:self.preferencesPath error:nil];
     [[NSFileManager defaultManager]  removeItemAtPath:self.tmpPath error:nil];
    
    
}

+ (NSString *)fileNameForGZL:(NSString *)name withFileNameType:(NSCacheFileNameType)type
{
    // 设置存储路径
    NSString *fileName;   // = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:key];
    
    switch (type) {
        case NSCacheFileNameTypeDocuments:
        {
            fileName =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:[NSString stringWithFormat:@"/%@Document",name]];
        }
            break;
        case NSCacheFileNameTypePreferences:
        {
            fileName =  [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:[NSString stringWithFormat:@"/%@PreferencePanes",name]];
        }
            break;
        case NSCacheFileNameTypeTmp:
        {
            fileName =  [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"/%@Tmp",name]];
        }
            break;
            
            
        default:
        {
            fileName = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:[NSString stringWithFormat:@"/%@Caches",name]];
        }
            break;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError  *error;
    if (![manager fileExistsAtPath:fileName]) {
        // 文件不存在就创建
        [manager createDirectoryAtPath:fileName withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            return nil;
        }
    }
    
    return fileName;

}

@end
