//
//  Media.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import Foundation

struct Media {
    var media: [Content]
}

struct Content: Decodable {
    var type: String
    var subtype: String
    var caption: String?
    var copyright: String?
    var metaData: [MetaData]
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case metaData = "media-metadata"
    }
}

struct MetaData: Decodable {
    var url: String
    var format: String
    var height: Int
    var width: Int
}
