//
//  dataBaseManager.m
//  fmdbtest
//
//  Created by Edward on 13-3-1.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "dataBaseManager.h"

static FMDatabase *shareDataBase = nil;
@implementation dataBaseManager


/**
 创建数据库类的单例对象
 
 **/
//+ (FMDatabase *)createDataBase {
//    //debugMethod();
//    @synchronized (self) {
//        if (shareDataBase == nil) {
//
//            shareDataBase = [[FMDatabase databaseWithPath:dataBasePath] retain];
//        }
//        return shareDataBase;
//    }
//}
//这种方法可以达到线程安全，但多次调用时会导致性能显著下降

+ (FMDatabase *)copyDataBase{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:dataBasePath]) {
        
       // [fileManager removeItemAtPath:dataBasePath error:nil];
        NSLog(@"dataBasePath %@",dataBasePath);
    }
    else{
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"ExchangeMNDb" ofType:@"db"];
    
        [fileManager copyItemAtPath:jsonPath toPath:dataBasePath error:nil];
    }
    
    
    return shareDataBase;
    
    
}


+ (FMDatabase *)createDataBase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDataBase =  [FMDatabase databaseWithPath:dataBasePath] ;
    });
    return shareDataBase;
}

+ (FMDatabaseQueue *)queue
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    return queue;
}

/**
 判断数据库中表是否存在
 **/
+ (BOOL) isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [shareDataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"%@ isOK %ld", tableName,(long)count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 创建表
 **/
- (BOOL)createTable {
    // debugMethod();
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    if (/* DISABLES CODE */ (1)){//[fileManager fileExistsAtPath:dataBasePath]) {
        shareDataBase = [dataBaseManager createDataBase];
        if ([shareDataBase open]) {
            NSString *sql = @"CREATE TABLE CountryList (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,countryCode VARCHAR2,currencyCode VARCHAR2,currencytSymbol VARCHAR2,EnName VARCHAR2,ChName VARCHAR2,currencyType VARCHAR2)";
            //BingQu表:
            //id(主键) Name病区名称
            
            
            if (![dataBaseManager isTableExist:@"CountryList"]) {
                NSLog(@"no CountryList ");
                [shareDataBase executeUpdate:sql];
            }
            
            
            else {
                NSLog(@"成功创建表");
            }
            [shareDataBase setShouldCacheStatements:YES];//设置缓存
        } else {
            NSLog(@"打开数据库时出现错误");
            return NO;
        }
    } else {
        NSLog(@"数据库不存在");
        return NO;
    }
    return YES;
}


/**
 关闭数据库
 **/
+ (void)closeDataBase {
    if(![shareDataBase close]) {
        NSLog(@"数据库关闭异常，请检查");
        return;
    }
}


/**
 删除数据库
 **/
+ (void)deleteDataBase {
    if (shareDataBase != nil) {
        //这里进行数据库表的删除工作
    }
}
@end
