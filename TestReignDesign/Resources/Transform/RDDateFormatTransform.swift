//
//  RDDateFormatTransform.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

//static NSString *const kDateFormatDateTime = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
//static NSString *const kDateFormatDateTimeMillisecond = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
//static NSString *const kDateFormatDateOnly = @"yyyy-MM-dd";

enum DateFormatType: String {
    case kDateFormatDateTime = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case kDateFormatDateTimeMillisecond = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    case kDateFormatDateOnly = "yyyy-MM-dd"

}

class RDDateFormatTransform: TransformType {
   
    typealias Object = Date
    typealias JSON = String
    
    var dateFormat = DateFormatter()
    
    convenience init(dateFormat: String) {
        self.init()
        
        if dateFormat.isEmpty{
            self.dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            self.dateFormat.dateFormat = dateFormat
        }
    }
    
    
    func transformFromJSON(_ value: Any?) -> Object?{
        
        if let dateString = value as? String {
            return self.dateFormat.date(from: dateString)
        }
        return nil
    }
    func transformToJSON(_ value: Object?) -> JSON?{
        
        if let date = value {
            return self.dateFormat.string(from: date)
        }
        return nil
    }
    
}
