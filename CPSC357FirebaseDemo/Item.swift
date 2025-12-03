//
//  Item.swift
//  CPSC357FirebaseDemo
//
//  Created by Luc Rieffel on 12/2/25.
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
