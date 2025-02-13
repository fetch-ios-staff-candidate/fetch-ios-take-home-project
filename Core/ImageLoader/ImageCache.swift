//
//  ImageCache.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/13/25.
//

import Foundation
import UIKit

public actor ImageCache {
    
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheDirectory: URL
    
    public init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskCacheDirectory = paths[0].appendingPathComponent("ImageCache", isDirectory: true)
        
        if !fileManager.fileExists(atPath: diskCacheDirectory.path) {
            try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func save(_ image: UIImage, forKey key: String) {
        let fileURL = diskCacheDirectory.appendingPathComponent(key)
        
        cache.setObject(image, forKey: key as NSString)
        
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
    
    func load(forKey key: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: key as NSString) {
            return cachedImage
        }
        
        let fileURL = diskCacheDirectory.appendingPathComponent(key)
        if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
            cache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    func clearCache() {
        cache.removeAllObjects()
        try? fileManager.removeItem(at: diskCacheDirectory)
    }
    
}
