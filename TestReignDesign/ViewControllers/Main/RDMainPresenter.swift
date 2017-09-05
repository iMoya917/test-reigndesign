//
//  RDMainPresenter.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit

protocol AMMainView: NSObjectProtocol{
    
    //MARK: hits response api
    func succesHit()
    func errorHit(error: BackendError)
    
    //MARK: hits delete local
    func successDeleteHit(cell: RDHitCell)
    func errorDeleteHit(error: BackendError)
}




class RDMainPresenter: NSObject {

    fileprivate let mainInteractor:RDMainInteractor
    weak fileprivate var mainView : AMMainView?
    
    var arrayHits: [RDHit] = Array()
    
    init(mainInteractor: RDMainInteractor){
        self.mainInteractor = mainInteractor
    }
    
    func attachView(_ view:AMMainView){
        mainView = view
    }
    
    func detachView() {
        mainView = nil
    }

}

extension RDMainPresenter {
    
    //MARK: obtain Hits api
    func obtainHits(){
        self.mainInteractor.getHitsApi(success: { (arrayHits) in
            self.arrayHits = RDHit.orderAndDeleteHitArray()
            self.mainView?.succesHit()
        }) { (error) in
            self.arrayHits = RDHit.orderAndDeleteHitArray()
            self.mainView?.errorHit(error: error)
        }
        
    }
    
    func deleteHit(cellTableView: RDHitCell){
        
      self.mainInteractor.deleteHit(hit: cellTableView.hit!, success: {
        self.arrayHits = RDHit.orderAndDeleteHitArray()
        self.mainView?.successDeleteHit(cell: cellTableView)
      }) { (error) in
        self.mainView?.errorHit(error: error)
        }
    }
    
}

