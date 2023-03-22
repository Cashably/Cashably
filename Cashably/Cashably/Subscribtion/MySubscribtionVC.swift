//
//  MySubscribtionVC.swift
//  Cashably
//
//  Created by apollo on 3/16/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class MySubscribtionVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbValidate: UILabel!
    @IBOutlet weak var btnUnsubscribe: UIButton!
    @IBOutlet weak var btnRenewal: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
        loadSubscription()
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user: UserModel = Shared.getUser()
        lbEmail.text = user.email
        lbName.text = user.fullName
        
    }
    
    func loadSubscription() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.SUBSCRIPTION, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            
            let dictionary = successResponse as! [String: Any]
            if let data = dictionary["data"] as? [String: Any] {
                let subscribe = Subscribe(fromDictionary: data)
                self.lbPrice.text = "$\(subscribe.price!)"
                self.lbValidate.text = "Validate till \(subscribe.validate!)"
            }
            
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    func cancelSubscribe() {
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.UNSUBSCRIBE, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            Shared.subscribed(status: false)
            self.btnUnsubscribe.isEnabled = false
            self.btnRenewal.isEnabled = true
            self.showToast(message: "Cancelled your subscription successfully")
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    func renewalSubscribe() {
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.SUBSCRIBE, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            Shared.subscribed(status: true)
            self.btnRenewal.isEnabled = false
            self.btnUnsubscribe.isEnabled = true
            self.showToast(message: "Renewaled your subscription successfully")
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    
    @IBAction func actionCancel(_ sender: UIButton) {
        let alert = Alert.showConfirmAlert(message: "Are you sure unsubscribe?") { _ in
            self.cancelSubscribe()
        }
        self.presentVC(alert)
        
    }
    
    @IBAction func actionRenewal(_ sender: UIButton) {
        let alert = Alert.showConfirmAlert(message: "Are you sure renewal subscribe?") { _ in
            self.renewalSubscribe()
        }
        self.presentVC(alert)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
