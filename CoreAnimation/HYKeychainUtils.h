//
//  HYKeychainUtils.h
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/28.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYKeychainUtils : NSObject

/**
 *  将数据存入keychain
 *
 *  @param  data        数据
 *  @param  serviceModel 服务标示（key）
 *  @author xhy
 */
+ (void)saveInfo:(id)data serviceModel:(NSString *)serviceModel;

/**
 *  从keychain中读取数据
 *
 *  @param  serviceModel 服务标示（key）
 *
 *  @return keychain中解档的数据（id类型）
 *  @author xhy
 */
+ (id)loadInfoWithServiceModel:(NSString *)serviceModel;

/**
 *  从keychain中删除数据
 *
 *  @param serviceModel 服务标示（key）
 */
+ (void)deleteInfoWithServiceModel:(NSString *)serviceModel;

@end
