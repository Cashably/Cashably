//
//  PaySnoozeVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Alamofire
import FirebaseAuth

class PaySnoozeVC: UIViewController, NVActivityIndicatorViewable {
    
    var mLoan: LoanModel?
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lbTerms: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbSnoozeFee: UILabel!
    @IBOutlet weak var lbRemainSnooze: UILabel!
    @IBOutlet weak var lbNextDueDate: UILabel!
    @IBOutlet weak var lbTotalAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let createdAt = Date(milliseconds: mLoan!.createdAtTimestamp * 1000).dateFormat(format: "dd/MM")
        let dueAt = Date(milliseconds: mLoan!.dueDateTimestamp * 1000).dateFormat(format: "dd/MM")
        lbTerms.text = "\(createdAt) - \(dueAt)"
        lbAmount.text = "$\((mLoan!.amount)!)"
        lbRemainSnooze.text = "Left \((mLoan!.snooze)!) snooze"
        lbTotalAmount.text = "$\(mLoan!.total!)"
        lbNextDueDate.text = mLoan!.nextDueDate
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
        
        getSnoozePrice()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func getSnoozePrice() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.SNOOZE_PRICE, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            
            let dictionary = successResponse as! [String: Any]
            if let price = dictionary["price"] {
                
                self.lbSnoozeFee.text = "$\(price)"
            }
            
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    func snoozePay() {
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.SNOOZE_PAY, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            self.showToast(message: "Paid snooze fee successfully")
        }) { (error) in
            self.stopAnimating()
                        
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
       
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSnoozePay(_ sender: UIButton) {
        let alert = Alert.showConfirmAlert(message: "Are you sure paying for snooze") { _ in
            self.snoozePay()
        }
        self.presentVC(alert)
    }
}
