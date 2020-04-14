//
//  Country.h
//  Exchange
//
//  Created by anyway on 16/6/10.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *currencySymbol;
@property (nonatomic, strong) NSString *EnName;
@property (nonatomic, strong) NSString *ChName;
@property (nonatomic, strong) NSString *currencyType;

@property (nonatomic, strong) NSString *m_letter;//首字母

@property (nonatomic, strong) NSString *searchTag0;//
@property (nonatomic, strong) NSString *searchTag1;//
@property (nonatomic, strong) NSString *searchTag2;//
@property (nonatomic, strong) NSString *searchTag3;//
@property (nonatomic, strong) NSString *searchTag4;//
@end
