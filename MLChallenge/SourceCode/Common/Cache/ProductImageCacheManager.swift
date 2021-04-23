//
//  ProductImageCacheManager.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 20/04/21.
//

import UIKit

protocol ProductImageCacheManager {
    func saveImage(image: UIImage, imageUrl: String)

    func getImageInCache(path: String) -> UIImage?
}

// MARK: - PRODUCTIMAGECACHEMANAGERPROTOCOL IMPLEMENTATION.
class ProductImageCacheManagerImplementation: ProductImageCacheManager {
    private let imageCache = NSCache<NSString, UIImage>()

    func saveImage(image: UIImage, imageUrl: String) {
        DispatchQueue.main.async {
            self.imageCache.setObject(image, forKey: NSString(string: imageUrl))
        }
    }

    func getImageInCache(path: String) -> UIImage? {
        let image = imageCache.object(forKey: NSString(string: path))
        return image
    }
}
