//
//  Article.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import Foundation

struct Root: Decodable {
    var results: [Article]
    var numberOfResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case numberOfResults = "num_results"
    }
}


struct Article: Decodable {
    var url: String
    var section: String
    var byline: String
    var title: String
    var abstract: String
    var published_date: String
    var media: [Content]
    
    func getThumbnailUrl()-> URL? {
        let filteredMetaData: [MetaData] = self.media[0].metaData.filter { (metadata) -> Bool in
            metadata.format == "Standard Thumbnail"
        }
        print(filteredMetaData.count)
        print(filteredMetaData.first?.format)
        if let thumbnailMetaData = filteredMetaData.first {
            return URL(string: thumbnailMetaData.url)
        } else {
            return nil
        }
    }
}






