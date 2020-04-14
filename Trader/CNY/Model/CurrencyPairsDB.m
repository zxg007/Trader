//
//  CurrencyPairsDB.m
//  Exchange
//
//  Created by anyway on 16/6/12.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import "CurrencyPairsDB.h"

@implementation CurrencyPairsDB

+ (int)countAllCurrencyPairs{
    __block int count = 0;
    
    //  FMDatabase *dataBase = [dataBaseManager createDataBase];
    //  if ([dataBase open]) {
    //    FMResultSet *rs = [dataBase executeQuery:@"SELECT COUNT(*) FROM BingQu"];
    //    if ([rs next]) {
    //      count = [rs intForColumnIndex:0];
    //    }
    //    [dataBase close];
    //  }
    
    FMDatabaseQueue *queue = [dataBaseManager queue];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db open]) {
            FMResultSet *rs = [db executeQuery:@"SELECT COUNT(*) FROM CurrencyPairs"];
            if ([rs next]) {
                count = [rs intForColumnIndex:0];
            }
        }
    }];
    return count;
    
}

//直盘
+ (NSMutableArray *)findAllDirectCurrencyPairsArray;{
    __block NSMutableArray *arry = [NSMutableArray array];
    
    FMDatabaseQueue *queue = [dataBaseManager queue];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db open]) {
            
            FMResultSet *rs = [db executeQuery:@"SELECT * FROM CurrencyPairs where pairsType ='直盘'"];
            
            while ([rs next]) {
                CurrencyPairs *pairs = [[CurrencyPairs alloc] init];
                
                pairs.pairSymbol = [rs stringForColumn:@"pairSymbol"] ;
                pairs.pairsEnName = [rs stringForColumn:@"pairsEnName"] ;
                pairs.pairsChName = [rs stringForColumn:@"pairsChName"] ;
              //  pairs.currencyTag = [rs stringForColumn:@"currencyTag"] ;
                
                
                [arry addObject:pairs];
            }
        }
    }];
    return arry;
    
}

//交叉盘
+ (NSMutableArray *)findAllCrossingCurrencyPairsArray{
    __block NSMutableArray *arry = [NSMutableArray array];
    
    FMDatabaseQueue *queue = [dataBaseManager queue];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db open]) {
            
            FMResultSet *rs = [db executeQuery:@"SELECT * FROM CurrencyPairs where pairsType ='交叉盘'"];
            
            while ([rs next]) {
                CurrencyPairs *pairs = [[CurrencyPairs alloc] init];
                
                pairs.pairSymbol = [rs stringForColumn:@"pairSymbol"] ;
                pairs.pairsEnName = [rs stringForColumn:@"pairsEnName"] ;
                pairs.pairsChName = [rs stringForColumn:@"pairsChName"] ;
                pairs.currencyTag = [rs stringForColumn:@"currencyTag"] ;
                
                
                [arry addObject:pairs];
            }
        }
    }];
    return arry;
}
+ (CurrencyPairs *)findCurrencyPair:(NSString *)symbol{
    __block CurrencyPairs *currecny = [[CurrencyPairs alloc] init];
    
    FMDatabaseQueue *queue = [dataBaseManager queue];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db open]) {
            
            FMResultSet *rs = [db executeQuery:@"SELECT * FROM CurrencyPairs where pairsEnName =?",symbol];
            
            while ([rs next]) {
                currecny.lastedPrice = [rs stringForColumn:@"lastedPrice"] ;
                currecny.pairsChName = [rs stringForColumn:@"pairsChName"] ;
                currecny.currencyTag = [rs stringForColumn:@"currencyTag"] ;
            }
        }
    }];
    return currecny;
    
    
}
+ (BOOL)upDateCurrencyLastedPrice:(NSString *)lastedPrice withSmbol:(NSString *)symbol{
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    if ([dataBase open]) {
        isOK = [dataBase executeUpdate:@"UPDATE CurrencyPairs SET lastedPrice = ? WHERE pairsEnName = ?",lastedPrice,symbol];
        [dataBase close];
    }
    
    return isOK;
}
/** 删除 **/
+ (BOOL)deleteAllcountAllCurrencyPairs{
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    if ([dataBase open]) {
        isOK = [dataBase executeUpdate:@"DELETE FROM CurrencyPairs"];
        [dataBase close];
    }
    
    return isOK;
}


@end
