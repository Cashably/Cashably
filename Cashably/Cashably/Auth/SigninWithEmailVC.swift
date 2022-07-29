//
//  SigninWithEmailVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import UITextField_Shake

class SigninWithEmailVC: UIViewController, NVActivityIndicatorViewable {
    
    var window: UIWindow?
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnToOtp: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    
    @IBOutlet weak var emailView: InputView!
    @IBOutlet weak var passwordView: InputView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tfEmail.becomeFirstResponder()
        self.addKeyboardWillShowNotification()
        self.hideKeyboardWhenTappedAround()
        
        tfEmail.delegate = self
        tfPassword.delegate = self
        
        emailView.didTap(target: tfEmail)
        passwordView.didTap(target: tfPassword)
        
        tfEmail.tag = 1
        tfPassword.tag = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func moveToMain() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @IBAction func actionSignin(_ sender: UIButton) {
        if tfEmail.text?.isEmpty == true {
            self.tfEmail.shake(6, withDelta: 10, speed: 0.06)
            tfEmail.becomeFirstResponder()
            return
        }
        if tfPassword.text?.isEmpty == true {
            self.tfPassword.shake(6, withDelta: 10, speed: 0.06)
            tfPassword.becomeFirstResponder()
            return
        }

        self.startAnimating()
        RequestHandler.loginUser(email: (tfEmail.text)!, password: (tfPassword.text)!, success: { (successResponse) in
            self.stopAnimating()
            self.moveToMain()
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionShowPassword(_ sender: UIButton) {
        tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
    }
    
    @IBAction func actionPassword(_ sender: Any) {
        let resetVC = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordEmailVC") as! ResetPasswordEmailVC
        navigationController?.pushViewController(resetVC, animated: true)
    }
    
    @IBAction func actionToSignUP(_ sender: UIButton) {
        let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func actionToOtp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SigninWithEmailVC: UITextFieldDelegate {
 
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
