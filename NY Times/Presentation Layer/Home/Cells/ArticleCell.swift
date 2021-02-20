//
//  ArticleCell.swift
//  NY Times
//
//  Created by Ahmed Osman on 20/02/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak private var articleName: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(name: String?) {
        self.articleName?.text = name
    }
}
