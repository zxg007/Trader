//
//  ExchangeCell.h
//  anyIOS9
//
//  Created by anyway on 15/12/9.
//  Copyright © 2015年 anyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"
#import "CurrencyPairs.h"
@interface ExchangeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelChSymbal;
@property (strong, nonatomic) IBOutlet UILabel *labelEnSymbal;
@property (strong, nonatomic) IBOutlet UILabel *labelAskPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelBidPrice;
- (void)configureCellForData:(Currency *)curreny;

@end
