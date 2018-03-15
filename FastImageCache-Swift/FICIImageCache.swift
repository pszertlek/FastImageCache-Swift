//
//  FICIImageCache.swift
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/20.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import Foundation

let FICImageCacheFormatKey = "FICImageCacheFormatKey";
let FICImageCacheCompletionBlocksKey = "FICImageCacheCompletionBlocksKey";
let FICImageCacheEntityKey = "FICImageCacheEntityKey";

func FICAddCompletionBlockForEntity(formatName: String, entityRequestsDictionary: inout [String:AnyObject], entity: FICEntity,completion: (FICEntity,String,UIImage) -> Void) {
    let entityUUID = entity.fic_UUID
    var requestDictionary = (entityRequestsDictionary[entityUUID]) as? [String : AnyObject]
    var completionBlocks : [String:Any]?
    if let requestDictionary = requestDictionary {
        completionBlocks = requestDictionary[FICImageCacheCompletionBlocksKey] as? [String : Any]
    } else {
        requestDictionary = [FICImageCacheEntityKey : entity as AnyObject]
        entityRequestsDictionary[entityUUID] = requestDictionary as AnyObject
        requestDictionary![FICImageCacheFormatKey] = formatName as AnyObject
        completionBlocks = [String : Any]()

        requestDictionary![FICImageCacheCompletionBlocksKey] = completionBlocks as AnyObject
    }
}

@objc protocol FICImageCacheDelegate {
//    @objc optional func imageCache(_ imageCache: FICImageCache,wantsSourceImageForEntity entity: FICEntity, formatName:String, completion: (UIImage) -> Void)
}

class FICImageCache {
    var formats: [String: AnyObject] = [String:AnyObject]()
    var imageTables: [String: AnyObject] = [String:AnyObject]()
    var requests: [String: AnyObject] = [String:AnyObject]()
    var nameSpace: String
    static let sharedImageCache = FICImageCache("FICDefaultNamespace")
    init(_ nameSpace: String) {
        self.nameSpace = nameSpace
    }
    
    func set(formats: [FICImageFormat]) {
        if self.formats.count > 0 {
            print("*** FIC Error:FICImageCache has already been configured with its image formats.")
        } else {
            var imageTableFiles = Set<String>()
            let currentDevice: FICImageFormatDevices = UIDevice.current.userInterfaceIdiom == .pad ? FICImageFormatDevices.Pad: FICImageFormatDevices.Phone

            for imageFormat in formats {
                let formatName = imageFormat.name
                let devices = imageFormat.devices
                //MARK: 这里swift enum 没有option项，暂时写为相等
                if devices == currentDevice {
                    let imageTable = FICImageTable(format: imageFormat)
                    imageTables[formatName] = imageTable
                    self.formats[formatName] = imageFormat
                    imageTableFiles.insert("\(formatName).imageTable")
                    imageTableFiles.insert("\(formatName).metadata")
                }
            }
            let directoryPath = "\(FICImageTable.directoryPath)/\(self.nameSpace)"
            let fileNames =  try! FileManager.default.contentsOfDirectory(atPath: directoryPath)
            for fileName in fileNames {
                if !imageTableFiles.contains(fileName) {
//                    let path = FileManager.default.removeItem(at: <#T##URL#>)
                    let filePath =
                    try! FileManager.default.removeItem(atPath: fileName)
                }
            }
        }
    }
}

