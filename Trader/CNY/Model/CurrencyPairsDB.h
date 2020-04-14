//
//  CurrencyPairsDB.h
//  Exchange
//
//  Created by anyway on 16/6/12.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataBaseManager.h"
#import "CurrencyPairs.h"
@interface CurrencyPairsDB : NSObject

+ (int)countAllCurrencyPairs;
//直盘
+ (NSMutableArray *)findAllDirectCurrencyPairsArray;
//交叉盘
+ (NSMutableArray *)findAllCrossingCurrencyPairsArray;

+ (CurrencyPairs *)findCurrencyPair:(NSString *)symbol;

/**  **/
+ (BOOL)upDateCurrencyLastedPrice:(NSString *)lastedPrice withSmbol:(NSString *)symbol;
/** 删除 **/
+ (BOOL)deleteAllcountAllCurrencyPairs;
@end
