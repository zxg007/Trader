//
//  SettingViewController.h
//  Exchange
//
//  Created by anyway on 16/5/24.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopFilerView.h"
@interface SettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewSettings;
@property (strong, nonatomic) IBOutlet TopFilerView *topView;
@end
