//
//  ResetPasswordVC.swift
//  Cashably
//
//  Created by apollo on 7/14/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ResetPasswordVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tfPasswordConfirm: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasscode: UITextField! {
        didSet {
            tfPasscode.layer.borderWidth = 1
            tfPasscode.layer.borderColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1).cgColor
            tfPasscode.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var passwordConfirmView: InputView!
    @IBOutlet weak var passwordView: InputView!
    
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
        tfPasswordConfirm.delegate = self
        tfPassword.delegate = self
        tfPasscode.delegate = self
        
        passwordConfirmView.didTap(target: tfPasswordConfirm!)
        passwordView.didTap(target: tfPassword!)
        
        tfPasswordConfirm.tag = 3
        tfPassword.tag = 2
        tfPasscode.tag = 1
    }
    
    @IBAction func actionReset(_ sender: UIButton) {
        if tfPasscode.text?.isEmpty == true {
            self.tfPasswordConfirm.shake(6, withDelta: 10, speed: 0.06)
            tfPasswordConfirm.becomeFirstResponder()
            return
        }
        if tfPasswordConfirm.text?.isEmpty == true {
            self.tfPasswordConfirm.shake(6, withDelta: 10, speed: 0.06)
            tfPasswordConfirm.becomeFirstResponder()
            return
        }
        if tfPassword.text?.isEmpty == true {
            self.tfPassword.shake(6, withDelta: 10, speed: 0.06)
            tfPassword.becomeFirstResponder()
            return
        }
        if tfPasswordConfirm.text != tfPassword.text {
            self.showToast(message: "Invalid password confirmation")
            tfPasswordConfirm.becomeFirstResponder()
            return
        }
        self.startAnimating()
        RequestHandler.resetPassword(otp: (tfPasscode.text)!, password: (tfPassword.text)!, success: { (successResponse) in
            self.stopAnimating()
            let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.navigationController?.pushViewController(signinVC, animated: true)
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionShowPassword(_ sender: UIButton) {
        self.tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
    }
    
    @IBAction func actionShowPasswordConfirm(_ sender: UIButton) {
        self.tfPasswordConfirm.isSecureTextEntry = !self.tfPasswordConfirm.isSecureTextEntry
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ResetPasswordVC: UITextFieldDelegate {
 
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
//            textField.resignFirstResponder()
            self.dismissKeyboard()
        }
        return false
    }
 }
