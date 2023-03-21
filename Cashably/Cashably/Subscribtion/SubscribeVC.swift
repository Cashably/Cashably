//
//  SubscribeVC.swift
//  Cashably
//
//  Created by apollo on 3/16/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class SubscribeVC: UIViewController, NVActivityIndicatorViewable {
    
    var subscribe: Subscribe?
    
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbMountOff: UILabel!
    @IBOutlet weak var btnSubscribe: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        getSubPrice()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func getSubPrice() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.SUBSCRIBE_PRICE, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            
            let dictionary = successResponse as! [String: Any]
            if let price = dictionary["price"] {
                self.lbPrice.text = "$\(price)"
            }
            
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionSubscribe(_ sender: UIButton) {
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.SUBSCRIBE, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            Shared.subscribed(status: true)
            
            let dictionary = successResponse as! [String: Any]
            if let subscribe = dictionary["subscribe"] as? [String:Any] {
                self.subscribe = Subscribe(fromDictionary: subscribe)
            }
            
            let subVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscribeSuccessVC") as! SubscribeSuccessVC
            subVC.modalTransitionStyle = .coverVertical
            subVC.modalPresentationStyle = .overFullScreen
            self.presentVC(subVC)
            
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SubscribeVC: SubscribeSuccessDelegate {
    func subscribed() {
        self.btnSubscribe.isEnabled = false
        
        let subVC = self.storyboard?.instantiateViewController(withIdentifier: "MySubscribtionVC") as! MySubscribtionVC
        subVC.subscribe = subscribe
        self.navigationController?.pushViewController(subVC, animated: true)
    }
}
