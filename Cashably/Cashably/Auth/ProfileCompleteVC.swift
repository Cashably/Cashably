//
//  ProfileCompleteVC.swift
//  Cashably
//
//  Created by apollo on 6/18/22.
//

import Foundation
import UIKit
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
    
    var email: String?
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureForm()
        
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
    
    func configureForm() {
        tfName.delegate = self
        tfEmail.delegate = self
        tfDOB.delegate = self
        tfSSN.delegate = self
        
        tfName.tag = 1
        tfEmail.tag = 2
        tfDOB.tag = 3
        tfSSN.tag = 4
        
        tfDOB.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
        nameView.didTap(target: tfName!)
        emailView.didTap(target: tfEmail!)
        ssnView.didTap(target: tfSSN!)
        dobView.didTap(target: tfDOB!)
        
        if let user = Shared.getUser() as? UserModel {
            if user.email != nil {
                tfEmail.text = user.email
            }
        }
    }
    
    func moveToSplash() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        self.window?.rootViewController = mainVC
        navigationController?.pushViewController(mainVC, animated: true)
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
        
        let params = [
            "name": tfName.text,
            "email": tfEmail.text,
            "dob": tfDOB.text,
            "ssn": tfSSN.text
        ]
        
        RequestHandler.profileUpdate(parameter: params as! NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            Shared.completeUserProfile(status: true)
            self.moveToSplash()
            
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionBakc(_ sender: UIButton) {
        self.logout()
//        self.navigationController?.popViewController(animated: true)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = "\(textField.text!)"
        
        if textField.tag == 4 { // ssn
            if text.count == 3 {
                textField.text = text + string
            }
            if string != "" && text.count >= 3 {
                self.dismissKeyboard()
            }
        }
        return true
        
    }
 }
