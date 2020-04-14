//
//  SettingViewController.m
//  Exchange
//
//  Created by anyway on 16/5/24.
//  Copyright © 2016年 anyway. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonalCell.h"
#import "HtmlWebViewController.h"
#define basicArr  @[@"外汇（Foreign Exchange）",@"汇率（Foreign Exchange Rate）",@"汇率的种类",@"汇率的决定",@"汇率的变动",@"汇率制度"]

#define exchangeArr  @[@"外汇报价",@"基点",@"差价" ]

#define currencyArr  @[@"美元",@"欧元",@"日元",@"英镑",@"瑞朗",@"澳元"]

#define keyArr  @[@"外汇基础知识",@"外汇交易基本概念",@"主要货币" ]

@interface SettingViewController (){
    NSMutableArray *_data;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _data = [[NSMutableArray alloc]initWithCapacity : 3];
    [self setExtraCellLineHidden:self.tableViewSettings];
    self.tableViewSettings.separatorColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1.] ;
    self.tableViewSettings.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if ([self.tableViewSettings respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableViewSettings  setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableViewSettings     respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableViewSettings setLayoutMargins:UIEdgeInsetsZero];
        
    }
    self.tableViewSettings.rowHeight = UITableViewAutomaticDimension;
    
    //  [_kTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self loadData];

}



- (void)loadData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
    [dict setObject:basicArr forKey:keyArr[0]];
    
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]initWithCapacity : 2];
    [dict1 setObject:exchangeArr forKey:keyArr[1]];
    
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc]initWithCapacity : 2];
    [dict2 setObject:currencyArr forKey:keyArr[2]];
    
    [_data addObject: dict];
    [_data addObject: dict1];
    [_data addObject: dict2];
    
    [self.tableViewSettings reloadData];
    
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}



#pragma mark - TableView DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_data count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30.0f;
    
}
//表格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableDictionary *dict = _data[section];
    
    NSArray *array = [dict objectForKey:keyArr[section]];//所有section下key值所对应的value的值
    return array.count;
  //  return [_data count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonalCell *cell = (PersonalCell *)[self.tableViewSettings dequeueReusableCellWithIdentifier:@"PersonalCell"];
    if(cell==nil)
    {
        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:@"PersonalCell"];
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"PersonalCell" owner:self options:nil];
        for(id oneObject in nibs)
        {
            if([oneObject isKindOfClass:[PersonalCell class]])
            {
                cell=(PersonalCell *)oneObject;
            }
        }
        
    }
    if(indexPath.section ==0){
        [cell.image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"personal_0%d",(unsigned int) indexPath.row ]]];
        cell.titleLabel1.text = [basicArr objectAtIndex:indexPath.row];
    }
    if(indexPath.section ==1){
        [cell.image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"personal_0%d",(unsigned int) indexPath.row ]]];
        cell.titleLabel1.text = [exchangeArr objectAtIndex:indexPath.row];
    }
    if(indexPath.section ==2){
        [cell.image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"personal_0%d",(unsigned int) indexPath.row ]]];
        cell.titleLabel1.text = [currencyArr objectAtIndex:indexPath.row];
    }
  //
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    // cell.selectedBackgroundView
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"selected!");
    
    [self.tableViewSettings deselectRowAtIndexPath:indexPath animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
    HtmlWebViewController *risk = [[HtmlWebViewController alloc] init];
    if(indexPath.row ==0)
        risk.requestHtml =  @"exchangeRate";
    if(indexPath.row ==1)
        risk.requestHtml =  @"traders_agreement";
    
    [self.navigationController pushViewController:risk animated:NO];
  
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableViewSettings  ){
        // 下面这几行代码是用来设置cell的上下行线的位置
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _topView = [[TopFilerView alloc] init];
    [_topView setFrame:CGRectMake(0,0, kScreen_Width, 30)];
    
    _topView.tableView = self.tableViewSettings;
    _topView.section = section;
    
    _topView.backgroundColor = RGB(253, 250, 252);
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    headerLabel.textColor = RGB(102, 102, 102);
    
    
    headerLabel.text = keyArr[section];
    
    [_topView addSubview:headerLabel];
    
    
    return  _topView;
}

//导航栏背景
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
