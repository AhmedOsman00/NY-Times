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
    
    var bag: DisposeBag?
    var sut: HomeViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bag = DisposeBag()
        sut = HomeViewModel(client: HTTPClient<MostPopularEndpoint>(stubClosure: { _ in return .immediate }), disposeBag: bag!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        bag = nil
    }

    func testFetchMostPopularArticles() throws {
        // Given
        let expectation = self.expectation(description: #function)
        var result: [MostPopular]?
        let expected = [MostPopular(title: "Trump Was Sicker Than Acknowledged With Covid-19", abstract: "When he was hospitalized with the coronavirus in October, his blood oxygen levels had plunged and officials feared he was on the verge of being placed on a ventilator.", media: [Media(mediaMeta: [MediaMeta(url: "https://static01.nyt.com/images/2021/02/11/us/politics/11dc-trump-health1/11dc-trump-health1-thumbStandard.jpg"), MediaMeta(url: "https://static01.nyt.com/images/2021/02/11/us/politics/11dc-trump-health1/11dc-trump-health1-mediumThreeByTwo210.jpg"), MediaMeta(url: "https://static01.nyt.com/images/2021/02/11/us/politics/11dc-trump-health1/11dc-trump-health1-mediumThreeByTwo440.jpg")])]), MostPopular(title: "The Vaccine Had to Be Used. He Used It. He Was Fired.", abstract: "Ten doses of the Covid-19 vaccine would expire within hours, so a Houston doctor gave it to people with medical conditions, including his wife. What followed was “the lowest moment in my life,” Dr. Hasan Gokal said.", media: [Media(mediaMeta: [MediaMeta(url: "https://static01.nyt.com/images/2021/02/12/multimedia/00covid-doctor-1/00covid-doctor-1-thumbStandard.jpg"), MediaMeta(url: "https://static01.nyt.com/images/2021/02/12/multimedia/00covid-doctor-1/00covid-doctor-1-mediumThreeByTwo210.jpg"), MediaMeta(url: "https://static01.nyt.com/images/2021/02/12/multimedia/00covid-doctor-1/00covid-doctor-1-mediumThreeByTwo440.jpg")])]), MostPopular(title: "‘I’m Not a Cat,’ Says Lawyer Having Zoom Difficulties", abstract: "The video was immediately shared widely and brought joy to many. The lawyer, Rod Ponton, said he was happy people got a much-needed laugh.", media: [Media(mediaMeta: [MediaMeta(url: "https://static01.nyt.com/images/2021/02/09/world/oakImage-1612906052458/oakImage-1612906052458-thumbStandard.jpg"), MediaMeta(url: "https://static01.nyt.com/images/2021/02/09/world/oakImage-1612906052458/oakImage-1612906052458-mediumThreeByTwo210.jpg"), MediaMeta(url: "https://static01.nyt.com/images/2021/02/09/world/oakImage-1612906052458/oakImage-1612906052458-mediumThreeByTwo440.jpg")])])]
        
        // When
        sut?.fetchMostPopularArticles()
        sut?.articles.subscribe(onNext: { array in
            result = array
            expectation.fulfill()
        }).disposed(by: bag!)
        
        // Then
        waitForExpectations(timeout: 10)
        XCTAssertEqual(result, expected)
    }
}
