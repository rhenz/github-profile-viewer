//
//  GPVAvatarImageView.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/21/22.
//

import UIKit

class GPVAvatarImageView: UIImageView {
    
    // MARK: -
    
    private let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            setImage(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            self.setImage(image)
        }.resume()
    }
    
    private func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
