//
//  MostPopularEndpoint.swift
//  NY Times
//
//  Created by Ahmed Osman on 20/02/2021.
//

import Foundation
import Moya

enum MostPopularEndpoint: BaseTarget {
    case mostPopular
    
    var parameters: [String : Any] {
        return ["api-key": "Zw349FTSUxubynQ6RXG66BXYjHjhPAik"]
    }
    
    var parametersEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var path: String {
        return "mostpopular/v2/viewed/7.json"
    }    
    
    var sampleData: Data {
        return fetchStubFile(withName: "MostPopular") ?? Data()
    }
    
    var method: Moya.Method {
        return .get
    }        
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parametersEncoding)
    }
    
    var authorizationType: AuthorizationType? {
        return .none
    }
}
