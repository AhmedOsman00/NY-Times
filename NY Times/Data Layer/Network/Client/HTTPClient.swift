//
//  RXNetworkDataProvider.swift
//  demos
//
//  Created by Ahmed Osman on 08/12/2020.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class HTTPClient<T: Hashable> where T: TargetType  {

    private let provider: MoyaProvider<T>
    
    init(stubClosure: @escaping (T) -> Moya.StubBehavior = { _ in return .never }) {
        provider = MoyaProvider<T>(stubClosure: stubClosure)
    }
    
    func fetch(request: T) -> Single<Response> {
        return provider.rx.request(request).filterSuccessfulStatusCodes()
    }
}
