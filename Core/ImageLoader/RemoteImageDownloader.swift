//
//  RemoteImageDownloader.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/13/25.
//

import Combine
import Foundation
import UIKit

public actor RemoteImageDownloader: ObservableObject {

    // MARK: - Variables
    
    private let urlSession: URLSession
    private let cache: ImageCache
    
    // MARK: - Initializers
    
    init(urlSession: URLSession, cache: ImageCache) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    // MARK: - Public interface
    
    /// Downloads an image from the provided URL if it does not already exist in the cache.
    public func downloadImage(from url: URL) async throws -> Result {
        
        let key = url.relativePath.replacingOccurrences(of: "/", with: "-")
        
        if let cachedImage = await cache.load(forKey: key) {
            return .cached(cachedImage)
        }
        
        let (data, _) = try await urlSession.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw DownloadError.dataCannotBeConvertedToImage
        }
        
        await cache.save(image, forKey: key)
        
        return .downloaded(image)
    }
    
    // MARK: - Enums
    
    public enum Result: Equatable {
        case cached(UIImage)
        case downloaded(UIImage)
        
        public var image: UIImage {
            return switch self {
            case .cached(let image), .downloaded(let image):
                image
            }
        }
    }
    
    
    enum DownloadError: Error {
        case dataCannotBeConvertedToImage
    }
}
