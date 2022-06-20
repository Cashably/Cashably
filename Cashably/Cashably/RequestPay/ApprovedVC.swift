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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        UserDefaults.standard.set(50, forKey: "received")
        let cashoutVC = storyboard?.instantiateViewController(withIdentifier: "CashoutVC") as! CashoutVC
        self.navigationController?.pushViewController(cashoutVC, animated: true)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
