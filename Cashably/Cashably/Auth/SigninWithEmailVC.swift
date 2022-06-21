//
//  SigninWithEmailVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class SigninWithEmailVC: UIViewController, NVActivityIndicatorViewable {
    
    var window: UIWindow?
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnToOtp: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        self.startAnimating()
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { [weak self] authResult, error in
            self?.stopAnimating()
            guard let strongSelf = self else { return }
          // ...
            self?.moveToMain()
        }
    }
    
    @IBAction func actionPassword(_ sender: Any) {
    }
    
    @IBAction func actionToSignUP(_ sender: UIButton) {
        let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func actionToOtp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
