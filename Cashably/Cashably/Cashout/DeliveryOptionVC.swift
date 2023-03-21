//
//  DeliveryOptionVC.swift
//  Cashably
//
//  Created by apollo on 3/16/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class DeliveryOptionVC: UIViewController , NVActivityIndicatorViewable{
    
    public var amount: Double?
    public var donate: Double?
    public var company: String?
    
    private var isInstant: Bool = false
    
    @IBOutlet weak var normalOptionView: NormalDeliveryOption!
    @IBOutlet weak var normalOptionDesView: NormalDeliveryOptionDes!
    @IBOutlet weak var instantOptionView: InstantDeliveryOption!
    @IBOutlet weak var instantOptionDesView: InstantDeliveryOptionDes!
    @IBOutlet weak var optionDesView: UIView!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var unsubscribedStack: UIStackView!
    @IBOutlet weak var btnExpress: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Shared.getUser().subscribed {
            instantOptionView.setFree()
            normalOptionView.btnFull.isHidden = true
            unsubscribedStack.isHidden = true
        } else {
            instantOptionDesView.isHidden = true
            normalOptionDesView.isHidden = false
            normalOptionView.selectedView()
            instantOptionView.unselectedView()
            btnExpress.isHidden = true
            
            getInstantPrice()
        }
        
        normalOptionView.btnFullAction = { () in
            self.isInstant = false
            self.instantOptionView.unselectedView()
            self.instantOptionDesView.isHidden = true
            self.normalOptionDesView.isHidden = false
        }
        
        instantOptionView.btnFullAction = { () in
            self.isInstant = true
            self.normalOptionView.unselectedView()
            self.instantOptionDesView.isHidden = false
            self.normalOptionDesView.isHidden = true
        }
        
    }
    
    func getInstantPrice() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.INSTANT_PRICE, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            
            let dictionary = successResponse as! [String: Any]
            if let price = dictionary["price"] as? [String:Any] {
                self.instantOptionView.lbPrice.text = "$\(price)"
            }
            
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionNormal(_ sender: UIButton) {
        withdraw()
    }
    
    @IBAction func actionSubscribe(_ sender: UIButton) {
        let subscribevc = self.storyboard?.instantiateViewController(withIdentifier: "SubscribeVC") as! SubscribeVC
        self.navigationController?.pushViewController(subscribevc, animated: true)
    }
    
    @IBAction func actionExpressInstant(_ sender: Any) {
        withdraw()
    }
    
    func withdraw() {
        self.startAnimating()
        let params = ["amount": "\(amount!)", "donate": "\(donate!)", "company": company!, "instant": isInstant] as [String : Any]
        RequestHandler.postRequest(url:Constants.URL.WITHDRAW, parameter: params as! NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            if let data = dictionary["data"] as? [String:Any] {
                let loan = WithdrawModel(fromDictionary: data)
                self.dismiss(animated: true) {
                    if self.donate! > 0 {
                        let donationvc = self.storyboard?.instantiateViewController(withIdentifier: "DonationThanksVC") as! DonationThanksVC
                        donationvc.withdrawData = loan
                        self.navigationController?.pushViewController(donationvc, animated: true)
                    } else {
                        let nodonationvc = self.storyboard?.instantiateViewController(withIdentifier: "NoDonationVC") as! NoDonationVC
                        nodonationvc.withdrawData = loan
                        self.navigationController?.pushViewController(nodonationvc, animated: true)
                    }
                }
            }
            
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
            
        }
    }
}
