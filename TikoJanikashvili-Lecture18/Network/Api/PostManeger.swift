//
//  PostApiManeger.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 12.12.22.
//

import Foundation

protocol PostManagerProtocol: AnyObject {
    func fetchPost(with endPoint: EndPoint, completion: @escaping ([Post]) -> Void)
}

class PostManager: PostManagerProtocol {
    
    func fetchPost(with endPoint: EndPoint, completion: @escaping ([Post]) -> Void) {
        
        let urlString = endPoint.rawValue
        
        NetworkManager.shared.get(url: urlString) { (result: Result<[Post], Error>) in
            switch result {
            case .success(let post):
                completion(post)
            case .failure(let error):
                print(error)
            }
        }
    }
}
