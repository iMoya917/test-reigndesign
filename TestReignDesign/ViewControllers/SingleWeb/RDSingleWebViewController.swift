//
//  RDSingleWebViewController.swift
//  TestReignDesign
//
//  Created by Ivan Moya Quilodran on 02-09-17.
//  Copyright © 2017 ivan. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDCAlertView

class RDSingleWebViewController: UIViewController {

    @IBOutlet weak var hitWebView: UIWebView!
    var hit:RDHit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if hit?.storyUrl != nil {
            if let url = URL(string: (hit?.storyUrl!)!) {
                let request = URLRequest(url: url)
                self.hitWebView.loadRequest(request)
            }
        }
        
    
        self.hitWebView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}

extension RDSingleWebViewController: UIWebViewDelegate{
    


    public func webViewDidStartLoad(_ webView: UIWebView){
        
        print("webViewDidStartLoad")
        SVProgressHUD.show(withStatus: "Loader...")
    }

    public func webViewDidFinishLoad(_ webView: UIWebView){
        print("webViewDidFinishLoad")
        webView.scalesPageToFit = true
        
        if SVProgressHUD.isVisible(){
            SVProgressHUD.dismiss()
        }
    }

    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        print("didFailLoadWithError")
        
        if SVProgressHUD.isVisible(){
            SVProgressHUD.dismiss()
        }
        
        let alert = AlertController(title: "Error", message: "Rrror loading webpage", preferredStyle: .alert)
        alert.add(AlertAction(title: "Accept", style: .preferred, handler: { (alertOk) in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.present()

    }
}
