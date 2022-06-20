//
//  CashoutVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

class CashoutVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnWithdraw: UIButton!
    
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
    
    private func withdraw() {
        let successVC = storyboard?.instantiateViewController(withIdentifier: "CashoutSuccessVC") as! CashoutSuccessVC
        self.navigationController?.pushViewController(successVC, animated: true)
    }
    
    @IBAction func actionWithdraw(_ sender: UIButton) {
        guard let cardId = UserDefaults.standard.string(forKey: "cardid") else {
            let addcardVC = storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
            addcardVC.delegate = self
            self.navigationController?.pushViewController(addcardVC, animated: true)
            return
        }
        
        self.withdraw()
        
    }
    
    @IBAction func actionInfo(_ sender: UIButton) {
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CashoutVC: AddCardDelegate {
    func addCard() {
        self.withdraw()
    }
}
