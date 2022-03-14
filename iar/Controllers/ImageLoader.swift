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
    
    init(defaultImage: UIImage? = nil) {
        image = defaultImage ?? UIImage()
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
        do {
            let (data, _) = try await session.data(from: url)
            imageURL = url
            image = UIImage(data: data) ?? UIImage()
        } catch {
            NSLog("Error loading image \(error)")
        }
    }
    
}
