//
//  RequestNotificationEnableVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol RequestNotificationEnableDelegate {
    func dissmissNotification()
}

class RequestNotificationEnableVC: UIViewController {
    @IBOutlet weak var btnEnable: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var delegate: RequestNotificationEnableDelegate?
    
    @IBAction func actionEnable(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "enableNotification")
        self.dismiss(animated: true) {
            self.delegate?.dissmissNotification()
        }
    }
    
    @IBAction func actionNo(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "enableNotification")
        self.dismiss(animated: true) {
            self.delegate?.dissmissNotification()
        }
    }
}
