//
//  ApiManager.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 07.12.22.
//

import Foundation
import CoreLocation

enum EndPoint: String {
    case postUrl = "https://jsonplaceholder.typicode.com/posts"
    
    var url: URL? {
        return URL(string: self.rawValue)
    }
}

typealias completionBlock<T: Codable> = ((Result<T, Error>) -> Void)

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - Generic function
    func get<T: Codable>(url: String, completion: @escaping completionBlock<T>) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }

            guard (200...299).contains(response.statusCode) else {
                print("wrong response")
                return
            }
            
            guard let data = data else { return }
            do {
                let decoder = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoder))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
