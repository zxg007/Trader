//
//  CountryDB.h
//  Exchange
//
//  Created by anyway on 16/6/10.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataBaseManager.h"
#import "Country.h"
@interface CountryDB : NSObject

+ (int)countAllCountries;
+ (NSMutableArray *)findAllcountAllCountriesArray;
//
+ (NSMutableArray *)findCountriesArray:(NSString *)searchTag;

+ (BOOL)insertCountry:(Country *)ctry;

/** 删除 **/
+ (BOOL)deleteAllcountAllCountries;
@end
