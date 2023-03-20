//
//  NotApprovedVC.swift
//  Cashably
//
//  Created by apollo on 3/16/23.
//

import Foundation
import UIKit

class NotApprovedVC: UIViewController {
    var message: String?
    
    @IBOutlet weak var msgError: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        msgError.text = message
        
    }
    
    @IBAction func actionViewDetail(_ sender: UIButton) {
    }
    @IBAction func actionLater(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
