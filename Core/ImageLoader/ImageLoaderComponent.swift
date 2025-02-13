//
//  ImageLoaderComponent.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/13/25.
//

public protocol ImageLoaderComponent {}

public extension ImageLoaderComponent {
    
    var remoteImageDownloader: RemoteImageDownloader {
        .init(urlSession: .shared, cache: .init())
    }
}
