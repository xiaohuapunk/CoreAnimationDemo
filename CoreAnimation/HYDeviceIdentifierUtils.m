//
//  HYDeviceIdentifierUtils.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/28.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDeviceIdentifierUtils.h"
#import "CommonCrypto/CommonDigest.h"
#import "HYKeychainUtils.h"

NSString * const KEY_SERVICE_MODEL_IDFV = @"service_model_idfv";
NSString * const KEY_DEVICE_IDFV = @"device_idfv_key";

@implementation HYDeviceIdentifierUtils

// MD5
+(NSString *)md5:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)deviceIdentifier
{
    id __keychainData = [HYKeychainUtils loadInfoWithServiceModel:KEY_SERVICE_MODEL_IDFV];
    if (__keychainData || [__keychainData isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)__keychainData objectForKey:KEY_DEVICE_IDFV];
    }
    
    NSString *__idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *__idfvMd5 = [self md5:__idfv];
    __keychainData = [NSDictionary dictionaryWithObject:__idfvMd5 forKey:KEY_DEVICE_IDFV];
    [HYKeychainUtils saveInfo:__keychainData serviceModel:KEY_SERVICE_MODEL_IDFV];
    return __idfvMd5;
}
@end
