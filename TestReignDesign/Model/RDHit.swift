//
//  RDHit.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class RDHit: Object, Mappable {
    
    dynamic var remoteID:Int = 0
    dynamic var createAt:Date?
    dynamic var title:String?
    dynamic var url:String!
    dynamic var author:String?
    dynamic var points:Int = 0
    dynamic var storyText:String?
    dynamic var commentText:String?
    dynamic var numComments:Int = 0
    dynamic var storyId:Int = 0
    dynamic var storyTitle:String?
    dynamic var storyUrl:String?
    dynamic var parentId:Int = 0
    dynamic var isDelate:Bool = false
    
    override static func primaryKey() -> String? {
        return "remoteID"
    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        remoteID <-     map["story_id"]
        createAt <-    (map["created_at"], RDDateFormatTransform(dateFormat: DateFormatType.kDateFormatDateTimeMillisecond.rawValue))
        title <-        map["title"]
        url <-          map["url"]
        author <-       map["author"]
        points <-       map["points"]
        storyText <-    map["story_text"]
        commentText <-  map["comment_text"]
        numComments <-  map["num_comments"]
        storyTitle <-   map["story_title"]
        storyUrl <-     map["story_url"]
        parentId <-    map["parent_id"]
    }
    
}


extension RDHit{
    
    static func orderAndDeleteHitArray() -> [RDHit] {
        let realm = try! Realm()
        let arrayHit = Array(realm.objects(RDHit.self).sorted(byKeyPath: "createAt", ascending: false).filter("isDelate = %@",false))
        return arrayHit
    }
    
}
