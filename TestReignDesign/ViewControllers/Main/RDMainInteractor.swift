//
//  RDMainInteractor.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import RealmSwift


class RDMainInteractor: NSObject {
    
    //MARK: obtain hits api
    func getHitsApi(success:@escaping (_ hitsArray: [RDHit]) -> Void , error: @escaping (_ error: BackendError) -> Void) -> Void{
        
        ApiManager.getHits(success: { (arrayHits) in
            
            do {
                let realm = try Realm()
                
                for hitItem in arrayHits {
                    
                    try! realm.write {
                        realm.add(hitItem, update: true)
                    }
                }
                
                success(arrayHits)
                
            } catch _ as NSError {
                error(BackendError.objectSerialization(reason: "Hubo al guardar los datos, intente nuevamente"))
            }
            
            
            
        }) { (errorBackend) in
            error(errorBackend)
        }
        
    }
    
    //MARK: delete hits local ORM
    func deleteHit(hit: RDHit, success:@escaping () -> Void , error: @escaping (_ error: BackendError) -> Void) -> Void{
        
        do {
            let realm = try Realm()
            
            try! realm.write {
                hit.isDelate = true
            }
            success()
        } catch _ as NSError {
            error(BackendError.objectSerialization(reason: "Hubo al guardar los datos, intente nuevamente"))
        }
        
    }
}
