//
//  MsgSendFactory.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/8.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "MsgSendFactory.h"
#import "SmsMsgSend.h"
#import "MailMsgSend.h"
#import "PushMsgSend.h"
@implementation MsgSendFactory

+(MsgSend *)creatMsgSendWithType:(MsgSendType)type{
  MsgSend *send = [[MsgSend alloc]init];
  switch (type) {
    case MsgSendTypeMail:
      send = [[MailMsgSend alloc]init];
      break;
    case MsgSendTypeSms:
      send =  [[SmsMsgSend alloc]init];
      break;
    case MsgSendTypePush:
      send = [[PushMsgSend alloc]init];
      break;
    default:
      break;
  }
  return send;
}

@end
