//
//  RemoteImageDownloaderTests.swift
//  ImageLoaderTests
//
//  Created by Dalton Hinterscher on 2/13/25.
//

import Foundation
import Testing
@testable import ImageLoader

class RemoteImageDownloaderTests {
    
    private let cache: ImageCache
    private let remoteImageDownloader: RemoteImageDownloader
    
    init() async {
        cache = .init()
        await cache.clearCache()
        
        remoteImageDownloader = .init(urlSession: .shared, cache: cache)
    }

    @Test("RemoteImageDownloader returns the correct result")
    func correctResult() async throws {
        
        let imageUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")!
        
        // We have a clean cache, so the image should be downloaded
        let downloadedResult = try await remoteImageDownloader.downloadImage(from: imageUrl)
        #expect(downloadedResult == .downloaded(downloadedResult.image))
       
        // The image has been previously downloaded so it should be cached
        let cachedResult = try await remoteImageDownloader.downloadImage(from: imageUrl)
        #expect(cachedResult == .cached(cachedResult.image))
        
        await cache.clearCache()
        
        // The image should be redownloaded as the cache should be empty
        let redownloadedResult = try await remoteImageDownloader.downloadImage(from: imageUrl)
        #expect(redownloadedResult == .downloaded(redownloadedResult.image))
        
    }

}
