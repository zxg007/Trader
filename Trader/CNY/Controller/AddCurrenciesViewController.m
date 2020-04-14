//
//  AddCurrenciesViewController.m
//  Trader
//
//  Created by anyway on 2020/1/18.
//  Copyright © 2020 anyway. All rights reserved.
//

#import "AddCurrenciesViewController.h"
#import "Country.h"
#import "countyCell.h"
 
#import "CountryDB.h"

#define contentArr  @[@"非美货币",@"欧系货币",@"美系货币",@"风险货币",@"避险货币",@"低息货币",@"高息货币",@"商品货币",@"黄金货币" ]

@interface AddCurrenciesViewController (){
    NSMutableArray *searchArr;//搜索到的内容
    
    NSMutableDictionary *letterDict;//
}

@property(nonatomic,strong)NSMutableArray *requltData;

@property(nonatomic,strong)NSMutableArray *requltIndexData;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isScrollToShow;
@property (strong,nonatomic)NSMutableArray * searchResultArray;/*搜索完之后的数据(数组类型)*/
@property (strong,nonatomic)NSMutableArray * searchModelResultArray;/*搜索完之后的数据(model类型)*/
 
@property (strong, nonatomic)  UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *historyListArray; // 搜索历史数组
@property(nonatomic,assign)BOOL searchActive;
@end

@implementation AddCurrenciesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.selectedIndex = -1;
        self.selectedSection = -1;
        self.countryList = [[NSMutableArray alloc] init];
        searchArr = [[NSMutableArray alloc] init];
        //saveArr = [[NSMutableArray alloc] init];
        letterDict = [[NSMutableDictionary alloc] init];
       [self loadCountries];
    //创建UISearchController
    if(_searchController == nil){
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
        _searchController.searchBar.delegate = self;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.backgroundColor = [UIColor whiteColor];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchController.searchBar.placeholder = @"  搜索货币";
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 74.0);

        self.tableViewCurrency.tableHeaderView = _searchController.searchBar;
    }
    
    }
-(void) loadCountries{
       
       self.countryList = [CountryDB findAllcountAllCountriesArray];
        
       // NSLog(@" self.countryList %@", self.countryList);
        [self getAllCountries];
        
    }
#pragma mark - 将首字母相同的放在一起
- (void)getAllCountries{
        //遍历
        for (Country *model in self.countryList) {
            NSMutableArray *letterArr = letterDict[model.m_letter];
            //判断数组里是否有元素，如果为nil，则实例化该数组，并在cityDict字典中插入一条新的数据
            if (letterArr == nil) {
                letterArr = [[NSMutableArray alloc] init];
                [letterDict setObject:letterArr forKey:model.m_letter];
            }
            //将新数据放到数组里
            [letterArr addObject:model];
        }
        
         [self.tableViewCurrency reloadData];
        
    }


#pragma mark - 获得所有的key值并排序，并返回排好序的数组
- (NSArray *)getLetterDictAllKeys
{
    //获得cityDict字典里的所有key值，
    //NSArray *keys = [letterDict allKeys];
    //打印
    //    NSLog(@"keys = %@",[keys sortedArrayUsingSelector:@selector(compare:)]);
    //按升序进行排序（A B C D……）
   NSMutableArray *keys  = (  NSMutableArray *)[letterDict allKeys ];
    
   
    NSMutableArray *arrayKey = [NSMutableArray arrayWithArray:(  NSMutableArray *)[keys sortedArrayUsingSelector:@selector(compare:)]];
    
    NSString *keyStr =  [arrayKey objectAtIndex:0];//（A B C D……Z）
    //   NSArray *array = [letterDict objectForKey:keyStr];
    
     if([keyStr isEqualToString:@"#"]){
        [arrayKey removeObjectAtIndex:  0];
      
       // [arrayKey exchangeObjectAtIndex:0 withObjectAtIndex:[arrayKey count]-1];
         [arrayKey addObject:keyStr];
        // NSLog(@"arrayKey %@",arrayKey);
      }
 
    return  arrayKey;// [keys sortedArrayUsingSelector:@selector(compare:)];
}
 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _topView = [[TopFilerView alloc] init];
    [_topView setFrame:CGRectMake(0,0, kScreen_Width, 20)];
    
    _topView.tableView = self.tableViewCurrency;
    _topView.section = section;
    
    _topView.backgroundColor = RGB(253, 250, 252);
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, 150, 15)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    headerLabel.textColor = RGB(102, 102, 102);
    NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值（A B C D……Z）
    
    headerLabel.text = keys[section];
    
    [_topView addSubview:headerLabel];
    return  _topView;
}

//section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     
   NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
   return keys.count;
}
//每个section对应的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
    NSString *keyStr = keys[section];//（A B C D……Z）
    NSArray *array = [letterDict objectForKey:keyStr];//所有section下key值所对应的value的值
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}


//表格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    countyCell *cell = (countyCell *)[self.tableViewCurrency dequeueReusableCellWithIdentifier:@"countyCell"];
    if(cell==nil)
    {
        cell = [[countyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"countyCell"];
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"countyCell" owner:self options:nil];
        for(id oneObject in nibs)
        {
            if([oneObject isKindOfClass:[countyCell class]])
            {
                cell=(countyCell *)oneObject;
            }
        }
        
    }
    
    NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
    NSString *keyStr = keys[indexPath.section];
    NSArray *array = [letterDict objectForKey:keyStr];//所有section下key值所对应的value的值,array就是value值，存放的是model模型
    Country *model = [array objectAtIndex:indexPath.row];
    
     //NSLog(@"self.countryList %@",country);
    [cell configureCellForData:model];
     
    cell.accessoryType = UITableViewCellAccessoryNone;
    
     if (self.selectedSection == indexPath.section && self.selectedIndex == indexPath.row)
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
    
    return cell;
}

//索引 数组
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //if (self.searchController.active) {
      //  return nil;
   // }
    return [self getLetterDictAllKeys];
}
//索引 点击
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSLog(@"%@ -- %ld", title,(long)index);
    return [[UILocalizedIndexedCollation currentCollation]sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedSection = indexPath.section;
    self.selectedIndex = indexPath.row;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = -1;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


#pragma mark ----------------UISearchControllerDelegate---------------------
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
     NSLog(@"updateSearchResultsForSearchController");
}

#pragma mark --- 清除历史记录
-(void)cancelClick
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"history"];
    
    [self.historyListArray removeAllObjects];
    [self.tableViewCurrency reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"cancle");
}

- (IBAction)back:(id)sende{
   // _searchController.s
   // _searchController.searchBar.showsCancelButton = YES;
    _searchController.hidesNavigationBarDuringPresentation = YES;
   // _searchController.showsSearchResultsController =YES;
    //_searchController.view.hidden = YES;
   // [self cancelClick];
  //  [self updateSearchResultsForSearchController:_searchController];
     [self.navigationController popViewControllerAnimated:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
