//
//  PhotosAPIClient.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 9/30/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

class PhotosAPIClient {
    private init() {}
    static let manager = PhotosAPIClient()
    private let endpointString = "https://pixabay.com/api/?key=\(Secrets().apiKey)&q="
    
    func getPhotos(completionHandler: @escaping (Result<[Photo], AppError>) -> () ) {
        guard let url = URL(string: endpointString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: nil, andMethod: .get) { (result) in
            switch result {
            case .failure(_):
                completionHandler(.failure(.noDataReceived))
            case .success(let data):
                do {
                    let arrPhotosInfo = try JSONDecoder().decode(PhotoWrapper.self, from: data)
                    completionHandler(.success(arrPhotosInfo.hits))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    
}
