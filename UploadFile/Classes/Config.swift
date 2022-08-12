//
//  Config.swift
//  UploadFile
//
//  Created by chengpeng on 2022/8/12.
//

import Foundation

/// 上传接口token
let authorization = "xxx"

/// 存储临时路劲
let prTmpURL = URL(fileURLWithPath: FileManager.createFileInTempDirectory("PixelRepair"))

enum BaseUrl: String {
    case upload = "https://xxx.xx.a.com"
    /// 画质修复
    case download = "https://xxx.xx.b.com"
}

extension FileManager {
    class func createFileInTempDirectory(_ pathComponent: String) -> String {
        var url = URL(fileURLWithPath: NSTemporaryDirectory())
        url.appendPathComponent(pathComponent)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
        }
        return url.path
    }
}


