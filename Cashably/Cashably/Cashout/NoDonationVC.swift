//
//  NoDonationVC.swift
//  Cashably
//
//  Created by apollo on 6/27/22.
//

import Foundation
import UIKit

class NoDonationVC: UIViewController {
    
    public var delegate: DonationDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionContinue(_ sender: UIButton) {
        self.delegate?.next()
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
    }
}
