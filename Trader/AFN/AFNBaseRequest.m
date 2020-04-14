//
//  AFNBaseRequest.m
//  Tommrrow
//
//  Created by anyway on 2020/1/14.
//  Copyright © 2020 anyway. All rights reserved.
//

#import "AFNBaseRequest.h"

#define kCertificateName @"httpsServerAuth"


#ifdef DEBUG //处于开发测试阶段

// * const OKNetworkDomain = @"http://101.200.139.156";
 //NSString * const OKNetworkDomain = @"http://www.xiaoban.mobi";
NSString * const AFNNetworkDomain = @"https://jsonplaceholder.typicode.com";

///< 关闭https SSL 验证
#define kOpenHttpsAuth NO

#else //处于发布正式阶段
NSString * const AFNNetworkDomain = @"https://jsonplaceholder.typicode.com";

//NSString * const OKNetworkDomain = @"http://www.xiaoban.mobi";

///< 开启https SSL 验证
#define kOpenHttpsAuth YES

#endif


@interface AFNBaseRequest ()

{
    NSInteger _page;
    NSString *_url;
    NSString *_timestamp;
    NSTimeInterval _timeoutInterval;
    BOOL _networkIsError;
     AFHTTPSessionManager *_manager;
     NSURLSessionDataTask *_dataTask;
    
}
@end

@implementation AFNBaseRequest
- (instancetype)init {
    self = [super init];
    if (self) {
       [self initHttpSessionManager];
    }
    return self;
}

- (void)initHttpSessionManager {
    _networkIsError = NO;
    _page = -1;
    _showHUD = NO;
    _timeoutInterval = 10.;
    
   // self.successBlock = nil;
  //  self.failureBlock = nil;
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }

   // _processingQueue = dispatch_group_create();

    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
   //  _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/html",nil];
    
   // _manager.completionGroup = _processingQueue;
    NSLog(@"initHttpSessionManager");
    
}
- (void)startCompletionBlockWithSuccess:(AFNRequestSuccessBlock)success
                                failure:(AFNRequestFailureBlock)failure{
    self.successBlock = success;
    self.failureBlock = failure;
}
 

- (void)startRequest {
    NSLog(@"startRequest");
  /*  _networkIsError = [[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus] == NotReachable ? YES : NO;
    if (_networkIsError) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"网络连接暂时不可用", @"")];
        });
        return;
     }*/

    //拼接请求路径
     [self constructURL];
     NSURL *URL = [NSURL URLWithString:_url];
     NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //开启状态栏网络状态小菊花
   // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
       _dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
           if (error) {
              NSLog(@"Error: %@", error);
     } else {
           [self handleData:response responseObject:responseObject error:error];
        
        //关闭状态栏网络状态小菊花
            //   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
           // NSLog(@"%@ responseObject: %@", response, responseObject);
        }
    }];
    [_dataTask resume];
    
//    if (self.showHUD) {
//        [SVProgressHUD show];
//    }
    
}
//
- (void)constructURL {
    _url = [NSString stringWithFormat:@"%@%@", AFNNetworkDomain, [self requestURLPath]];
}

- (void)clearCompletionBlock {
    self.successBlock = nil;
    self.failureBlock = nil;
}



- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    return nil;
}

- (AFNRequestMethod)requestMethod {
    return AFNRequestMethodGET;
}

- (AFNRequestSerializerType)requestSerializerType {
    return AFNRequestSerializerTypeHTTP;
}

- (AFNResponseSerializerType)responseSerializerType{
    return AFNResponseSerializerTypeJSON;
}

- (NSDictionary *)requestArguments {
    NSAssert([self isMemberOfClass:[AFNBaseRequest class]], @"子类必须实现requestArguments");
    return nil;
}

- (NSString *)requestURLPath {
    NSAssert([self isMemberOfClass:[AFNBaseRequest class]], @"子类必须实现requestURLPath");
    return nil;
}
/*
- (AFConstructingBodyBlock)constructingBodyBlock {
    return nil;
}*/

- (void)handleData:(NSURLResponse *)response
responseObject:(id)responseObject
         error:(NSError *)error {
    NSAssert([self isMemberOfClass:[AFNBaseRequest class]], @"子类必须实现handleData:data errCode:errCode");
    if (error) {
             
            _showHUD = YES;
            if (self.failureBlock) {
                self.failureBlock(error);
            }

            if (_delegate && [_delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
                [_delegate requestDidFailWithError:error];
            }

            if (_showHUD) {
              //  [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
            } else {
              //  [SVProgressHUD dismiss];
            }
            _showHUD = NO;
        }
        else {
             
            
            if (_showHUD) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   // [SVProgressHUD dismiss];
                });
                _showHUD = NO;
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self clearCompletionBlock];
        });
    
}

/**
 *  新增的方法，用来验证https证书
 *
 *  @return 证书模式的SecurityPolicy，AFSecurityPolicy有3种安全验证方式
 *          具体看头文件的枚举
 */
- (AFSecurityPolicy *)customSecurityPolicy {
    //先导入证书到项目
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kCertificateName ofType:@"cer" inDirectory:@"HttpsServerAuth.bundle"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];

    NSLog(@"%@--%@", cerPath, cerData);

    //AFSSLPinningModeCertificate使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;

    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;

    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证，因为整个证书链一一比对是完全没有必要（请查看源代码）；
//    securityPolicy.validatesCertificateChain = NO;

    NSSet *cerDataSet = [NSSet setWithArray:@[cerData]];
    securityPolicy.pinnedCertificates = cerDataSet;

    return securityPolicy;
}

- (void)cancelRequest {
    // 取消请求
    // 仅仅是取消请求, 不会关闭session
    if (_manager.tasks.count > 0) { ///< 取消之前所有的任务
        [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
    
//    [_manager.operationQueue cancelAllOperations];
    
//    // 关闭session并且取消请求(session一旦被关闭了, 这个manager就没法再发送请求)
//    [_manager invalidateSessionCancelingTasks:YES];
//    _manager = nil;
//
//    // 一个任务被取消了, 会调用AFN请求的failure这个block
//    [task cancel];
}

@end
