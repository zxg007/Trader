//
//  CharteeViewController.h
//  Trader
//
//  Created by anyway on 2020/1/16.
//  Copyright © 2020 anyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopFilerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CharteeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet TopFilerView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCurrencies;

@end

NS_ASSUME_NONNULL_END
