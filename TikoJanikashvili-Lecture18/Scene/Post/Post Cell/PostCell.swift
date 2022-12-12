//
//  UserCell.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 07.12.22.
//

import UIKit

class PostCell: UITableViewCell {

    // MARK: - Private IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: Post) {
        titleLabel.text = item.title
    }
}
