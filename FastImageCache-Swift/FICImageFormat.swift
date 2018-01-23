//
//  FICImageFormat.swift
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/20.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

enum FICImageFormatDevices {
    case Phone,Pad
}

enum FICImageFormatStyle {
    case BGRA32Bit,BGR32Bit,BGR16Bit,Grayscale8Bit
}

enum FICImageFormatProtectionMode {
    case none,complete,completeUntilFirstUserAuthentication
}

let FICImageFormatNameKey = "name";
let FICImageFormatFamilyKey = "family";
let FICImageFormatWidthKey = "width";
let FICImageFormatHeightKey = "height";
let FICImageFormatStyleKey = "style";
let FICImageFormatMaximumCountKey = "maximumCount";
let FICImageFormatDevicesKey = "devices";
let FICImageFormatProtectionModeKey = "protectionMode";

class FICImageFormat: NSCopying {
    
    var name: String
    var family: String
    var imageSize: CGSize {
        willSet {
            let currentSizeEqualToNewSize = __CGSizeEqualToSize(imageSize, newValue)
            if currentSizeEqualToNewSize {
                let screenScale = UIScreen.main.scale
                self.pixelSize = CGSize(width: screenScale * newValue.width, height: screenScale * newValue.height)
            }
        }
    }
    var style: FICImageFormatStyle
    var maximumcount: Int
    var devices: FICImageFormatDevices
    var pixelSize: CGSize = CGSize.zero
    var bitmapInfo: CGBitmapInfo {
        var info : CGBitmapInfo?
        switch style {
        case .BGRA32Bit:
            
            info = CGBitmapInfo(rawValue:CGImageAlphaInfo.premultipliedFirst.rawValue | CGImageByteOrderInfo.order32Little.rawValue)
        case .BGR32Bit:
            info = CGBitmapInfo(rawValue:CGImageAlphaInfo.noneSkipFirst.rawValue | CGImageByteOrderInfo.order32Little.rawValue)
        case .BGR16Bit:
 info = CGBitmapInfo(rawValue:CGImageAlphaInfo.noneSkipFirst.rawValue | CGImageByteOrderInfo.order16Little.rawValue)
        case .Grayscale8Bit:
                        info = CGBitmapInfo(rawValue:CGImageAlphaInfo.none.rawValue)
        default:
            info = CGBitmapInfo(rawValue:CGImageAlphaInfo.none.rawValue)

        }
        return info!
    }
    var bytesPerPixel: Int {
        var bytesPerPixel : Int!
        switch style {
        case .BGRA32Bit:
            bytesPerPixel = 4
        case .BGR32Bit:
            bytesPerPixel = 4
        case .BGR16Bit:
            bytesPerPixel = 2
        case .Grayscale8Bit:
            bytesPerPixel = 1
        }
        return bytesPerPixel
    }
    
    var bitsPerComponents: Int {
        let bitsPerComponent : Int!
        switch style {
        case .BGRA32Bit:
            bitsPerComponent = 8;
        case .BGR32Bit:
            bitsPerComponent = 8;
        case .BGR16Bit:
            bitsPerComponent = 8;
        case .Grayscale8Bit:
            bitsPerComponent = 5;
        }
        return bitsPerComponent;
    }
    var isGrayscal: Bool {
        return style == .Grayscale8Bit
    }
    var protectionMode: FICImageFormatProtectionMode
    var protectionModeString: String
    var dictionaryRepresentation: [String: AnyObject]
    init(name: String, family: String, imageSize: CGSize, style: FICImageFormatStyle, maximumCount: Int, devices: FICImageFormatDevices, protectionMode: FICImageFormatProtectionMode) {
        self.name = name
        self.family = family
        self.imageSize = imageSize
        self.style = style
        self.maximumcount = maximumCount
        self.devices = devices
        self.protectionMode = protectionMode
    }
    func copy(with zone: NSZone? = nil) -> Any {
        return 1
    }
    
}

extension FICImageFormat: Hashable {
    var hashValue: Int {
        return self.name.hashValue ^ self.family.hashValue ^ self.imageSize.width.hashValue ^ self.imageSize.height.hashValue ^ self.style.hashValue ^ self.maximumcount.hashValue ^ self.devices.hashValue ^ self.protectionMode.hashValue
    }
    
    public static func ==(lsh: FICImageFormat, rsh: FICImageFormat) -> Bool {
        return lsh.name == rsh.name
        && lsh.family == rsh.family
        && lsh.imageSize == rsh.imageSize
        && lsh.style == rsh.style
        && lsh.maximumcount == rsh.maximumcount
        && lsh.devices == rsh.devices
        && lsh.protectionMode == rsh.protectionMode
    }

}
