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
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        AF.request("\(Constants.API)/plaid/link_token",
                   method: .get,
                   parameters: ["userId": user.uid],
                   encoder: URLEncodedFormParameterEncoder.default)
                .responseDecodable(of: StringDataResponse.self) { response in
                    self.stopAnimating()
                    
                    if response.value?.status == true {
                        guard let linktoken = response.value?.data else {
                            return
                        }
                        self.plaidLink(linkToken: linktoken)
                    } else {
                        guard let error = response.value?.data else {
                            return
                        }
                        let alert = Alert.showBasicAlert(message: error)
                        self.presentVC(alert)
                    }
                    
                }
            
    }
    
    func storePlaidPubToken(token: String) {
        self.startAnimating()
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        AF.request("\(Constants.API)/plaid/exchange_public_token",
                   method: .post,
                   parameters: ["userId": user.uid, "public_token": token],
                   encoder: URLEncodedFormParameterEncoder.default)
                .responseDecodable(of: StringDataResponse.self) { response in
                    self.stopAnimating()
                    print(response)
                    if response.value?.status == true {
                        self.showToast(message: "Sent successfully")
                        self.delegate.connected()
                    } else {
                        guard let error = response.value?.data else {
                            return
                        }
                        let alert = Alert.showBasicAlert(message: error)
                        self.presentVC(alert)
                    }
                    
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
