//
//  Cars.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import Foundation

struct Cars: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
        self.title = try container.decodeWrapper(key: .title, defaultValue: nil)
        self.dateTime = try container.decodeWrapper(key: .dateTime, defaultValue: "")
        self.details = try container.decodeWrapper(key: .description, defaultValue: nil)
        self.url = try container.decodeWrapper(key: .imageURL, defaultValue: "")
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (title, forKey: .title)
        try container.encode (dateTime, forKey: .dateTime)
        try container.encode (details, forKey: .description)
        try container.encode (url, forKey: .imageURL)
    }
    
    let id: Int!
    let title: String?
    let dateTime: String?
    let details: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case dateTime
        case description = "ingress"
        case imageURL = "image"
    }
}
