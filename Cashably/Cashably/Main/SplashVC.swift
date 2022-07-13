//
//  SplashVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import FirebaseAuth

class SplashVC: UIViewController, NVActivityIndicatorViewable {
    
    var window: UIWindow?
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        self.checkLogin()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func checkLogin() {
        self.startAnimating()
        if UserDefaults.standard.bool(forKey: "enabledStanding") == false {
            self.moveToStanding()
        } else {
            if let user = Auth.auth().currentUser {
                if user.displayName == nil {
                    self.moveToCompleteProfile()
                } else {
                    self.moveToMain()
                }
            } else {
                self.moveToLogin()
            }
        }
        
    }
    
    func moveToMain() {
        self.stopAnimating()
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
//        self.window?.rootViewController = mainVC
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func moveToStanding() {
        self.stopAnimating()
        let standingVC = storyboard?.instantiateViewController(withIdentifier: "StandingStartVC") as! StandingStartVC
        navigationController?.pushViewController(standingVC, animated: true)
    }
    
    func moveToLogin() {
        self.stopAnimating()
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        navigationController?.pushViewController(loginVC, animated: true)
    }

    func moveToCompleteProfile() {
        self.stopAnimating()
        let profileCompleteVC = storyboard?.instantiateViewController(withIdentifier: "ProfileCompleteVC") as! ProfileCompleteVC
        navigationController?.pushViewController(profileCompleteVC, animated: true)
    }
}
