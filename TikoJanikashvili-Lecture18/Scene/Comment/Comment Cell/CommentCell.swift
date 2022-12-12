//
//  PostDetailsCell.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 08.12.22.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: - Private IBOutlets
    @IBOutlet private weak var commentLabel: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: Comment, at indexPath: Int) {
        commentLabel.text = "\(indexPath+1). \(item.body)"
    }
}
