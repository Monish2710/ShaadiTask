//
//  ImageCacheManager.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import SwiftUI
import UIKit

//MARK: ImageCache Manager
class ImageCacheManager {
    static let shared = ImageCacheManager()

    private let imageCache = NSCache<NSString, UIImage>()

    private init() {}

    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }

    func clearCache() {
        imageCache.removeAllObjects()
    }
}

//MARK: Cache Sync Image
struct CachedAsyncImage: View {
    let url: String
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url) {
            image = cachedImage
        } else {
            downloadImage()
        }
    }

    private func downloadImage() {
        guard let imageUrl = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            guard let data = data, error == nil, let downloadedImage = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                ImageCacheManager.shared.setImage(downloadedImage, forKey: url)
                self.image = downloadedImage
            }
        }.resume()
    }
}
