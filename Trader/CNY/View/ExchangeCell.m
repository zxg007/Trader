//
//  ExchangeCell.m
//  anyIOS9
//
//  Created by anyway on 15/12/9.
//  Copyright © 2015年 anyway. All rights reserved.
//

#import "ExchangeCell.h"
#import "CurrencyPairsDB.h"
@implementation ExchangeCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellForData:(Currency *)curreny{
    NSString* symbol  = [curreny.symbolEnName  stringByReplacingOccurrencesOfString:@"=x" withString:@""];
    symbol   = [symbol  stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    CurrencyPairs *pairs = [CurrencyPairsDB findCurrencyPair:symbol];
    _labelChSymbal.text = pairs.pairsChName;
    _labelEnSymbal.text = symbol;
    _labelAskPrice.text = curreny.askPrice;
    _labelBidPrice.text = curreny.bidPrice;
    
    if([curreny.lastedPrice floatValue] >= [pairs.lastedPrice floatValue]){
        _labelAskPrice.textColor = RGB(255, 0, 0);
        _labelBidPrice.textColor = RGB(255, 0, 0);
    }
    else{
        _labelAskPrice.textColor = RGB(23, 162, 23);
        _labelBidPrice.textColor = RGB(23, 162, 23);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.09 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
           [CurrencyPairsDB upDateCurrencyLastedPrice:curreny.lastedPrice withSmbol:symbol];
    });
  //  NSLog(@"en%@",curreny.symbolEnName);
}
@end
