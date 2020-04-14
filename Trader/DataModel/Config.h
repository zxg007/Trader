

#import <Foundation/Foundation.h>
 
#import "Reachability.h"

@interface Config : NSObject


@property(strong) Reachability *baiduReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;

//是否具备网络链接
 @property  BOOL isNetworking;
-(BOOL) isConnectionAvailable;

//是否已经登录
@property BOOL isLogin;

- (void)setIsLogin;
- (BOOL)getIslogin;

//用户ID
-(void)setUserId:(NSString *)userString;
-(NSString *)getUserId;
//用户名
-(void)setUserName:(NSString *)display_name;
-(NSString *)getUserName;
//
-(void)setSessionId:(NSString *)sessionString;
-(NSString *)getSessionId;
//用户头 像
-(void)setUserFace:(NSString *)faceString;
-(NSString *)getUserFace;
 //
//服务商ID
-(void)setServiceId:(NSString *)serviceString;
-(NSString *)getServiceId;

//动态ID
-(void)setDynamicId:(NSString *)dynamicString;
-(NSString *)getDynamicId;


//保存正在编辑动态
- (void)setDynamicDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)getDynamicDictionary;

//保存部分数据
-(void)setDataRecommendsDict:(NSMutableDictionary *)dicRecos;
-(NSDictionary *)getRecommendsDic;

//保存广告
- (void)setAdvertiseDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)getAdvertiseDictionary;

//清除 保存本地的
- (void)clearAllInfo;

//判断手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum;
//获取 日期和格式
-(NSString *)getDateformate:(NSDate *)date;
//判断在字符串中是否包含相应的字符
-(BOOL)stringContainStringOrgin:(NSString *)strOrgin containStr:(NSString *)strContain;
 
//创建文件夹
- (NSString *)getFileFolder:(NSString *)folderName;
+ (Config *) Instance;
+ (id)allocWithZone:(NSZone *)zone;
@end
