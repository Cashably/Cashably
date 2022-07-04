//
//  HelpVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

class HelpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var sendView: UIView!
    
    @IBOutlet weak var msgView: InputView!
    @IBOutlet weak var tfMsg: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        msgView.didTap(target: tfMsg)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
