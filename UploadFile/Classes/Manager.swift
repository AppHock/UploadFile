//
//  Manager.swift
//  UploadFile
//
//  Created by chengpeng on 2022/8/12.
//

import Foundation

public final class Manager {
    
    // 开始上传
    public func uploadFile() {
        ServiceProvider.request(.uploadData(Data(), "a", "b")) { result in
            if case let .success(responseData) = result {
                print(responseData)
                guard let model = try? responseData.map(UPResponseModel.self) else {
                    return
                }
                print(model.name)
                // 接口成功
            } else {
                // 接口异常
            }
        }
    }
    
    // 开始下载
    public func downloadFile() {
        ServiceProvider.request(.downloadFile(URL(string: "https://www.baicu.com/xxx")!, URL(fileURLWithPath: "/tmp/xxx"))) { result in
            if case let .success(responseData) = result {
                print(responseData)
                // 接口成功
            } else {
                // 接口异常
            }
        }
    }
    
}
