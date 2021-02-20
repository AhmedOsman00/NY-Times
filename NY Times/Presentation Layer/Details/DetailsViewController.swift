//
//  DetailsViewController.swift
//  NY Times
//
//  Created by Ahmed Osman on 20/02/2021.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var article: MostPopular?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }
    
    func populateData() {
        articleImage.sd_setImage(with: URL(string: article?.media?.first?.mediaMeta.last?.url ?? ""), completed: nil)
        titleLabel.text = article?.title
        detailsTextView.text = article?.abstract
    }
}
