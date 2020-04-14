//
//  HuoBi.m
//  Trader
//
//  Created by anyway on 2020/4/6.
//  Copyright © 2020 anyway. All rights reserved.
//

#import "HuoBi.h"

@implementation HuoBi
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
