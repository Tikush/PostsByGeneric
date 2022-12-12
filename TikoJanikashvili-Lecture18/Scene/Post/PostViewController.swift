//
//  ViewController.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 07.12.22.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: - Private IBOutlets
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private var posts: [[Post]] = []
    private var postManager: PostManagerProtocol!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getPost()
    }
    
    // MARK: - Private Functions
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellIds.postCell, bundle: nil), forCellReuseIdentifier: CellIds.postCell)
    }
    
    private func getPost() {
        
        postManager = PostManager()
        postManager.fetchPost(with: .postUrl) { [weak self] array in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.groupPost(array)
                self.tableView.reloadData()
                self.loader.stopAnimating()
            }
        }
        
    }
    
    private func groupPost(_ array: [Post])  {
        self.posts.append(array)
        self.posts = posts.joined().group { $0.userId }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PostViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.postCell, for: indexPath) as? PostCell
        cell?.configure(with: posts[indexPath.section][indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Posts of user - \(posts[section].first?.userId ?? 0)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.frame.height/14
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommentViewController(nibName: VCIds.comment, bundle: nil)
        if let navigationController {
            vc.postId = posts[indexPath.section][indexPath.row].id
            navigationController.pushViewController(vc, animated: true)
        }
    }
}


