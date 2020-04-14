//
//  AFNBaseRequest.h
//  Tommrrow
//
//  Created by anyway on 2020/1/14.
//  Copyright © 2020 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "AFNRequestCallback.h"

extern NSString * const AFNNetworkDomain; //
///< HTTP Request method.
typedef NS_ENUM(NSInteger, AFNRequestMethod) {
    AFNRequestMethodGET = 0,
    AFNRequestMethodPOST
};

///< Request serializer type.
typedef NS_ENUM(NSInteger, AFNRequestSerializerType) {
    AFNRequestSerializerTypeHTTP = 0,
    AFNRequestSerializerTypeJSON
};

///< Response serializer type, which determines response serialization process and
///  the type of `responseObject`.
typedef NS_ENUM(NSInteger, AFNResponseSerializerType) {
    AFNResponseSerializerTypeHTTP = 0, ///< NSData
    AFNResponseSerializerTypeJSON, ///< JSON
    AFNResponseSerializerTypeXMLParser ///< NSXMLParser
};

/*!
 *   AFN 请求封装的Block回调
 */

@interface AFNBaseRequest : NSObject

@property (nonatomic, assign) BOOL showHUD;

@property (nonatomic, weak) id<AFNBaseRequestDelegate> delegate;
@property (nonatomic, copy) AFNRequestSuccessBlock successBlock;
@property (nonatomic, copy) AFNRequestFailureBlock failureBlock;

 
- (void)startCompletionBlockWithSuccess:(AFNRequestSuccessBlock)success
failure:(AFNRequestFailureBlock)failure;

/**
 * @brief 公共方法，开始请求，不管是使用 block 回调还是 delegate 回调，都要调用此方法
 */
- (void)startRequest;


/**
 * @brief 请求参数，即URL入参
 *
 * @warning 必须重写
 */
- (NSDictionary *)requestArguments;

/**
 * @brief 请求URL路径
 *
 * @warning 必须重写
 */
- (NSString *)requestURLPath;

/**
 * @brief 请求方式 GET or POST
 *
 * @warning 按需重写
 */
- (AFNRequestMethod)requestMethod; ///< 默认 GET 请求

/**
 * @brief 请求序列类型
 *
 * @warning 按需重写
 */
- (AFNRequestSerializerType)requestSerializerType;

/**
 * @brief 响应序列类型
 *
 * @warning 按需重写
 */
- (AFNResponseSerializerType)responseSerializerType;

/**
 * @brief 设置请求头
 *
 * @warning 按需重写
 */
- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary; ///< Additional HTTP request header field. HTTP 请求头配置，按需重写

/**
 * 处理请求返回的数据，字典转模型，利用 Mantle
 *@param response 需要的数据
 * @param responseObject 需要的数据
 * @param error 后台返回的错误码（代表各种情况）
 */
- (void)handleData:(NSURLResponse *)response
            responseObject:(id)responseObject
                     error:(NSError *)error;

/**
 * 取消请求
 *
 * @notice 仅仅是取消请求, 不会关闭session. 关闭session并且取消请求(session一旦被关闭了,
 *         这个manager就没法再发送请求)
 */
- (void)cancelRequest;

@end

