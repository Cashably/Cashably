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
        
        if self.tfName.text!.isEmpty || self.tfEmail.text!.isEmpty || self.tfDOB.text!.isEmpty || self.tfSSN.text!.isEmpty {
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
            }
        }
    }
}
