//
//  ServiceProvider.swift
//  UploadFile
//
//  Created by chengpeng on 2022/8/12.
//

import Foundation
import Moya
import UIKit


//默认下载保存地址（用户文档目录）
fileprivate let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

let ServiceProvider = MoyaProvider<PRService>()

enum PRService {
    // 上传二进制文件，文件后缀名
    case uploadData(Data, String, String)
    // 下载文件(下载url，磁盘缓存url)
    case downloadFile(URL, URL)
    
    
    // 如果还需要其他接口，可以在下面继续增加枚举
    
    // case fetchToken() 获取 token
}

extension PRService: TargetType {
    var baseURL: URL {
        switch self {
        case .uploadData( _, _, _):
            return URL(string: BaseUrl.upload.rawValue)!
        case .downloadFile(let url, _):
            return url
        }
    }

    var path: String {
        switch self {
        case .uploadData(_, _, _):
            return "/xxx/xx"
            
        case .downloadFile(_, _):
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .downloadFile(_, _):
            return .get
        default:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .uploadData(let data, let filename, let mimeType):
            // 资源二进制数据
            let formData = MultipartFormData(provider: .data(data), name: "resourceKey", fileName: filename, mimeType: mimeType)
            // 如果接口body还需要其他参数，继续按该方式组装数据
            
            // 注意事项：ServiceProvider类尽量保证不要出现业务代码，如果出现这种情况，最好再将filename值的Data做一个参数传进来
            guard let filenameData = filename.data(using: .utf8) else {
                // 该if判断就是业务代码，非空判断需要再业务类中写，再调用时请求时写清楚
                return .requestPlain
            }
            let fileFormData = MultipartFormData(provider: .data(filenameData), name: "filename")
            // 最终将请求的body数据 全部装进数
            return .uploadMultipart([formData, fileFormData])
            
            // 如果还有其他加载http请求头上的参数，可以用下面的Task
            // case uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any])
            
        case .downloadFile(_, let localPath):
            let downloadDestination: DownloadDestination = { _, _ in return (localPath, .removePreviousFile) }
            return .downloadDestination(downloadDestination)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .uploadData(_, _, _):
            return ["Authorization": authorization, "Content-Type": "multipart/form-data"]
        case .downloadFile(_, _):
            return ["Content-Type": "application/json"]
        }
    }
}
