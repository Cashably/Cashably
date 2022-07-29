//
//  ResetPasswordEmailVC.swift
//  Cashably
//
//  Created by apollo on 7/14/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ResetPasswordEmailVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var emailView: InputView!
    
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
        tfEmail.delegate = self
        emailView.didTap(target: tfEmail!)
        tfEmail.tag = 1
    }
    
    @IBAction func actionRequest(_ sender: UIButton) {
        if tfEmail.text?.isEmpty == true {
            self.tfEmail.shake(6, withDelta: 10, speed: 0.06)
            tfEmail.becomeFirstResponder()
            return
        }
        
        self.startAnimating()
        
        RequestHandler.forgotPassword(email: (tfEmail.text)!, success: { (successResponse) in
            self.stopAnimating()
            let resetVC = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            self.navigationController?.pushViewController(resetVC, animated: true)
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
        }
    }
       
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ResetPasswordEmailVC: UITextFieldDelegate {
 
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
