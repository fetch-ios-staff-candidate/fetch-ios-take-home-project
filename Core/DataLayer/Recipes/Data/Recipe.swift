//
//  Recipe.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import SwiftData

@Model
public class Recipe {
    public var uuid: String
    public var cuisine: String
    public var name: String
    public var photoUrlLarge: String?
    public var photoUrlSmall: String?
    public var sourceUrl: String?
    public var youtubeUrl: String?
    
    init(
        uuid: String,
        cuisine: String,
        name: String,
        photoUrlLarge: String?,
        photoUrlSmall: String?,
        sourceUrl: String?,
        youtubeUrl: String?
    ) {
        self.uuid = uuid
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
}
