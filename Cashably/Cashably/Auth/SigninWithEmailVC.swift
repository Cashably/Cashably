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
    @IBOutlet weak var btnBack: UIButton!
    
    
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
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.window?.rootViewController = mainVC
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
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
