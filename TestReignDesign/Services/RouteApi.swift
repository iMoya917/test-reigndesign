//
//  RouteApi.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import Alamofire

public enum RouteApi: URLRequestConvertible {
    
    static var baseURL = "https://hn.algolia.com/api/v1"
    // MARK: URLRequestConvertible
    case getHits(parameters: [String: AnyObject])
    
    var method: HTTPMethod {
        
        switch self {
        case .getHits:
            return .get
        }
    }
    
    
    var result: (path: String, parameters: [String : AnyObject]?) {
        
        switch self {
        case .getHits(let parameters):
            return ("/search_by_date",parameters)
        }
        
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        
        let url = URL(string: RouteApi.baseURL)
        var urlRequest = URLRequest(url: url!.appendingPathComponent(result.path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 15

        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
        
    }
}
