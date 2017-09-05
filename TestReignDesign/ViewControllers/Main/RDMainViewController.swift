//
//  RDMainViewController.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit

class RDMainViewController: UIViewController {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(RDMainViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    
    var refresh:Bool = false
    
    @IBOutlet weak var hitsTableView: UITableView!
    
    // Init presenter
    fileprivate let mainPresenter = RDMainPresenter(mainInteractor: RDMainInteractor())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationUI()
        self.mainPresenter.attachView(self)
        self.mainPresenter.obtainHits()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let singleWebViewController = segue.destination as? RDSingleWebViewController{
           let cell = sender as? RDHitCell
            singleWebViewController.hit = cell?.hit
        }
    }

}

extension RDMainViewController {

    //MARK: Configurate Initial UI
    func configurationUI(){
        
        hitsTableView.estimatedRowHeight = 80
        hitsTableView.rowHeight = UITableViewAutomaticDimension
        hitsTableView.delegate = self
        hitsTableView.dataSource = self
        hitsTableView.addSubview(self.refreshControl)
    }
    
    //MARK: value change in RefreshControl
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh = true
        self.mainPresenter.obtainHits()
    }
}

extension RDMainViewController: AMMainView{
    
    //MARK: AMMainView
    
    // Success loader hits
    func succesHit(){
        if refresh {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.refreshControl.endRefreshing()
            }
            refresh = false
        }
        hitsTableView.reloadData()
    }
    
    // Error loader hits
    func errorHit(error: BackendError){
        //TODO: see message error
        hitsTableView.reloadData()
    }
    
    // Success Delete hits (local elimination since there is no endpoint)
    func successDeleteHit(cell: RDHitCell){
    
        let indexPath = self.hitsTableView.indexPath(for: cell)
        hitsTableView.beginUpdates()
        hitsTableView.deleteRows(at: [indexPath!], with: .automatic)
        hitsTableView.endUpdates()
        
    }
    
    func errorDeleteHit(error: BackendError){
        //TODO: see message error
    }

}

extension RDMainViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainPresenter.arrayHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hitCell", for: indexPath) as? RDHitCell
        cell?.hit = self.mainPresenter.arrayHits[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            self.mainPresenter.deleteHit(cellTableView: self.hitsTableView.cellForRow(at: indexPath)! as! RDHitCell)
        }
        
        return [deleteAction]

    }
    
 
    
}
