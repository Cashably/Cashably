//
//  ProfileCompleteVC.swift
//  Cashably
//
//  Created by apollo on 6/18/22.
//

import Foundation
import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class ProfileCompleteVC: UIViewController, NVActivityIndicatorViewable {
   
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var tfSSN: UITextField!
    @IBOutlet weak var nameView: InputView!
    @IBOutlet weak var emailView: InputView!
    @IBOutlet weak var ssnView: InputView!
    @IBOutlet weak var dobView: InputView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnComplete: UIButton!
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tfName.delegate = self
        tfEmail.delegate = self
        tfDOB.delegate = self
        tfSSN.delegate = self
        
        tfName.tag = 1
        tfEmail.tag = 2
        tfDOB.tag = 3
        tfSSN.tag = 4
        
        tfDOB.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
        nameView.didTap(target: tfName)
        emailView.didTap(target: tfEmail)
        ssnView.didTap(target: tfSSN)
        dobView.didTap(target: tfDOB)
        
        self.addKeyboardWillShowNotification()
        self.hideKeyboardWhenTappedAround()
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
        if let datePicker = self.tfDOB.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
//            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "dd/MM/YYYY"
            self.tfDOB.text = dateformatter.string(from: datePicker.date)
        }
        self.tfDOB.resignFirstResponder()
    }
    
    @IBAction func actionComplete(_ sender: UIButton) {
        
        if tfName.text?.isEmpty == true {
            self.tfName.shake(6, withDelta: 10, speed: 0.06)
            tfName.becomeFirstResponder()
            return
        }
        if tfEmail.text?.isEmpty == true {
            self.tfEmail.shake(6, withDelta: 10, speed: 0.06)
            tfEmail.becomeFirstResponder()
            return
        }
        
        if tfDOB.text?.isEmpty == true {
            self.tfDOB.shake(6, withDelta: 10, speed: 0.06)
            tfDOB.becomeFirstResponder()
            return
        }
        if tfSSN.text?.isEmpty == true {
            self.tfSSN.shake(6, withDelta: 10, speed: 0.06)
            tfSSN.becomeFirstResponder()
            return
        }
        
        self.startAnimating()
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.tfName.text!
        
//        changeRequest?.
        changeRequest?.commitChanges { error in
            self.stopAnimating()
            if let error = error {
                let alert = Alert.showBasicAlert(message: error.localizedDescription)
                self.presentVC(alert)
                return
            }
            
            Auth.auth().currentUser?.updateEmail(to: self.tfEmail.text!) { error in
                self.stopAnimating()
                if let error = error {
                    let alert = Alert.showBasicAlert(message: error.localizedDescription)
                    self.presentVC(alert)
                    return
                }
                
                self.showToast(message: "Updated successfully")
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                self.window?.rootViewController = mainVC
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }
    
    @IBAction func actionBakc(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileCompleteVC: UITextFieldDelegate {
 
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
 }
