//
//  Item.swift
//  recipes-fetch
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
