//
//  CashoutTipVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol CashoutTipDelegate {
    func cashout()
    func cashoutWithTip()
}

class CashoutTipVC: UIViewController {
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var btnCashoutWithTip: UIButton!
    @IBOutlet weak var btnCashout: UIButton!
    
    var delegate: CashoutTipDelegate!
    
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
    
   
    @IBAction func actionCashout(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.cashout()
        }
    }
    
    @IBAction func actionCashoutWithTip(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            self.delegate?.cashoutWithTip()
        }
    }
}
