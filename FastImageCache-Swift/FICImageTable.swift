//
//  FICImageTable.swift
//  FastImageCache-Swift
//
//  Created by apple on 2018/1/20.
//  Copyright © 2018年 BroadLink. All rights reserved.
//

import UIKit


let FICImageTableEntryDataVersionKey = "FICImageTableEntryDataVersionKey";
let FICImageTableScreenScaleKey = "FICImageTableScreenScaleKey";


let FICImageTableMetadataFileExtension = "metadata";
let FICImageTableFileExtension = "imageTable";

let FICImageTableIndexMapKey = "indexMap";
let FICImageTableContextMapKey = "contextMap";
let FICImageTableMRUArrayKey = "mruArray";
let FICImageTableFormatKey = "format";

class FICImageTable {

    var imageFormat: FICImageFormat
    init(format: FICImageFormat ) {
        self.imageFormat = format
    }
}

extension FICImageTable {
    static var directoryPath : String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, .userDomainMask, true)
        let path = paths[0].appending("/ImageTables")
        let fileManager = FileManager()
        if !fileManager.fileExists(atPath: path) {
            try! fileManager .createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        return ""
    }
    
    var tableFilePath: String {
        let filePath = "\(imageFormat.name)/\(FICImageTableFileExtension)"
        return "\(directoryPath)/\(filePath)"
    }
    var metadataFilePath: String {
        return "\(directoryPath)/\(imageFormat.name)/\(FICImageTableMetadataFileExtension)"
    }
    var directoryPath: String {
        return FICImageTable.directoryPath
    }
}
