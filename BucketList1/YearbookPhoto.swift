//
//  YearbookPhoto.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 5/5/26.
//

// YearbookPhoto.swift — new file
import SwiftData
import Foundation

@Model
class YearbookPhoto {
    var fileName: String
    var caption: String
    var dateAdded: Date
    
    init(fileName: String, caption: String = "") {
        self.fileName = fileName
        self.caption = caption
        self.dateAdded = Date()
    }
    
    // Convenience: build the full URL from just the file name
    var imageURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }
}
