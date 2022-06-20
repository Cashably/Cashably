//
//  BankVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

class BankVC: UIViewController {
    
    @IBOutlet weak var lbBalance: UILabel!
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    
    @IBOutlet weak var chatView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.btnWeek.backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.btnWeek.layer.cornerRadius = 10
        self.btnWeek.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = .white
            return container
        }

        self.btnMonth.layer.cornerRadius = 10
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionFilter(_ sender: UIButton) {
    }
    
    @IBAction func actionWeek(_ sender: UIButton) {
        self.btnWeek.backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.btnWeek.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = .white
            return container
        }

        self.btnMonth.backgroundColor = .clear
        self.btnMonth.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = UIColor(red: 0.388, green: 0.384, blue: 0.384, alpha: 1)
            return container
        }
    }
    
    @IBAction func actionMonth(_ sender: UIButton) {
        self.btnMonth.backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.btnMonth.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = .white
            return container
        }

        self.btnWeek.backgroundColor = .clear
        self.btnWeek.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = UIColor(red: 0.388, green: 0.384, blue: 0.384, alpha: 1)
            return container
        }
    }
    
    
}
