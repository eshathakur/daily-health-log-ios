//
//  Item.swift
//  Daily Health Log
//
//  Created by Esha Thakur on 3/25/26.
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
