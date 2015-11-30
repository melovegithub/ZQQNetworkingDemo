//
//  ZQQNetWorkingManager.h
//  ZQQNetworkingDemo
//
//  Created by zqq on 15/11/30.
//  Copyright © 2015年 zqq. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@interface ZQQNetWorkingManager : NSObject

+(ZQQNetWorkingManager *)sharedManager;

//测试GET请求
- (void)getWithUrl:(NSString *)url
                            success:(ZQQResponseSuccess)success
                              faile:(ZQQResponseFaile)faile;

//测试POST请求
- (void)postWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                             success:(ZQQResponseSuccess)success
                               faile:(ZQQResponseFaile)faile;

@end
