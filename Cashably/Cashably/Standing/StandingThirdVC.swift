//
//  StandingThirdVC.swift
//  Cashably
//
//  Created by apollo on 7/12/22.
//

import Foundation
import UIKit

class StandingThirdVC: UIViewController {
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
    
    
    @IBAction func actionCreateAccount(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "enabledStanding")
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "enabledStanding")
        let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(signinVC, animated: true)
    }
}
