//
//  FavoritePhotoPersistenceHelper.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 10/1/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

struct FavoritePhotoPersistenceHelper {
    static let manager = FavoritePhotoPersistenceHelper()

    func save(newPhoto: Photo) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }

    func getFavoritePhotos() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "photos.plist")

    private init() {}
}
