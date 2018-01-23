//
//  FICUtilities.m
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/20.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

//
//  FICUtilities.m
//  FastImageCache
//
//  Copyright (c) 2013 Path, Inc.
//  See LICENSE for full license agreement.
//

#import "FICUtilities.h"


#pragma mark - Byte Alignment

inline size_t FICByteAlign(size_t width, size_t alignment) {
    return ((width + (alignment - 1)) / alignment) * alignment;
}

inline size_t FICByteAlignForCoreAnimation(size_t bytesPerRow) {
    return FICByteAlign(bytesPerRow, 64);
}

#pragma mark - Strings and UUIDs

NSString * FICStringWithUUIDBytes(CFUUIDBytes UUIDBytes) {
    NSString *UUIDString = nil;
    CFUUIDRef UUIDRef = CFUUIDCreateFromUUIDBytes(kCFAllocatorDefault, UUIDBytes);
    
    if (UUIDRef != NULL) {
        UUIDString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
        CFRelease(UUIDRef);
    }
    
    return UUIDString;
}

CFUUIDBytes FICUUIDBytesWithString(NSString *string) {
    CFUUIDBytes UUIDBytes;
    CFUUIDRef UUIDRef = CFUUIDCreateFromString(kCFAllocatorDefault, (CFStringRef)string);
    
    if (UUIDRef != NULL) {
        UUIDBytes = CFUUIDGetUUIDBytes(UUIDRef);
        CFRelease(UUIDRef);
    }
    
    return UUIDBytes;
}

CFUUIDBytes FICUUIDBytesFromMD5HashOfString(NSString *MD5Hash) {
    const char *UTF8String = [MD5Hash UTF8String];
    CFUUIDBytes UUIDBytes;
    
    CC_MD5(UTF8String, (CC_LONG)strlen(UTF8String), (unsigned char*)&UUIDBytes);
    
    return UUIDBytes;
}

