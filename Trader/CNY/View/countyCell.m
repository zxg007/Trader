//
//  countyCell.m
//  Exchange
//
//  Created by anyway on 16/6/2.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import "countyCell.h"

@implementation countyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)configureCellForData:(Country *) country{
    self.countryNameLabel.text = country.EnName;
    self.flagImageView.image = [UIImage imageNamed:country.countryCode];
    self.flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.flagImageView.clipsToBounds =YES;
    self.currencysymbolLabel.text = [NSString stringWithFormat:@"%@ %@",country.currencyCode,country.currencySymbol];
    self.ChNameLabel.text = country.ChName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
