//
//  ImageData.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import Foundation

struct ImageData: Codable {
    
    let url: URL
    let tags: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case url = "webformatURL"
        case tags = "tags"
        case width = "webformatWidth"
        case height = "webformatHeight"
    }
}

