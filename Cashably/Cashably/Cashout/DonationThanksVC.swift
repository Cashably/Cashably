//
//  DonationThanksVC.swift
//  Cashably
//
//  Created by apollo on 6/27/22.
//

import Foundation
import UIKit

class DonationThanksVC: UIViewController {
    
    public var withdrawData: WithdrawModel?
    
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
        successVC.withdrawData = self.withdrawData!
        self.navigationController?.pushViewController(successVC, animated: true)
    }
    
    @IBAction func actionContinue(_ sender: UIButton) {
        guard let cardId = UserDefaults.standard.string(forKey: "cardid") else {
            let addcardVC = storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
            addcardVC.delegate = self
            self.navigationController?.pushViewController(addcardVC, animated: true)
            return
        }
        
        self.withdraw()
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DonationThanksVC: AddCardDelegate {
    func addCard() {
        self.withdraw()
    }
}
