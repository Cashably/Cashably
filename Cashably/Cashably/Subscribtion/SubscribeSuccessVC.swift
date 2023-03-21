//
//  SubscribeSuccessVC.swift
//  Cashably
//
//  Created by apollo on 3/16/23.
//

import Foundation
import UIKit

protocol SubscribeSuccessDelegate {
    func subscribed()
}

class SubscribeSuccessVC: UIViewController {
    
    var delegate: SubscribeSuccessDelegate!
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionViewDetails(_ sender: UIButton) {
        self.dismissVC(completion: nil)
        self.delegate?.subscribed()
    }
    
}
