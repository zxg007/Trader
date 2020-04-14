//
//  HuobiTickersRequest.m
//  Trader
//
//  Created by anyway on 2020/4/6.
//  Copyright © 2020 anyway. All rights reserved.
//

#import "HuobiTickersRequest.h"

@implementation HuobiTickersRequest

- (CMRequestMethod)requestMethod {
    return CMRequestMethodGET;
}

- (NSString *)requestURLPath {
   // return @"/index.php/Api/chat/getFriendList";
    NSString *requestPath = [NSString stringWithFormat:@"%@",_tickers];
    
    return requestPath;
}

- (NSDictionary *)requestArguments {
   /* return @{
            @"list": _list
    };
*/
  return nil;//如果接口不需传参，返回 nil 即可
}

///< 配置请求头，根据需求决定是否重写
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return nil;
}

- (void)handleData:(id)data errCode:(NSInteger)errCode {
  NSDictionary *dict = (NSDictionary *)data;
   // NSError *error = nil;
  NSLog(@"errCode %ld",errCode);
    
    if (errCode == 0) {
       NSMutableArray *friendLists = [NSMutableArray arrayWithCapacity:0];
//        NSArray *arr = [dict objectForKey:@"friend_list"];
//        for (NSDictionary *temp in arr) {
//            HQMContact *contact = [MTLJSONAdapter modelOfClass:[HQMContact class] fromJSONDictionary:temp error:&error];
//            [friendLists addObject:contact];
//        }

        ///< 方式1：block 回调
        if (self.successBlock) {
            self.successBlock(errCode, data, friendLists);
        }

        ///< 方式2：代理回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishLoadingWithData:errCode:)]) {
            [self.delegate requestDidFinishLoadingWithData:friendLists errCode:errCode];
        }
    }
    else {
        ///< block 回调
        if (self.successBlock) {
            
            self.successBlock(errCode, data, nil);
        }

        ///< 代理回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishLoadingWithData:errCode:)]) {
            [self.delegate requestDidFinishLoadingWithData:data errCode:errCode];
        }
    }
}
@end
