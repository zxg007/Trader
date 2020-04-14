//
//  AddCurrenciesViewController.h
//  Trader
//
//  Created by anyway on 2020/1/18.
//  Copyright © 2020 anyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopFilerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddCurrenciesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
 
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableViewCurrency;
@property (strong  , nonatomic) NSMutableArray *countryList;
@property (nonatomic, assign) NSInteger selectedSection;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (strong, nonatomic) IBOutlet TopFilerView *topView;
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIButton *buttonFL;
//-(IBAction)oprateAction:(id)sender;

- (IBAction)back:(id)sende;
@end

NS_ASSUME_NONNULL_END
