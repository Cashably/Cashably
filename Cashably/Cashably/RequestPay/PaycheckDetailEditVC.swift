//
//  PaycheckDetailEditVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class PaycheckDetailEditVC: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfDueDate: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionConfirm(_ sender: UIButton) {
        let approvedVC = storyboard?.instantiateViewController(withIdentifier: "ApprovedVC") as! ApprovedVC
        self.navigationController?.popToViewController(approvedVC, animated: true)
    }
    
    @IBAction func actionRemove(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
