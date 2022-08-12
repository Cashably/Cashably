//
//  NotificationsVC.swift
//  Cashably
//
//  Created by apollo on 7/11/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class NotificationsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var latestToggle: UISwitch!
    @IBOutlet weak var transactionsToggle: UISwitch!
    @IBOutlet weak var smsToggle: UISwitch!
    @IBOutlet weak var emailToggle: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
        loadAlerts()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func loadAlerts() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.ALERTS, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            if let alert = dictionary["data"] as? [String:Any] {
                if let latest = alert["latest"] as? Bool {
                    self.latestToggle.isOn = latest
                }
                if let transactions = alert["transactions"] as? Bool {
                    self.transactionsToggle.isOn = transactions
                }
                if let email = alert["email"] as? Bool {
                    self.emailToggle.isOn = email
                }
                if let sms = alert["sms"] as? Bool {
                    self.smsToggle.isOn = sms
                }
            }
                
            
        }) { (error) in
            self.stopAnimating()
            
        }
    }
    
    func updateAlerts(params: [String: Any]) {
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.ALERTS, parameter: params as! NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionTransactionsAlert(_ sender: UISwitch) {
        let params = [
            "transactions": sender.isOn
        ]
        
        updateAlerts(params: params)
        
    }
    @IBAction func actionNewOffers(_ sender: UISwitch) {
        let params = [
            "latest": sender.isOn
        ]
        
        updateAlerts(params: params)
    }
    @IBAction func actionEmailAlerts(_ sender: UISwitch) {
        let params = [
            "email": sender.isOn
        ]
        
        updateAlerts(params: params)
    }
    @IBAction func actionSMSAlert(_ sender: UISwitch) {
        let params = [
            "sms": sender.isOn
        ]
        
        updateAlerts(params: params)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
