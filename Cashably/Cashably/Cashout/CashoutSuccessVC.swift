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
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var lbTotalRepaymentAmount: UILabel!
    @IBOutlet weak var lbRepayDueDate: UILabel!
    
    @IBOutlet weak var btnDone: UIButton!
    
    public var withdrawData: WithdraW?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        lbAmount.text = "$\(withdrawData!.depositAmount)"
        lbTo.text = withdrawData!.to
        lbRepayDueDate.text = withdrawData!.dueDate
        lbTotalRepaymentAmount.text = "$\(withdrawData!.totalAmount)"
        
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
