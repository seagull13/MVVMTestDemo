//
//  MsgSendFactory.h
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/8.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgSend.h"
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,MsgSendType) {
  MsgSendTypeDefault,
  MsgSendTypeMail,
  MsgSendTypeSms,
  MsgSendTypePush,
};

@interface MsgSendFactory : NSObject

+(MsgSend *)creatMsgSendWithType:(MsgSendType)type;
@end

NS_ASSUME_NONNULL_END
