//
//  HtmlWebViewController.m
//  Exchange
//
//  Created by anyway on 16/6/10.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import "HtmlWebViewController.h"

@interface HtmlWebViewController ()
@property (strong,nonatomic) MBProgressHUD *hud;
@end

@implementation HtmlWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([_requestHtml isEqualToString:@"agreement"])
        _labelTitle.text = @"风险揭示书";
    
    if([_requestHtml isEqualToString:@"traders_agreement"])
        _labelTitle.text = @"交易商协议书";
    
    if([_requestHtml isEqualToString:@"speech"])
        _labelTitle.text = @"溢金宝";
    
    if([_requestHtml isEqualToString:@"products"])
        _labelTitle.text = @"产品中心";
    
    [_webView setScalesPageToFit:YES];
    
    NSString *filePath  = [[NSBundle mainBundle]pathForResource:_requestHtml ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if(!self.hud){
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = NSLocalizedString(@"正在努力中, 请您稍侯......", @"");
    }
    // NSLog(@"start");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
    //  NSLog(@"finish");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sende{
    [self.navigationController popViewControllerAnimated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
