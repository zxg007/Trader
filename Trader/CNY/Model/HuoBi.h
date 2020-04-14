//
//  HuoBi.h
//  Trader
//
//  Created by anyway on 2020/4/6.
//  Copyright © 2020 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuoBi : NSObject
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *open;
@property (nonatomic, strong) NSString *high;
@property (nonatomic, strong) NSString *close;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *vol;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *bidSize;
@property (nonatomic, strong) NSString *ask;
@property (nonatomic, strong) NSString *askSize;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
