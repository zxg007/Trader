//
//  AFCurreniesRequest.h
//  Trader
//
//  Created by anyway on 2020/3/12.
//  Copyright © 2020 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMBaseRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface AFCurreniesRequest : CMBaseRequest
/**接口需要传的参数*/
@property (nonatomic, strong) NSString *list;
@end

NS_ASSUME_NONNULL_END
