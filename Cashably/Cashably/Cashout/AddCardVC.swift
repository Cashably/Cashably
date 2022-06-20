//
//  AddCardVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

protocol AddCardDelegate {
    func addCard()
}

class AddCardVC: UIViewController, NVActivityIndicatorViewable, UITextFieldDelegate {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAddCard: UIButton!
    
    @IBOutlet weak var tfCardNo: UITextField!
    @IBOutlet weak var tfCardDate: UITextField!
    @IBOutlet weak var tfCardCVV: UITextField!
    
    var delegate: AddCardDelegate!
    
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
    
    @IBAction func actionAddCard(_ sender: UIButton) {
        UserDefaults.standard.set("123456789", forKey: "cardid")
        self.delegate.addCard()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
