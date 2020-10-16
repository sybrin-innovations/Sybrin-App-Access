//
//  ScanResultModel.swift
//  Runner
//
//  Created by Default on 2020/10/16.
//

class ScanResultModel: Codable {
    var success: Bool
    var value: String
    var message: String
    
    init(success: Bool, value: String) {
        self.success = success
        self.value = value
        self.message = ""
    }
}
