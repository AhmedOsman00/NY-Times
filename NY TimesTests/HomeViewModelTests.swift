//
//  NY_TimesTests.swift
//  NY TimesTests
//
//  Created by Ahmed Osman on 18/02/2021.
//

import XCTest
import RxSwift
@testable import NY_Times

class NY_TimesTests: XCTestCase {
    
    let sut = HomeViewModel(client: HTTPClient<MostPopularEndpoint>(stubClosure: { _ in return .immediate }), disposeBag: DisposeBag())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMostPopularArticles() throws {
        sut.fetchMostPopularArticles()
    }
}
