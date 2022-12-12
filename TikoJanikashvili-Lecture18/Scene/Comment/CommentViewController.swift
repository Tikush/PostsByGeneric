//
//  PostDetailsViewController.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 08.12.22.
//

import UIKit

class CommentViewController: UIViewController {
    
    // MARK: - Private IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noPostLabel: UILabel!
    
    // MARK: - Internal Properties
    var postId: Int?
    
    // MARK: - Private Properties
    private var comments = [Comment]()
    private var commentManager: CommentManagerProtocol!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getComment()
    }
    
    // MARK: - Private Functions
    private func setup() {
        noPostLabel.isHidden = true
        tableView.dataSource = self
        navigationItem.title = "Comments"
        tableView.register(UINib(nibName: CellIds.commentCell, bundle: nil), forCellReuseIdentifier: CellIds.commentCell)
    }
    
    private func getComment() {
        commentManager = CommentManager()
        
        if let postId {
            commentManager.fetchComment(with: postId) { [weak self] comments in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    self.comments = comments
                    self.tableView.reloadData()
                    
                    if comments.count == 0 {
                        // if we dont have comments
                        self.tableView.isHidden = true
                        self.noPostLabel.isHidden = false
                        self.noPostLabel.text = "Oops, no comments 🤪"
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.commentCell, for: indexPath) as? CommentCell
        cell?.configure(with: comments[indexPath.row], at: indexPath.row)
        return cell!
    }
}
