
//测试环境

//正式环境
   

#define IOS_VERSION  [[UIDevice currentDevice].systemVersion floatValue]
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))

#define NUMBERSINPUT @"0123456789\n"
#define MONEYSINPUT   @"0123456789.\n"
//插广告间隔
#define AD_DEFAULT_MARGIN 5
//手机屏幕
#define IS_IPHONE_4   ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE_5   ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE_6   ([[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE_6plus   ([[UIScreen mainScreen] bounds].size.height == 736)

#define navBarHeight   self.navigationController.navigationBar.frame.size.height
//
#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

#define BG_COLOR                    RGB(248,248,248)
#define BG_GRAY_COLOR               RGB(242,242,242)

#define TABBAR_TEXT_NOR_COLOR       RGB(120, 118, 119)
#define TABBAR_TEXT_HLT_COLOR       RGB(26,187,153)

//新浪财经
#define Sina_BaseUrl "https://hq.sinajs.cn/"
 
//火币huobipro API接口列表
#define Huobi_BaseUrl "https://api.huobi.pro/"
 //
#define sina_URL  @"http://image.sinajs.cn/newchart/"
//网络访问失败
#define netWorkMessage @"抱歉，网络访问失败!"
 
#define dataBaseName @"ExchangeMNDb.db"
#define dataBasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject] stringByAppendingPathComponent:dataBaseName]


