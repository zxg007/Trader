//
//  HtmlWebViewController.h
//  Exchange
//
//  Created by anyway on 16/6/10.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HtmlWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic)   IBOutlet UIWebView *webView;
@property (weak, nonatomic)   IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) NSString *requestHtml;
@property (strong, nonatomic) NSString *showTabBar;
-(IBAction)back:(id)sender;

@end
