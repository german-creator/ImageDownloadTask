//
//  ImageService.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 28.03.2021.
//

import Foundation

protocol ImageService {

    func getBaseImage(offset: Int, completion: @escaping (Result<[ImageData], Error>) -> Void)
    func search(query: String, offset: Int, completion: @escaping (Result<[ImageData], Error>) -> Void)
}


final class ImageServiceImpl {
    enum QueryType {
        case base
        case search(query: String)
    }
    
    private let api: API
    private let objectsLimit = Constants.queryDataLimit
    
    init(api: API) {
        self.api = api
    }
    
    private func getQueryData(for type: QueryType) -> [String: Any] {
        switch type {
        case .base:
            return ["per_page": objectsLimit]
        case .search(let query):
            return["q": "\(query)", "per_page": objectsLimit]
        }
    }
    
    private func getImages(type: QueryType, offset: Int, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        
        var parameters = getQueryData(for: type)
        parameters["page"] = (offset + 1)
        
        api.get(parameters: parameters) { result in
            completion(
                result.flatMap { data in
                    do {
                        let dataResponse = try JSONDecoder().decode(DataResponse<ImageData>.self, from: data)
                        return .success(dataResponse.images)
                    } catch {
                        print(error)
                        return .failure(error)
                    }
                }.mapError { _ in return CommonError.default }
            )
        }
    }
}


extension ImageServiceImpl: ImageService {
    func getBaseImage(offset: Int, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        getImages(type: .base, offset: offset, completion: completion)
    }
    
    func search(query: String, offset: Int, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        getImages(type: .search(query: query), offset: offset, completion: completion)
    }
}
