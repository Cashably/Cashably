//
//  RequestOverdraftEnableVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol RequestOverdraftEnableDelegate {
    func dissmissOverdraft()
}

class RequestOverdraftEnableVC: UIViewController {
    @IBOutlet weak var btnEnable: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var delegate: RequestOverdraftEnableDelegate?
    
    @IBAction func actionEnable(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "enableOverdraft")
        self.dismiss(animated: true) {
            self.delegate?.dissmissOverdraft()
        }
    }
    
    @IBAction func actionNo(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "enableOverdraft")
        self.dismiss(animated: true) {
            self.delegate?.dissmissOverdraft()
        }
    }
}
