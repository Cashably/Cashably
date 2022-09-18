//
//  SignupVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FlagPhoneNumber
import NVActivityIndicatorView
import MBCheckboxButton

class SignupVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnSignupWithEmail: UIButton!
    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnTerms: CheckboxButton!
    @IBOutlet weak var termsText: UILabel!
    @IBOutlet weak var tfPhone: FPNTextField! {
        didSet {
            tfPhone.delegate = self
            tfPhone.tag = 1
        }
    }
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    private var phoneNumber: String!
    
    private var isTerms = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.btnSendOTP.isEnabled = false
        
        termsText.isUserInteractionEnabled = true
        termsText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleCheckbox)))
        termsText.attributedText = "terms".termsToAttributedString
        termsText.numberOfLines = 0
        
        self.flagPhoneNumber()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
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
    func sendOtpCode() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(self.phoneNumber, uiDelegate: nil) { verificationID, error in
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
                verifyPhoneVC.type = "signup"
                verifyPhoneVC.phone = self.phoneNumber
                self.navigationController?.pushViewController(verifyPhoneVC, animated: true)
          }
    }
    
    
    @IBAction func actionSendOTP(_ sender: UIButton) {
        if !btnTerms.isOn {
            let alert = Alert.showBasicAlert(message: "Please check our terms and policy")
            self.presentVC(alert)
            return
        }
        self.startAnimating()
        RequestHandler.checkPhone(phone: phoneNumber, type: "signup", success: { (successResponse) in
            self.sendOtpCode()
            
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
        let signupWithEmailVC = storyboard?.instantiateViewController(withIdentifier: "SignupWithEmailVC") as! SignupWithEmailVC
        navigationController?.pushViewController(signupWithEmailVC, animated: true)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignupVC: FPNTextFieldDelegate {
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

extension SignupVC: UITextFieldDelegate {
 
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
