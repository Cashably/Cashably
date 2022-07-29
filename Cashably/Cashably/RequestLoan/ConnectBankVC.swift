//
//  ConnectBankVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import LinkKit
import NVActivityIndicatorView
import CoreData

protocol ConnectBankDelegate {
    func connected()
}

protocol LinkOAuthHandling {
    var linkHandler: Handler? { get }
}

class ConnectBankVC: UIViewController, LinkOAuthHandling, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConnect: UIButton!
    
    var delegate: ConnectBankDelegate!
    
    var linkHandler: Handler?
    
    
    let oauthRedirectURI =  URL(string: "YOUR_OAUTH_REDIRECT_URI")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func plaidLink(linkToken: String) {
        print(linkToken)
        let linkConfiguration = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { linkSuccess in
                // Send the linkSuccess.publicToken to your app server.
                print("linksuccess public token \(linkSuccess.publicToken)")
                self.storePlaidPubToken(token: linkSuccess.publicToken)
            }
        )
        
        let result = Plaid.create(linkConfiguration)
        switch result {
          case .failure(let error):
              print("Plaid create error: \(error)")
          case .success(let handler):
            self.linkHandler = handler
            handler.open(presentUsing: .viewController(self))
        }
    }
    
    func createPlaidLinkToken() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.GET_PLAID_LINK_TOKEN, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            let linktoken = dictionary["data"] as! String
            self.plaidLink(linkToken: linktoken)
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
            
    }
    
    func storePlaidPubToken(token: String) {
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.PLAID_EXCHANGE_PUB_TOKEN, parameter: ["public_token": token], success: { (successResponse) in
            self.stopAnimating()
            self.showToast(message: "Sent successfully")
            self.delegate.connected()
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionConnect(_ sender: UIButton) {
        createPlaidLinkToken()
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ConnectBankVC: ConnectProcessingDelegate {
    func connected() {
        self.delegate.connected()
    }
}
