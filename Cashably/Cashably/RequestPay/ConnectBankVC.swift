//
//  ConnectBankVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import Alamofire
import LinkKit
import FirebaseAuth
import NVActivityIndicatorView

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
        self.startAnimating()
        let linkConfiguration = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { linkSuccess in
                // Send the linkSuccess.publicToken to your app server.
                self.stopAnimating()
                print("linksuccess public token \(linkSuccess.publicToken)")
            }
        )
        
        let result = Plaid.create(linkConfiguration)
        switch result {
          case .failure(let error):
            self.stopAnimating()
              print("Plaid create error: \(error)")
          case .success(let handler):
            self.stopAnimating()
            self.linkHandler = handler
            handler.open(presentUsing: .viewController(self))
        }
    }
    
    func createPlaidLinkToken() {
        self.startAnimating()
        AF.request("\(Constants.API)/plaid/link-token",
                   method: .post,
                   parameters: ["userId": Auth.auth().currentUser?.uid],
                   encoder: URLEncodedFormParameterEncoder.default).responseString { response in
            debugPrint(response)
            self.stopAnimating()
            self.plaidLink(linkToken: response.value!)
        }
        
    }
    
    @IBAction func actionConnect(_ sender: UIButton) {
//        let processingVC = storyboard?.instantiateViewController(withIdentifier: "ConnectProcessingVC") as! ConnectProcessingVC
//        processingVC.delegate = self
//        self.navigationController?.pushViewController(processingVC, animated: true)
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
