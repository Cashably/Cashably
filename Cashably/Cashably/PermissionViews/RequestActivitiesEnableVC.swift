//
//  RequestActivitiesEnableVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol RequestActivitiesEnableDelegate {
    func dissmissActivity()
}

class RequestActivitiesEnableVC: UIViewController {
    @IBOutlet weak var btnEnable: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var delegate: RequestActivitiesEnableDelegate?
    
    @IBAction func actionEnable(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "enableActivity")
        self.dismiss(animated: true) {
            self.delegate?.dissmissActivity()
        }
    }
    
    @IBAction func actionNo(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "enableActivity")
        self.dismiss(animated: true) {
            self.delegate?.dissmissActivity()
        }
    }
}
