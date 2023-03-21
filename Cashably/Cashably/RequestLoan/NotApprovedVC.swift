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
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        msgError.text = message
        
    }
    
    @IBAction func actionViewDetail(_ sender: UIButton) {
        print("selected1")
    }
    
    @IBAction func actionLater(_ sender: UIButton) {
        print("selected")
        self.dismissVC(completion: nil)
    }    
}
