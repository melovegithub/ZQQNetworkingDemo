//
//  ZQQNetWorkingManager.m
//  ZQQNetworkingDemo
//
//  Created by zqq on 15/11/30.
//  Copyright © 2015年 zqq. All rights reserved.
//

#import "ZQQNetWorkingManager.h"
#import "ZQQNetWorking.h"

@implementation ZQQNetWorkingManager

+(ZQQNetWorkingManager *)sharedManager{
    static ZQQNetWorkingManager *sharedNetworkingSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetworkingSingleton = [[self alloc] init];
    });
    return sharedNetworkingSingleton;
}


//测试GET请求
- (void)getWithUrl:(NSString *)url
           success:(ZQQResponseSuccess)success
             faile:(ZQQResponseFaile)faile{
    
    [[ZQQNetWorking sharedManager] getWithUrl:url
                                      success:^(id response) {
     
                                            success(response);
        
                                      } faile:^(NSError *error) {
       
                                           faile(error);
     
                                      }];
}

//测试POST请求
- (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(ZQQResponseSuccess)success
              faile:(ZQQResponseFaile)faile{
    [[ZQQNetWorking sharedManager] postWithUrl:url
                                        params:params
                                       success:^(id response) {
                                           success(response);
                                       } faile:^(NSError *error) {
                                           faile(error);
                                       }];
}


@end
