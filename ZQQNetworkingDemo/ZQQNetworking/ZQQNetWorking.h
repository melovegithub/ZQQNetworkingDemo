//
//  ZQQNetWorking.h
//  ZQQNetworkingDemo
//
//  Created by zqq on 15/11/30.
//  Copyright © 2015年 zqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class AFHTTPRequestOperation;

//避免直接使用AFHTTPRequestOperation,减少对其依赖
typedef AFHTTPRequestOperation ZQQRequestOperation;

/**
 *  请求成功的回调
 *
 *  @param response 服务端返回的数据类型，通常是字典
 */
typedef void(^ZQQResponseSuccess) (id response);

/**
 *  请求失败的回调
 *
 *  @param error 错误信息
 */
typedef void(^ZQQResponseFaile) (NSError *error);


@interface ZQQNetWorking : NSObject

+(ZQQNetWorking *)sharedManager;

/**
 *  开启或者关闭接口打印信息
 *
 *  @param isDebug 默认是NO
 */
- (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  GET请求接口,不带参数
 *
 *  @param url     接口url
 *  @param success 成功请求到数据的回调
 *  @param faile   请求数据失败的回调
 *
 *  @return 返回类型有取消请求的api
 */
- (ZQQRequestOperation *)getWithUrl:(NSString *)url
                            success:(ZQQResponseSuccess)success
                              faile:(ZQQResponseFaile)faile;

/**
 *  GET请求接口,带参数
 *
 *  @param url     接口url
 *  @param params  接口中所需要的拼接参数
 *  @param success 成功请求到数据的回调
 *  @param faile   请求数据失败的回调
 *
 *  @return 返回类型有取消请求的api
 */
- (ZQQRequestOperation *)getWithUrl:(NSString *)url
                             params:(NSDictionary *)params
                            success:(ZQQResponseSuccess)success
                              faile:(ZQQResponseFaile)faile;

/**
 *  POST请求接口
 *
 *  @param url     接口url
 *  @param params  接口中所需要的拼接参数
 *  @param success 成功请求到数据的回调
 *  @param faile   请求数据失败的回调
 *
 *  @return 返回类型有取消请求的api
 */
- (ZQQRequestOperation *)postWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                             success:(ZQQResponseSuccess)success
                               faile:(ZQQResponseFaile)faile;

/**
 *  图片上传接口
 *
 *  @param image    图片对象
 *  @param url      上传图片接口的urtl
 *  @param filename 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name     与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param success  上传成功的回调
 *  @param faile    上传失败的回调
 *
 *  @return 返回类型有取消请求的api
 */
- (ZQQRequestOperation *)uploadWithImage:(UIImage *)image
                                     url:(NSString *)url
                                filename:(NSString *)filename
                                    name:(NSString *)name
                                 success:(ZQQResponseSuccess)success
                                   faile:(ZQQResponseFaile)faile;

@end
