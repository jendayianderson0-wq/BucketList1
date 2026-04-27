//
//  PhotoStorage.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/16/26.
//

import Foundation
import SwiftUI
import SwiftData

// Save image
func saveImage(_ image: UIImage, withName name: String) -> URL? {
    guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent(name)
    try? data.write(to: url)
    return url
}

// Load image
func loadImage(from url: URL) -> UIImage? {
    guard let data = try? Data(contentsOf: url) else { return nil }
    return UIImage(data: data)
}
