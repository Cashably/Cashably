//
//  SignInVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import FirebaseAuth
import NVActivityIndicatorView
import FlagPhoneNumber

class SignInVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnLoginWithEmail: UIButton!
    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var tfPhone: FPNTextField! {
        didSet {
            tfPhone.delegate = self
            tfPhone.tag = 1
        }
    }
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    private var phoneNumber: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.flagPhoneNumber()
        
        self.btnSendOTP.isEnabled = false
//        self.tfPhone.becomeFirstResponder()
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
    
    func flagPhoneNumber() {
        tfPhone.layer.borderColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1).cgColor
        tfPhone.layer.cornerRadius = 10
        tfPhone.layer.borderWidth = 1
        tfPhone.setFlag(countryCode: .US)
        tfPhone.displayMode = .list // .picker by default
        listController.setup(repository: tfPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.tfPhone.setFlag(countryCode: country.code)
        }
    }
    
//    override func keyboardWillShowWithFrame(_ frame: CGRect) {
//        print("keyboardwillshowwithfram")
//    }
    
    @IBAction func actionSendOTP(_ sender: UIButton) {
        self.startAnimating()
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                self.stopAnimating()
                  if let error = error {
                      let alert = Alert.showBasicAlert(message: error.localizedDescription)
                      self.presentVC(alert)
                      return
                  }
              // Sign in using the verificationID and the code sent to the user
              // ...
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

                let verifyPhoneVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPhoneVC") as! VerifyPhoneVC
                verifyPhoneVC.type = "signin"
                verifyPhoneVC.phone = self.phoneNumber
                self.navigationController?.pushViewController(verifyPhoneVC, animated: true)
          }
        
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        let signinWithEmailVC = storyboard?.instantiateViewController(withIdentifier: "SigninWithEmailVC") as! SigninWithEmailVC
        navigationController?.pushViewController(signinWithEmailVC, animated: true)
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
        let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}

extension SignInVC: FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
          let navigationViewController = UINavigationController(rootViewController: listController)
          
          present(navigationViewController, animated: true, completion: nil)
       }

       /// Lets you know when a country is selected
       func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
          print(name, dialCode, code) // Output "France", "+33", "FR"
       }

       /// Lets you know when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966)
       func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
           listController.setup(repository: textField.countryRepository)
          if isValid {
             // Do something...
              phoneNumber = textField.getFormattedPhoneNumber(format: .E164) // Output "+33600000001"
              self.btnSendOTP.isEnabled = true
          } else {
             // Do something...
              self.btnSendOTP.isEnabled = false
          }
       }
}

extension SignInVC: UITextFieldDelegate {
 
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
