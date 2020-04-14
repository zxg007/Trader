//
//  Config.m
//  Huake
//
//  Created by amway on 14-10-30.
//  Copyright (c) 2014年 BingJun. All rights reserved.
//

//
//  Config.m
//  yubang
//
//  Created by amway on 13-11-21.
//  Copyright (c) 2013年 yubang. All rights reserved.
//

#import "Config.h"

int getIndex (char ch);
BOOL isNumber (char ch);

int getIndex (char ch) {
    if ((ch >= '0'&& ch <= '9')||(ch >= 'a'&& ch <= 'z')||
        (ch >= 'A' && ch <= 'Z')|| ch == '_') {
        return 0;
    }
    if (ch == '@') {
        return 1;
    }
    if (ch == '.') {
        return 2;
    }
    return -1;
}

BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}


@implementation Config

@synthesize isLogin;

-(BOOL) isConnectionAvailable{
    self.baiduReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [self.baiduReach startNotifier];
    __weak __block typeof(self) weakself = self;
    weakself.isNetworking = YES;
    self.baiduReach.reachableBlock = ^(Reachability * reachability) {
      //  NSString * temp = [NSString stringWithFormat:@"www.baidu.com Block Says Reachable(%@)", reachability.currentReachabilityString];
       // NSLog(@"%@", temp);
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworking = YES;
        //});
        
    };
    self.baiduReach.unreachableBlock = ^(Reachability * reachability) {
      //  NSString * temp = [NSString stringWithFormat:@"www.baidu.com Block Says Unreachable(%@)", reachability.currentReachabilityString];
      //  NSLog(@"%@", temp);
       // dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworking = NO;
       // });
    };
    
    self.localWiFiReach = [Reachability reachabilityForLocalWiFi];
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    self.localWiFiReach.reachableOnWWAN = NO;
    [self.localWiFiReach startNotifier];
    self.localWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
      //  NSString * temp = [NSString stringWithFormat:@"LocalWIFI Block Says Reachable(%@)", reachability.currentReachabilityString];
     //   NSLog(@"%@", temp);
        //dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworking = YES;
        //});
    };
    self.localWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"LocalWIFI Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
        //dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworking = NO;
        
       // });
    };
    // create a Reachability object for the internet
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    [self.internetConnectionReach startNotifier];
    
    self.internetConnectionReach.reachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@" InternetConnection Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        // dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworking = YES;
        //});
    };
    
    self.internetConnectionReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"InternetConnection Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
      //  dispatch_async(dispatch_get_main_queue(), ^{
            weakself.isNetworking = NO;
      //  });
    };
    return weakself.isNetworking;
}

-(void)setIsLogin  {
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"OJUJUISLogin"];
    [settings setObject:[NSNumber numberWithBool:isLogin] forKey:@"OJUJUISLogin"];
    NSLog(@"isLogin value: %@" ,isLogin?@"YES":@"NO");
    [settings synchronize];
}
//
- (BOOL)getIslogin{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"OJUJUISLogin"] boolValue];
}

//用户ID
-(void)setUserId:(NSString *)userStringg{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuUserIdString"];
    [setting setObject:userStringg forKey:@"ojujuUserIdString"];
    [setting synchronize];
}

-(NSString *)getUserId{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *userId = [settings objectForKey:@"ojujuUserIdString"];
    return userId;
}


//用户名
-(void)setUserName:(NSString *)display_name{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuDisplay_nameString"];
    [setting setObject:display_name forKey:@"ojujuDisplay_nameString"];
    [setting synchronize];
}
-(NSString *)getUserName{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *display_name = [settings objectForKey:@"ojujuDisplay_nameString"];
    return display_name;
}


-(void)setSessionId:(NSString *)sessionString{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuSessionIdString"];
    [setting setObject:sessionString forKey:@"ojujuSessionIdString"];
    [setting synchronize];
    
    
}
-(NSString *)getSessionId;{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *SessionId = [settings objectForKey:@"ojujuSessionIdString"];
    return SessionId;
}

//用户头 像
-(void)setUserFace:(NSString *)faceString{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuUserFaceString"];
    [setting setObject:faceString forKey:@"ojujuUserFaceString"];
    [setting synchronize];
}

-(NSString *)getUserFace{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *faceString = [settings objectForKey:@"ojujuUserFaceString"];
    return faceString;
}


//服务商ID
-(void)setServiceId:(NSString *)serviceString{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuServiceString"];
    [setting setObject:serviceString forKey:@"ojujuServiceString"];
    [setting synchronize];
}
-(NSString *)getServiceId{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *serviceString = [settings objectForKey:@"ojujuServiceString"];
    return serviceString;
}
//动态ID
-(void)setDynamicId:(NSString *)dynamicString{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuDynamicString"];
    [setting setObject:dynamicString forKey:@"ojujuDynamicString"];
    [setting synchronize];
}
//
-(NSString *)getDynamicId{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *dynamicString = [settings objectForKey:@"ojujuDynamicString"];
    return dynamicString;
}
//保存正在编辑动态
- (void)setDynamicDictionary:(NSDictionary *)dictionary{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuDynamicDictionary"];
    [setting setObject:dictionary forKey:@"ojujuDynamicDictionary"];
    [setting synchronize];
}

- (NSDictionary *)getDynamicDictionary{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSDictionary *dynamic  = [settings objectForKey:@"ojujuDynamicDictionary"];
    return dynamic;
    
}

//保存广告
- (void)setAdvertiseDictionary:(NSDictionary *)dictionary{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuAdvertiseDictionary"];
    [setting setObject:dictionary forKey:@"ojujuAdvertiseDictionary"];
    [setting synchronize];

}
- (NSDictionary *)getAdvertiseDictionary{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSDictionary *adviser  = [settings objectForKey:@"ojujuAdvertiseDictionary"];
    return adviser;

}

//保存部分数据
-(void)setDataRecommendsDict:(NSMutableDictionary *)dicRecos{
     
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"ojujuRecommendsDictionary"];
    [setting setObject:dicRecos forKey:@"ojujuRecommendsDictionary"];
    [setting synchronize];
}

-(NSDictionary *)getRecommendsDic{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSDictionary *dataRecommendsDic  = [settings objectForKey:@"ojujuRecommendsDictionary"];
    return dataRecommendsDic;
    
}


//请除所有
- (void)clearAllInfo{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"ojujuUserIdString"];
    [settings removeObjectForKey:@"ojujuDisplay_nameString"];
    [settings removeObjectForKey:@"ojujuDynamicString"];
    [settings removeObjectForKey:@"ojujuServiceString"];
    [settings removeObjectForKey:@"OJUJUISLogin"];
    [settings removeObjectForKey:@"ojujuDynamicDictionary"];
    [settings removeObjectForKey:@"ojujuUserFaceString"];
    [settings removeObjectForKey:@"ojujuSessionIdString"];
    [settings removeObjectForKey:@"ojujuRecommendsDictionary"];
     [settings removeObjectForKey:@"ojujuAdvertiseDictionary"];
    
    [settings synchronize];
}
//判断手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//获取 日期和格式
-(NSString *)getDateformate:(NSDate *)date{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:date];
    return dateString;
}
//判断在字符串中是否包含相应的字符
-(BOOL)stringContainStringOrgin:(NSString *)strOrgin containStr:(NSString *)strContain
{
    NSRange ran = [strOrgin rangeOfString:strContain];
    if (ran.length > 0) {
        return  YES;
    }else{
        return NO;
    }
    return NO;
}

// 

//创建文件夹
- (NSString *)getFileFolder:(NSString *)folderName{
    NSString *dic = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *str = [dic stringByAppendingPathComponent:@"ojuju"];
    NSString *filePath = [str stringByAppendingPathComponent:folderName];
    BOOL  isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
    
}

static Config * instance = nil;
+(Config *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

@end
