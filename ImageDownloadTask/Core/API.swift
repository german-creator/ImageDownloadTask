//
//  API.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 28.03.2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol API {
    func get(parameters: [String: Any],
             completion: @escaping (Result<Data, Error>) -> Void)
    
    func request(method: HTTPMethod,
                 parameters: [String: Any],
                 completion: @escaping (Result<Data, Error>) -> Void)
}


final class ImageAPI: API {
    
    private let networking: Networking
    private let basePath = Constants.baseUrl
    private let apiKey = Constants.apiKey
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func get(parameters: [String: Any],
             completion: @escaping (Result<Data, Error>) -> Void)
    {
        return request(method: .get, parameters: parameters, completion: completion)
    }
    
    func request(method: HTTPMethod,
                 parameters: [String: Any],
                 completion: @escaping (Result<Data, Error>) -> Void)
    {
        var parameters = parameters
        parameters["key"] = apiKey
                
        return networking.request(url: basePath, method: .get, parameters: parameters) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                print("Networking Error:", error.localizedDescription)
                completion(.failure(NetworkingError.default))
            }
        }
    }
}
