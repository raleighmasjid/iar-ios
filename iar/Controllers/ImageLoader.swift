//
//  ImageLoader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/25/22.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage

    private var imageURL: URL?
    private let session = URLSession.shared
    private var loadingURL: URL?
    private let defaultImage: UIImage?
    
    init(defaultImage: UIImage? = nil) {
        self.image = defaultImage ?? UIImage()
        self.defaultImage = defaultImage
    }
    
    func update(urlString: String) {
        guard let newURL = URL(string: urlString),
              newURL != self.imageURL
        else { return }
        
        Task {
            await fetchImage(url: newURL)
        }
    }
    
    @MainActor
    private func fetchImage(url: URL) async {
        guard url != loadingURL else {
            return
        }

        loadingURL = url
        do {
            let (data, _) = try await session.data(from: url)
            if let newImage = UIImage(data: data) {
                image = newImage
                imageURL = url
            } else {
                image = defaultImage ?? UIImage()
            }
        } catch {
            NSLog("Error loading image \(error)")
        }
        loadingURL = nil
    }
    
}
