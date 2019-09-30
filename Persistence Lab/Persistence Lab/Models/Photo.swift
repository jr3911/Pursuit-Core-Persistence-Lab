//
//  PhotoHit.swift
//  Persistence Lab
//
//  Created by Jason Ruan on 9/30/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let user: String
    let likes: Int
    let favorites: Int
    let tags: String
    let previewURL: URL
    let webformatURL: URL
}
