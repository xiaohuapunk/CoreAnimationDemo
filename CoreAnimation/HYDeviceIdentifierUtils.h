//
//  HYDeviceIdentifierUtils.h
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/28.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDeviceIdentifierUtils : NSObject

/**
 *  获取设备唯一标示符 (原理通过将设备IDFV标示符MD5值存储到keychain中)
 *
 *  @return 标示符（idfv）
 */
+ (NSString *)deviceIdentifier;

@end
