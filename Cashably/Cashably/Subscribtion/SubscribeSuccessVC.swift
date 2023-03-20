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
    
    @IBAction func actionViewDetails(_ sender: UIButton) {
        self.delegate?.subscribed()
    }
    
}
