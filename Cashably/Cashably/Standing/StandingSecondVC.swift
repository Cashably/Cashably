//
//  StandingSecondVC.swift
//  Cashably
//
//  Created by apollo on 7/12/22.
//

import Foundation
import UIKit

class StandingSecondVC: UIViewController {
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
    
    
    @IBAction func actionContinue(_ sender: UIButton) {
        let standingVC = self.storyboard?.instantiateViewController(withIdentifier: "StandingThirdVC") as! StandingThirdVC
        self.navigationController?.pushViewController(standingVC, animated: true)
    }
    
    @IBAction func actionSkip(_ sender: UIButton) {
        let standingVC = self.storyboard?.instantiateViewController(withIdentifier: "StandingThirdVC") as! StandingThirdVC
        self.navigationController?.pushViewController(standingVC, animated: true)
    }
}
