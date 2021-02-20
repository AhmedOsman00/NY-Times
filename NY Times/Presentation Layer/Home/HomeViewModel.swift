//
//  HomeViewModel.swift
//  NY Times
//
//  Created by Ahmed Osman on 20/02/2021.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    let client: HTTPClient<MostPopularEndpoint>
    var articles = BehaviorSubject<[MostPopular]>(value: [])
    let bag: DisposeBag
    
    init(client: HTTPClient<MostPopularEndpoint> = HTTPClient<MostPopularEndpoint>(), disposeBag: DisposeBag = DisposeBag()) {
        self.client = client
        self.bag = disposeBag
    }
    
    func fetchMostPopularArticles() {
        client.fetch(request: .mostPopular).map(Container<[MostPopular]>.self).map({ $0.results }).subscribe(onSuccess: { [weak self] in self?.articles.onNext($0 ?? [])
        }).disposed(by: bag)
    }
}
