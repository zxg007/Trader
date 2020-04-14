//
//  CMRequestCallback.h
//  Tommrrow
//
//  Created by anyway on 2020/1/15.
//  Copyright © 2020 anyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBaseRequest;

@protocol AFMultipartFormData;

typedef void(^AFConstructingBodyBlock)(id<AFMultipartFormData> data);
typedef void(^AFURLSessionTaskProgressBlock)(NSProgress *progress);


/*!
 *   AFN 请求封装的Block回调
 */
typedef void(^CMRequestSuccessBlock)(NSInteger errCode,id responseDict, id model);
//typedef void(^CMRequestSuccessBlock)(NSInteger errCode, NSDictionary *responseDict, id model);
typedef void(^CMRequestFailureBlock)(NSError *error);


/*!
 *   AFN 请求封装的代理回调
 */
@protocol CMBaseRequestDelegate <NSObject>

@optional
/**
 *   请求结束
 *   @param returnData 返回的数据
 */
- (void)requestDidFinishLoadingWithData:(id)returnData errCode:(NSInteger)errCode;

/**
 *   请求失败
 *   @param error 失败的 error
 */
- (void)requestDidFailWithError:(NSError *)error;

/**
 *   网络请求项即将被移除掉
 *   @param item 网络请求项
 */
- (void)requestWillDealloc:(CMBaseRequest *)item;
@end
