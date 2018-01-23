//
//  FICUtilities.h
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/20.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

#import <Foundation/Foundation.h>

size_t FICByteAlign(size_t bytesPerRow, size_t alignment);
size_t FICByteAlignForCoreAnimation(size_t bytesPerRow);

NSString * _Nullable FICStringWithUUIDBytes(CFUUIDBytes UUIDBytes);
CFUUIDBytes FICUUIDBytesWithString(NSString * _Nonnull string);
CFUUIDBytes FICUUIDBytesFromMD5HashOfString(NSString * _Nonnull MD5Hash); // Useful for computing an entity's UUID from a URL, for example


