//
//  FICEntity.swift
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/20.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

protocol FICEntity {
    var fic_UUID: String {get}
    var fic_sourceImageUUID: String {get}
    func fic_sourceImageURL(formatName: String) -> NSURL?
    func fic_drawingBlock(image: UIImage, formatName: String) -> () -> Void
    func fic_imageFor(format: FICImageFormat)
}
