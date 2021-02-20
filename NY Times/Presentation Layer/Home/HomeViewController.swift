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
    weak private var loaderView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        addLoader()
        setupArticlesTableView()
        viewModel.fetchMostPopularArticles()        
    }
    
    private func addLoader() {
        let loader = UIActivityIndicatorView(frame: CGRect(origin: self.view.center, size: CGSize(width: 50, height: 50)))
        loader.hidesWhenStopped = true
        self.view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(loader)
        loader.startAnimating()
        self.loaderView = loader
        viewModel.loading.bind(to: loader.rx.isAnimating).disposed(by: viewModel.bag)
    }
    
    func setupArticlesTableView() {
        viewModel.articles.observeOn(MainScheduler.instance).asDriver(onErrorJustReturn: []).drive(articlesTableView.rx.items(cellIdentifier: K.cellIdentifiers.article, cellType: ArticleCell.self)) { (row, element, cell) in
            cell.setup(name: element.title)
        }.disposed(by: viewModel.bag)
        
        articlesTableView.rx.modelSelected(MostPopular.self).subscribe(onNext: {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: K.controllerIdentifiers.articleDetails) as? DetailsViewController else { return }
            viewController.article = $0
            self.navigationController?.pushViewController(viewController, animated: true)
        }).disposed(by: viewModel.bag)
    }
}
