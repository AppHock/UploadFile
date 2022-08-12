//
//  Models.swift
//  UploadFile
//
//  Created by chengpeng on 2022/8/12.
//

import Foundation

protocol ResponseModel: Codable {
    var code: Int? {get set}
    var message: String? {get set}
}

struct UPResponseModel: ResponseModel {
    var code: Int?
    var message: String?
    var name: String?
}

struct DNResponseModel: ResponseModel {
    var code: Int?
    var message: String?
    var path: String?
}

