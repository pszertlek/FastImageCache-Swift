//
//  FICImageTableChunk.swift
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/19.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import UIKit

class FICImageTableChunk {
    var bytes: UnsafeMutableRawPointer?
    var fileOffset: off_t
    var index: Int
    var length: size_t
    
    init(_ fileDescriptor:Int,index: Int, length: size_t) {
        self.index = index
        self.length = length
        self.fileOffset = off_t(index * length);
        self.bytes = mmap(nil, length, (PROT_READ|PROT_WRITE), (MAP_FILE|MAP_SHARED), Int32(fileDescriptor), fileOffset)
    }
    
    deinit {
        if let bytes = self.bytes {
            munmap(bytes, self.length)
        }
    }
}
