//
//  countyCell.h
//  Exchange
//
//  Created by anyway on 16/6/2.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
@interface countyCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *countryNameLabel;


@property (strong, nonatomic) IBOutlet UIImageView *flagImageView;
@property (strong, nonatomic) IBOutlet UILabel *currencysymbolLabel;
@property (strong, nonatomic) IBOutlet UILabel *ChNameLabel;

- (void)configureCellForData:(Country *) country;
@end
