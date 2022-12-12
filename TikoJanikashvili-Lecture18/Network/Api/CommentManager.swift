//
//  CommantManager.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 12.12.22.
//

import Foundation

protocol CommentManagerProtocol: AnyObject {
    func fetchComment(with postId: Int, completion: @escaping([Comment]) -> Void)
}

class CommentManager: CommentManagerProtocol {
    
    func fetchComment(with postId: Int, completion: @escaping([Comment]) -> Void) {
        
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(postId)/comments"
        
        NetworkManager.shared.get(url: urlString) { (result: Result<[Comment], Error>) in
            switch result {
            case .success(let comment):
                completion(comment)
            case .failure(let error):
                print(error)
            }
        }
    }
}
