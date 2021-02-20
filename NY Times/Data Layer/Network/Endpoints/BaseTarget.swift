//
//  BaseTarget.swift
//  DreamtHome
//
//  Created by Ahmed Osman on 2/22/20.
//  Copyright © 2020 RC Structure. All rights reserved.
//

import Foundation
import Moya

protocol BaseTarget: TargetType, Hashable, AccessTokenAuthorizable {
    var parameters: [String: Any] { get }
    var parametersEncoding: ParameterEncoding { get }
}

extension BaseTarget {
    var headers: [String : String]? {
        var headers:[String:String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
    
    var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc/")!
    }
    
    func fetchStubFile(withName: String, type: String = "json") -> Data? {
        guard let path = Bundle(identifier: "com.ao.NY-TimesTests")?.path(forResource: withName, ofType: type) else { return nil }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print(error, .e)
            return nil
        }
    }
}
