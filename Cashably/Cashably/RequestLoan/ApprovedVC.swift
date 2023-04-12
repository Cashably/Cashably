//
//  ApprovedVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ApprovedVC: UIViewController, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var lbAmount: UILabel!
    
    public var approved: Double! = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbAmount.text = "$\(approved!)"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionAccept(_ sender: UIButton) {
        
        self.startAnimating()
        RequestHandler.postRequest(url:Constants.URL.LOAN_ACCEPT, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let cashoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CashoutVC") as! CashoutVC
            cashoutVC.limitValue = self.approved
            self.navigationController?.pushViewController(cashoutVC, animated: true)
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
            
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
