//
//  FICImageTableEntry.swift
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/19.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import UIKit

struct FICImageTableEntryMetadata {
    var entityUUIDBytes: CFUUIDBytes
    var sourceImageUUIDBytes: CFUUIDBytes
}

class FICImageTableEntry {
    var length: size_t
    var imageLength: size_t {
        get {
            return self.length - MemoryLayout<FICImageTableEntryMetadata>.size
        }
    }
    var bytes: UnsafeMutablePointer<Any>
    var entityUUIDBytes: CFUUIDBytes {
        return self.metadata.entityUUIDBytes
    }
    var sourceImageUUIDBytes: CFUUIDBytes {
        return self.metadata.sourceImageUUIDBytes
    }
    weak var imageTableChunk: FICImageTableChunk?
    var index: Int = 0
    var deallocBlock = [() -> Void]()
    var metadata: FICImageTableEntryMetadata
    
    init(_ imageTableChunk: FICImageTableChunk, _ bytes: UnsafeMutablePointer<Any>, length: size_t) {
        self.imageTableChunk = imageTableChunk
        self.bytes = bytes
        self.length = length
        self.metadata = FICImageTableEntryMetadata(entityUUIDBytes: CFUUIDBytes(), sourceImageUUIDBytes: CFUUIDBytes())
    }
    deinit {
        for block in self.deallocBlock {
            //MARK:dealloc
            block()
        }
    }
    
    func flush() {
        
    }
}
