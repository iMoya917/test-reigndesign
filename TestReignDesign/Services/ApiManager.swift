//
//  ApiManager.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import SwiftyJSON
import Alamofire

enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
    
    var description: String{
        
        switch self {
        case .objectSerialization(let reason):
            return reason
        case .network(_):
            return "Check connection, try again"
        default:
            return "There was an error saving the data, try again"
            
        }
        
    }
    
}

class ApiManager {

    static func getHits(success:@escaping (_ hitsArray: [RDHit]) -> Void , error: @escaping (_ error: BackendError) -> Void) -> Void{
    
        let parameters = ["query":"ios"] as [String: AnyObject]
        
        let api = Alamofire.request(RouteApi.getHits(parameters: parameters)).responseJSON(completionHandler: { (response : DataResponse<Any>) in
            
            print("response \(response)")

            switch response.result{
            case .success(let jsonDictionary as NSDictionary):
                
                guard let responseArrayObject:[RDHit] = Mapper<RDHit>().mapArray(JSONArray: (jsonDictionary["hits"] as! NSArray) as! [[String : Any]]) else {
                    let reason = "Response collection could not be serialized due to nil response."
                    error(BackendError.objectSerialization(reason: reason))
                    return
                    
                }
                
                success(responseArrayObject)
                
                break
            case .failure(let errorApi):
                print("Error API \(errorApi)")
                error(BackendError.objectSerialization(reason: "There was an error saving the data, try again"))
                break
            default:
                error(BackendError.objectSerialization(reason: "There was an error saving the data, try again"))
                break

            }
        })

        print("APIREQUEST \(api)")
    }
}
