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
    
    @IBOutlet weak var tfCardNo: UITextField! {
        didSet {
            tfCardNo.delegate = self
        }
    }
    @IBOutlet weak var tfCardDate: UITextField! {
        didSet {
            tfCardDate.delegate = self
            tfCardDate.layer.cornerRadius = 10
            tfCardDate.layer.borderWidth = 1
            tfCardDate.layer.borderColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var tfCardCVV: UITextField! {
        
        didSet {
            tfCardCVV.delegate = self
            tfCardCVV.layer.cornerRadius = 10
            tfCardCVV.layer.borderWidth = 1
            tfCardCVV.layer.borderColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1).cgColor
        }
    }
    
    var delegate: AddCardDelegate!
    
    var timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tfCardDate.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @objc func tapDone() {
        if let datePicker = self.tfCardDate.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
//            dateformatter.dateStyle = .short
            dateformatter.dateFormat = "MM/YY"
            self.tfCardDate.text = dateformatter.string(from: datePicker.date)
        }
        self.tfCardDate.resignFirstResponder()
    }
    
    @IBAction func actionAddCard(_ sender: UIButton) {
        UserDefaults.standard.set("123456789", forKey: "cardid")
        self.delegate.addCard()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
