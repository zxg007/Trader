//
//  Currency.h
//  anyIOS9
//
//  Created by anyway on 15/12/9.
//  Copyright © 2015年 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject
@property (nonatomic, strong) NSString *symbolChName;
@property (nonatomic, strong) NSString *symbolEnName;
@property (nonatomic, strong) NSString *lastedPrice;  //最新价
@property (nonatomic, strong) NSString *askPrice;        //
@property (nonatomic, strong) NSString *bidPrice;          //
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *timeString;
      //
@property (nonatomic, strong) NSString *currencyTag; 
@end
