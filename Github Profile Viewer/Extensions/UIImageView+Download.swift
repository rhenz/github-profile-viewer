//
//  UIImageView+Download.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/25/22.
//

import UIKit

extension UIImageView {
    
    // Set image with caching
    func setImageWithCaching(for urlString: String) {
        // Load cache
        let cache = NetworkManager.shared.cache
        
        // Set cache key
        let cacheKey = NSString(string: urlString)
        
        // Load cache if available
        if let image = cache.object(forKey: cacheKey) {
            setImage(image)
            return
        }
        
        // Download image if cache image not available
        guard let url = URL(string: urlString) else { return }
        downloadImage(from: url) { [weak cache, weak self] downloadedImage in
            guard let cache = cache,
                  let weakSelf = self
            else { return }
            // Cache the image
            cache.setObject(downloadedImage, forKey: cacheKey)
            
            weakSelf.setImage(downloadedImage)
        }
    }
    
    private func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}


extension UIImageView {
    private func downloadImage(from url: URL, completion: @escaping ((UIImage) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            completion(image)
        }.resume()
    }
}
