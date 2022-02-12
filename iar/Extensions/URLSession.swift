//
//  URLSession.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/2/22.
//

import Foundation

extension URLSession {
    func data(from url: String) async throws -> (Data, URLResponse) {
        try await data(from: URL(string: url)!)
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
