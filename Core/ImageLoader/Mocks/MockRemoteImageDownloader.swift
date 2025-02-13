//
//  MockRemoteImageDownloader.swift
//  ImageLoader
//
//  Created by Dalton Hinterscher on 2/13/25.
//

public extension RemoteImageDownloader {
    
    static var mock: RemoteImageDownloader {
        .init(urlSession: .shared, cache: .init())
    }
}
