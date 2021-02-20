//
//  HomeViewController.swift
//  NY Times
//
//  Created by Ahmed Osman on 20/02/2021.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak private var articlesTableView: UITableView!
    var viewModel = HomeViewModel()    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupArticlesTableView()
        viewModel.fetchMostPopularArticles()        
    }
    
    func setupArticlesTableView() {
        viewModel.articles.observeOn(MainScheduler.instance).asDriver(onErrorJustReturn: []).drive(articlesTableView.rx.items(cellIdentifier: K.cellIdentifiers.article, cellType: ArticleCell.self)) { (row, element, cell) in
            cell.setup(name: element.title)
        }.disposed(by: viewModel.bag)
        
        articlesTableView.rx.modelSelected(MostPopular.self).subscribe(onNext: {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: K.controllersIdentifiers.articleDetails) as? DetailsViewController else { return }
            viewController.article = $0
            self.navigationController?.pushViewController(viewController, animated: true)
        }).disposed(by: viewModel.bag)
    }
}
