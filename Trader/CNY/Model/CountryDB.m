//
//  CountryDB.m
//  Exchange
//
//  Created by anyway on 16/6/10.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import "CountryDB.h"

@implementation CountryDB
+ (int)countAllCountries{
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
            FMResultSet *rs = [db executeQuery:@"SELECT COUNT(*) FROM CountryList"];
            if ([rs next]) {
                count = [rs intForColumnIndex:0];
            }
        }
    }];
    return count;
    
}
+ (NSMutableArray *)findAllcountAllCountriesArray{
    __block NSMutableArray *arry = [NSMutableArray array];
    
    FMDatabaseQueue *queue = [dataBaseManager queue];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db open]) {
            
            FMResultSet *rs = [db executeQuery:@"SELECT * FROM CountryList"];
           
            while ([rs next]) {
                Country *ctry = [[Country alloc] init];
                
                ctry.countryCode = [rs stringForColumn:@"countryCode"] ;
                ctry.currencyCode = [rs stringForColumn:@"currencyCode"] ;
                ctry.currencySymbol = [rs stringForColumn:@"currencySymbol"] ;
                ctry.EnName = [rs stringForColumn:@"EnName"] ;
                ctry.ChName = [rs stringForColumn:@"ChName"] ;
                ctry.currencyType = [rs stringForColumn:@"currencyType"] ;
                ctry.m_letter = [rs stringForColumn:@"mLetter"] ;
                ctry.searchTag0 = [rs stringForColumn:@"searchTag0"] ;
                ctry.searchTag1 = [rs stringForColumn:@"searchTag1"] ;
                ctry.searchTag2 = [rs stringForColumn:@"searchTag2"] ;
                ctry.searchTag3 = [rs stringForColumn:@"searchTag3"] ;
                ctry.searchTag4 = [rs stringForColumn:@"searchTag4"] ;
                //ctry.lastedPrice = [rs stringForColumn:@"lastedPrice"] ;
                 
                [arry addObject:ctry];
            }
        }
    }];
    return arry;
    
}

//
+ (NSMutableArray *)findCountriesArray:(NSString *)searchTag{
    __block NSMutableArray *arry = [NSMutableArray array];
    
    FMDatabaseQueue *queue = [dataBaseManager queue];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db open]) {
            
            FMResultSet *rs = [db executeQuery:@"SELECT * FROM CountryList where searchTag0 like ?  or  searchTag1 like ? or  searchTag2 like ?  or  searchTag3 like ?",[NSString stringWithFormat:@"%%%@%%", searchTag],[NSString stringWithFormat:@"%%%@%%", searchTag],[NSString stringWithFormat:@"%%%@%%", searchTag],[NSString stringWithFormat:@"%%%@%%", searchTag]];
            
            while ([rs next]) {
                Country *ctry = [[Country alloc] init];
                
                ctry.countryCode = [rs stringForColumn:@"countryCode"] ;
                ctry.currencyCode = [rs stringForColumn:@"currencyCode"] ;
                ctry.currencySymbol = [rs stringForColumn:@"currencySymbol"] ;
                ctry.EnName = [rs stringForColumn:@"EnName"] ;
                ctry.ChName = [rs stringForColumn:@"ChName"] ;
                ctry.currencyType = [rs stringForColumn:@"currencyType"] ;
                ctry.m_letter = [rs stringForColumn:@"mLetter"] ;
                ctry.searchTag0 = [rs stringForColumn:@"searchTag0"] ;
                ctry.searchTag1 = [rs stringForColumn:@"searchTag1"] ;
                ctry.searchTag2 = [rs stringForColumn:@"searchTag2"] ;
                ctry.searchTag3 = [rs stringForColumn:@"searchTag3"] ;
                ctry.searchTag4 = [rs stringForColumn:@"searchTag4"] ;
                //ctry.lastedPrice = [rs stringForColumn:@"lastedPrice"] ;
                
                [arry addObject:ctry];
            }
        }
    }];
    
    NSLog(@"array- %@-%@",searchTag,arry);
    return arry;
    
}


+ (BOOL)insertCountry:(Country *)ctry{
    
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    if ([dataBase open]) {
        isOK = [dataBase executeUpdate:@"INSERT INTO CountryList (countryCode,currencyCode,currencySymbol,EnName,ChName,currencyType,mLetter,searchTag0,searchTag1,searchTag2,searchTag3,searchTag4) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)",
                ctry.countryCode,
                ctry.currencyCode,
                ctry.currencySymbol,
                ctry.EnName,
                ctry.ChName,
                ctry.currencyType,
                ctry.m_letter,
                ctry.searchTag0,
                ctry.searchTag1,
                ctry.searchTag2,
                ctry.searchTag3,
                ctry.searchTag4];
        [dataBase close];
    }
    
    return isOK;
}


/** 删除 **/
+ (BOOL)deleteAllcountAllCountries{
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    if ([dataBase open]) {
        isOK = [dataBase executeUpdate:@"DELETE FROM CountryList"];
        [dataBase close];
    }
    
    return isOK;
}
@end
