//
//  CashoutSuccessVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

class CashoutSuccessVC: UIViewController {
    
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    @IBOutlet weak var lbTotalRepaymentAmount: UILabel!
    @IBOutlet weak var lbRepayDueDate: UILabel!
    
    @IBOutlet weak var btnDone: UIButton!
    
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
    
    
    @IBAction func actionDone(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
