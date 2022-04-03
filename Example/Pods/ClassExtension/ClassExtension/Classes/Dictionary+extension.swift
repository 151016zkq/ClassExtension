//
//  Dictionary+extension.swift
//  SmartPicc
//
//  Created by 张凯强 on 2021/1/25.
//  Copyright © 2021 picclife. All rights reserved.
//

import Foundation
extension Dictionary {
    ///字典转换成字符串
    public func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                     options: []) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
     }

    public func toData() -> Data? {
        if JSONSerialization.isValidJSONObject(self) {
            let data = try? JSONSerialization.data(withJSONObject: self, options: [])
            return data
        }else {
            return nil
        }
    }

}
