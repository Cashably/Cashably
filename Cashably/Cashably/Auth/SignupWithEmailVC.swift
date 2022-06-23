//
//  SignupWithEmailVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class SignupWithEmailVC: UIViewController, NVActivityIndicatorViewable {
    
    var window: UIWindow?
    
    @IBOutlet weak var btnSIgnup: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var emailView: InputView!
    @IBOutlet weak var passwordView: InputView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tfEmail.becomeFirstResponder()
        tfEmail.delegate = self
        tfPassword.delegate = self
        
        emailView.didTap(target: tfEmail)
        passwordView.didTap(target: tfPassword)
        
        tfEmail.tag = 1
        tfPassword.tag = 2
        
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
    
    func moveToProfile() {
        let profileEditVC = storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        navigationController?.pushViewController(profileEditVC, animated: true)
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
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
        Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) { [weak self] authResult, error in
            self?.stopAnimating()
            guard let strongSelf = self else { return }
          // ...
            self?.moveToProfile()
        }
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
