//
//  MainVC.swift
//  Cashably
//
//  Created by apollo on 6/17/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class MainVC: UITabBarController {
    
    private var handle: AuthStateDidChangeListenerHandle?;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("mainvc staus bar prefered")
        return .lightContent
    }
    
    override var childForStatusBarStyle: UIViewController? {
        print("change status bar")
        return selectedViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
            
        }
        
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
       
       Auth.auth().removeStateDidChangeListener(handle!)
   }


}
