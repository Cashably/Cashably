//
//  RequestFaceEnableVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol RequestFaceEnableDelegate {
    func dissmissFace()
}

class RequestFaceEnableVC: UIViewController {
    
    @IBOutlet weak var btnEnable: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    var delegate: RequestFaceEnableDelegate?
    
    @IBAction func actionEnable(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "enableFaceID")
        self.dismiss(animated: true) {
            self.delegate?.dissmissFace()
        }
    }
    
    @IBAction func actionNo(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "enableFaceID")
        self.dismiss(animated: true) {
            self.delegate?.dissmissFace()
        }
    }
    
}
