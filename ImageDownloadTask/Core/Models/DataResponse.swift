//
//  DataResponse.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import Foundation

struct DataResponse<T> where T: Codable {
    let images: [T]
    let total: Int
    let totalHits: Int
    
}

extension DataResponse: Codable{
    enum CodingKeys: String, CodingKey {
        case images = "hits"
        case total = "total"
        case totalHits = "totalHits"
    }
}

