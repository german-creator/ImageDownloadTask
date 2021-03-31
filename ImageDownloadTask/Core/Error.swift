//
//  Error.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import Foundation

enum NetworkingError: Error {
    case `default`
    
    var localizedDescription: String {
        switch self {
        case .default: return "Networking Error"
        }
    }
}


enum CommonError: Error {
    case `default`
    
    var localizedDescription: String {
        switch self {
        case .default: return "Something went wrong"
        }
    }
}
