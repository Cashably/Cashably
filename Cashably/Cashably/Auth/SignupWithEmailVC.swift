//
//  SignupWithEmailVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import MBCheckboxButton

class SignupWithEmailVC: UIViewController, NVActivityIndicatorViewable {
    
    var window: UIWindow?
    
    @IBOutlet weak var btnSIgnup: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnTerms: CheckboxButton!
    @IBOutlet weak var termsText: UILabel!
    
    @IBOutlet weak var emailView: InputView!
    @IBOutlet weak var passwordView: InputView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isTerms = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tfEmail.becomeFirstResponder()
        tfEmail.delegate = self
        tfPassword.delegate = self
        
        emailView.didTap(target: tfEmail!)
        passwordView.didTap(target: tfPassword!)
        
        tfEmail.tag = 1
        tfPassword.tag = 2
        
        self.addKeyboardWillShowNotification()
        self.hideKeyboardWhenTappedAround()
        
        termsText.isUserInteractionEnabled = true
        termsText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleCheckbox)))
        termsText.attributedText = "terms".termsToAttributedString
        termsText.numberOfLines = 0
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
        let splashVC = storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        navigationController?.pushViewController(splashVC, animated: true)
    }
    
    @objc
    func toggleCheckbox(_ gesture: UITapGestureRecognizer) {
        
        guard let text = self.termsText.text else { return }
        if gesture.didTapAttributedTextInLabel(label: termsText, targetText: "Terms and Condition") {
            UIApplication.shared.open(URL(string: "https://cashably.com/terms-conditions/")!)
        } else if gesture.didTapAttributedTextInLabel(label: termsText, targetText: "Privacy Policy") {
            UIApplication.shared.open(URL(string: "https://cashably.com/privacy-policy/")!)
        } else if gesture.didTapAttributedTextInLabel(label: termsText, targetText: "Terms of service") {
            UIApplication.shared.open(URL(string: "https://www.dwolla.com/legal/tos/")!)
        } else if gesture.didTapAttributedTextInLabel(label: termsText, targetText: "Dwolla Privacy Policy") {
            UIApplication.shared.open(URL(string: "https://www.dwolla.com/legal/privacy/")!)
        }
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
        if !btnTerms.isOn {
            let alert = Alert.showBasicAlert(message: "Please check our terms and policy")
            self.presentVC(alert)
            return
        }
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
        RequestHandler.registerUser(email: (tfEmail.text)!, password: (tfPassword.text)!, success: { (successResponse) in
            self.stopAnimating()
            self.moveToMain()
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionShowPassword(_ sender: UIButton) {
        self.tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignupWithEmailVC: UITextFieldDelegate {
 
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
