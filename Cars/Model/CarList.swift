//
//  CarList.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import Foundation

struct CarList: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeWrapper(key: .status, defaultValue: nil)
        self.items = try container.decodeWrapper(key: .items, defaultValue: nil)
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode (status, forKey: .status)
        try container.encode (items, forKey: .items)
    }
    
    var status: String?
    var items: [Cars]?

    enum CodingKeys: String, CodingKey {
        case status
        case items = "content"
    }
}
