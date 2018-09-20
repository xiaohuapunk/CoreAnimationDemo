//
//  HYKeychainUtils.m
//  CoreAnimation
//
//  Created by XZM_XHY on 15/5/28.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "HYKeychainUtils.h"

@implementation HYKeychainUtils

+ (NSMutableDictionary *)getKeychainQueryWithServiceModel:(NSString *)serviceModel
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClass,
            serviceModel, (__bridge id)kSecAttrServer,
            serviceModel, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock, (__bridge id)kSecAttrAccessible,
            nil];
}

+ (void)saveInfo:(id)data serviceModel:(NSString *)serviceModel
{
    NSMutableDictionary *keychainQuery = [self getKeychainQueryWithServiceModel:serviceModel];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id<NSCopying>)(kSecValueData)];
    SecItemAdd((__bridge CFDictionaryRef)(keychainQuery), NULL);
}

+ (id)loadInfoWithServiceModel:(NSString *)serviceModel
{
    id resultData = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQueryWithServiceModel:serviceModel];
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
//    [keychainQuery setObject:(__bridge id)(kSecMatchLimitOne) forKey:(__bridge id<NSCopying>)(kSecMatchLimit)];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)(keychainQuery), (CFTypeRef *)&keyData) == noErr) {
        @try {
            resultData = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)(keyData)];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed:%@",serviceModel, exception);
        }
        @finally {
            
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    return resultData;
}

+ (void)deleteInfoWithServiceModel:(NSString *)serviceModel
{
    NSMutableDictionary *keychainQuery = [self getKeychainQueryWithServiceModel:serviceModel];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
}

@end
