//
//  CurrencyPairs.h
//  Exchange
//
//  Created by anyway on 16/6/12.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyPairs : NSObject
@property (nonatomic, strong) NSString *pairSymbol;
@property (nonatomic, strong) NSString *pairsEnName;
@property (nonatomic, strong) NSString *pairsChName;

@property (nonatomic, strong) NSString *lastedPrice;
@property (nonatomic, strong) NSString *currencyTag;

@end
