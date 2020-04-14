//
//  CharteeViewController.m
//  Trader
//
//  Created by anyway on 2020/1/16.
//  Copyright © 2020 anyway. All rights reserved.
//
//

#import "CharteeViewController.h"
//#import "UIViewController+safeArea.h"
#import "CountryDB.h"
#import "CurrencyPairsDB.h"
#import "ExchangeCell.h"
#import "Currency.h"
#import "PPiFlatSegmentedControl.h"
#import "AFCurreniesRequest.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
static NSString *cellExchangID = @"cellExchangID";
@interface CharteeViewController (){
    //定时发送0.5秒定时
    NSTimer *timer;
    NSString *_strCurrencies;
    __block NSMutableDictionary *letterDict;
}
@property (nonatomic, assign) __block BOOL isLoading;
@property (nonatomic, assign) __block BOOL isDirect;
@property (nonatomic, strong) PPiFlatSegmentedControl *segmentControl;
@property (nonatomic, strong) NSMutableArray *dataCurrencies;
/** 红色view 用于置顶 */
 @property (nonatomic, strong)  UIView *redView;
/** 橘色view 用于置底 */
 @property (nonatomic, strong) UIView *orangeView;

@end

@implementation CharteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"货币汇率";
    _isLoading = NO;
    _isDirect  = YES;
    /** 创建红色view  导航栏*/
    UIView * redView = [UIView new];
    redView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:redView];
    self.redView = redView;
    [self setSegmentControl];
    self.dataCurrencies = [[NSMutableArray alloc] init];
     self->letterDict = [[NSMutableDictionary alloc] init];
    [self setExtraCellLineHidden:self.tableViewCurrencies];
    /** 创建橘色view
    UIView * orangeView = [UIView new];
    orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;
    */
    [self loadCurrenciesData];
    if(timer == nil)
        timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(requestCurrencies) userInfo:nil repeats:YES];
}

//推荐消息
-(void)setSegmentControl{
    _segmentControl = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(40, 116, kScreen_Width-80, 40)
                                                               items:@[[[PPiFlatSegmentItem alloc]
                                                                        initWithTitle:NSLocalizedString(@"基本盘汇率", nil) andIcon:nil], [[PPiFlatSegmentItem alloc]
                                                                                                                                   initWithTitle:NSLocalizedString(@"交叉盘汇率", nil) andIcon:nil],
                                                                       [[PPiFlatSegmentItem alloc]
                                                                        initWithTitle:NSLocalizedString(@"汇率转换", nil) andIcon:nil]]
                                                        iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex){
                                                            NSLog(@"Index %li", (long)segmentIndex);
                                                            switch (segmentIndex) {
                                                                case 0:
                                                                    if(self->_isLoading  == YES)
                                                                                    return;
                                                                  self-> _isDirect  = YES;
                                                    [self reloadTableDatas];
                                                                    break;
                                                                case 1:
                                                                    if(self->_isLoading  == YES)
                                                                          return;
                                                                    self-> _isDirect  = NO;
                                                    [self reloadTableDatas];
                                                    
                                                                    break;
                                                                case 2:
                                                                    
                                                                    [self toExchange];
                                                                    
                                                                    break;
                                                                    
                                                                default:
                                                                    break;
                                                                    
                                                            }
                                                            
                                                        }
                                                      iconSeparation:0];
    _segmentControl.layer.cornerRadius = 5;
    _segmentControl.color= RGB(220.0 , 220.0 , 220.0);//[UIColor clearColor];
    _segmentControl.borderWidth=1.3;
    _segmentControl.borderColor= RGB(220.0 , 220.0 , 220.0);
    _segmentControl.selectedColor=RGB(220.0 , 220.0 , 220.0);//[UIColor colorWithRed:228.0f/255.0 green:153.0f/255.0 blue:81.0f/255.0 alpha:1];
    _segmentControl.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]};
    _segmentControl.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:RGB(36, 36, 36)};
    // [segmentControl setSegmentAtIndex:1 enabled:YES];
    _segmentControl.center = CGPointMake(kScreen_Width/2, 116);
    [self.view addSubview:_segmentControl];
}

-(void)toExchange{
//     [self setHidesBottomBarWhenPushed:YES];
//        JoinUpSocketViewController *exchange = [[JoinUpSocketViewController alloc] init];
//        [self.navigationController pushViewController:exchange animated:YES];
//
//        [self setHidesBottomBarWhenPushed:NO];
//
}
-(void)reloadTableDatas{
    self->_isLoading = YES;
    [self.dataCurrencies removeAllObjects];
    [self->letterDict removeAllObjects];
    [self.tableViewCurrencies reloadData];
    [self loadCurrenciesData];
}

-(void)loadCurrenciesData{
    NSString *stringTemp = @"";
    NSArray *array = [[NSArray alloc] init];
    if(_isDirect == YES)
       array =   [CurrencyPairsDB findAllDirectCurrencyPairsArray];
    else{
         array =   [CurrencyPairsDB findAllCrossingCurrencyPairsArray];
    }
    for(int a= 0; a<[array count]; a++){
        CurrencyPairs *pairs =   [array objectAtIndex:a];
        stringTemp = [stringTemp stringByAppendingFormat:@"%@,", pairs.pairsEnName];
        
    }
    _strCurrencies = [stringTemp substringToIndex: stringTemp.length-1];
    self->_isLoading = NO;
    [self requestCurrencies];
}
-(void)requestCurrencies{
    if(self->_isLoading  == YES)
       return;
    self->_isLoading = YES;
    
   [self.dataCurrencies removeAllObjects];
   [self->letterDict removeAllObjects];
    
  // [self.tableViewCurrencies reloadData];
    AFCurreniesRequest *instanceReq = [[AFCurreniesRequest alloc] init];
    [instanceReq startCompletionBlockWithSuccess:^(NSInteger errCode, id responseDict, id model) {
      //  NSStringEncodingConversionAllowLossy
        
        NSString * content = [[NSString alloc] initWithData:responseDict encoding:kCFStringEncodingUTF8];
        NSArray *lines = [content componentsSeparatedByString:@";"];
         //NSASCIIStringEncoding
        //kCFStringEncodingUTF8
        //NSData *latin1Data = [appName dataUsingEncoding:NSUTF8StringEncoding];
      //  appName = [[[NSString alloc] initWithData:latin1Data encoding:NSISOLatin1StringEncoding] autorelease];
         //NSInteger idx;
         for (int a = 0; a < [lines count]; a++) {
            NSString *dic  = [lines objectAtIndex:a];
              if([dic containsString:@"="] ){
                  Currency *curren = [[Currency alloc] init];
                  NSRange startRange = [dic rangeOfString:@"hq_str_"];
                  NSRange endRange = [dic rangeOfString:@"="];
                  NSRange range = NSMakeRange(startRange.location + startRange.length,endRange.location - startRange.location - startRange.length);
                  NSString *result = [dic substringWithRange:range];
                   curren.symbolEnName = result;
                   NSArray *tempArray = [dic componentsSeparatedByString:@"="];
                  
                   NSLog(@"line %@  ",result);
                   
                  NSMutableArray *dataArray  = [NSMutableArray arrayWithObject:[tempArray lastObject]];
                   
                  if([dataArray count] >0){
                      //
                      NSString *stringTemp  = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:0]];
                      NSArray *currArray = [stringTemp componentsSeparatedByString:@","];
                      if([currArray count] >0){
                       //   NSString * nameCun = [[NSString alloc] initWithData:[currArray objectAtIndex:9] encoding:NSISOLatin1StringEncoding];
                          NSString *tempString = [NSString stringWithFormat:@"%@",[currArray objectAtIndex:9]];
                         //  NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(NSStringEncodingConversionAllowLossy);
                          
                          NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
                            NSData *encData =[tempString dataUsingEncoding:encoding];
                            NSString *retStr = [[NSString alloc] initWithData:encData encoding:encoding];
                           NSLog(@"currArray %@  ",retStr);
                          curren.lastedPrice = [currArray objectAtIndex:1];
                          
                          curren.askPrice = [currArray objectAtIndex:2];
                          curren.bidPrice = [currArray objectAtIndex:3];
                          
                      }
                      //
                      
                  }
                  if(self-> _isDirect== NO){
                      CurrencyPairs *pairs = [CurrencyPairsDB findCurrencyPair:curren.symbolEnName];
                   curren.currencyTag = pairs.currencyTag;
                     }
               [self.dataCurrencies addObject:curren];
              }
         
         }
        
         if(self-> _isDirect== NO)

             //遍历
             for (Currency *model in self.dataCurrencies) {
                 NSMutableArray *letterArr = self-> letterDict[model.currencyTag];
                 //判断数组里是否有元素，如果为nil，则实例化该数组，并在cityDict字典中插入一条新的数据
                 if (letterArr == nil) {
                     letterArr = [[NSMutableArray alloc] init];
                     [self-> letterDict setObject:letterArr forKey:model.currencyTag];
                 }
                 //将新数据放到数组里
                 [letterArr addObject:model];
             }
         [self.tableViewCurrencies reloadData];
           
    } failure:^(NSError *error) {
       // _isLoading = NO;
        NSLog(@"error:%@", error.localizedFailureReason);
    }];
    
    instanceReq.showHUD = NO;
    instanceReq.CMNetworkDomain = [NSString stringWithFormat:@"%s",Sina_BaseUrl];
    instanceReq.list = _strCurrencies;
    [instanceReq startRequest];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

#pragma mark - 获得所有的key值并排序，并返回排好序的数组
- (NSArray *)getLetterDictAllKeys
{
    //获得cityDict字典里的所有key值，
    NSArray *keys = [letterDict allKeys];
    //打印
    // NSLog(@"keys = %@",[keys sortedArrayUsingSelector:@selector(compare:)]);
    //按升序进行排序（A B C D……）
    return [keys sortedArrayUsingSelector:@selector(compare:)];
}


#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self->_isDirect == YES)
        return 1;
    else{
        NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
        return keys.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(self->_isDirect == YES)
        return 0;
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self->_isDirect == YES)
        return nil;
    else{
        _topView = [[TopFilerView alloc] init];
        [_topView setFrame:CGRectMake(0,0, kScreen_Width, 20)];
    
        _topView.tableView = self.tableViewCurrencies;
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self->_isDirect == YES)
       return [self.dataCurrencies count];
    else{
        NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
        NSString *keyStr = keys[section];//（A B C D……Z）
        NSArray *array = [letterDict objectForKey:keyStr];//所有section下key值所对应的value的值
        return array.count;
    }
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeCell *cell = (ExchangeCell *)[self.tableViewCurrencies dequeueReusableCellWithIdentifier:cellExchangID];
    if(cell==nil)
    {
        cell = [[ExchangeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellExchangID];
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"ExchangeCell" owner:self options:nil];
        for(id oneObject in nibs)
        {
            if([oneObject isKindOfClass:[ExchangeCell class]])
            {
                cell=(ExchangeCell *)oneObject;
            }
        }
        
    }
     if(self->_isDirect == YES){
        Currency *currency = [self.dataCurrencies objectAtIndex:indexPath.row];
        [cell configureCellForData:currency];
     }
     else{
         NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
         NSString *keyStr = keys[indexPath.section];
         NSArray *array = [self->letterDict objectForKey:keyStr];//所有section下key值所对应的value的值,array就是value值，存放的是model模型
         Currency *currency = [array objectAtIndex:indexPath.row];
         [cell configureCellForData:currency];
     }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.dataCurrencies count] ==0)
        return;
    if(self->_isLoading)
        return;
    NSLog(@"didSelectRowAtIndexPath");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.view endEditing:YES];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     // 下面这几行代码是用来设置cell的上下行线的位置
     if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
     [cell setLayoutMargins:UIEdgeInsetsZero];
     }
     //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
     if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
     [cell setPreservesSuperviewLayoutMargins:NO];
     }
     
     */
    if(self->_isDirect == YES){
        
        if([self.dataCurrencies count]>0 && [indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            self->_isLoading = NO;
        }
    }
    else{
        
        NSArray *keys = [self getLetterDictAllKeys];//获得所有的key值
         NSIndexPath *rowLast   =  (NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]   ;
        
        NSString *keyStr = keys[rowLast.section];
        NSArray *array = [self->letterDict objectForKey:keyStr];
        if([array count] -1 == rowLast.row ){
                  self->_isLoading = NO;
              
        }
            
    }
    
}

#pragma mark - 设置视图frame
- (void)viewWillLayoutSubviews {
    
    /**
     layoutFrame.size.width 安全区域宽度
     layoutFrame.size.height 安全区域高度
     */
    CGRect layoutFrame = self.view.safeAreaLayoutGuide.layoutFrame;
   // NSLog(@"self.view - layoutFrame - %@", NSStringFromCGRect(layoutFrame));
    
    /**
     inset.left 安全区域距离屏幕最左边的大小
     inset.right 安全区域距离屏幕最右边的大小
     inset.top 安全区域距离屏幕最上边的大小
     inset.bottom 安全区域距离屏幕最下边的大小
     */
    UIEdgeInsets insets = self.view.safeAreaInsets;
    
    /** 红色view置顶 */
    self.redView.frame = CGRectMake(insets.left, insets.top-88, layoutFrame.size.width, 88);
    
    /** 橘色view置底 */
    self.orangeView.frame = CGRectMake(insets.left, self.view.bounds.size.height - insets.bottom - 100, layoutFrame.size.width, 100);
}

- (void)viewDidAppear:(BOOL)animated{
    
    
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
