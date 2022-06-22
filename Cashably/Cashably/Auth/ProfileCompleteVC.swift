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

class ProfileCompleteVC: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
   
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var tfSSN: UITextField!
    
    @IBOutlet weak var btnComplete: UIButton!
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tfName.delegate = self
        tfEmail.delegate = self
        tfDOB.delegate = self
        tfSSN.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
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
}
