//
//  PaycheckDetailVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

class PaycheckDetailVC: UIViewController {
    
    public var depositId: String = ""
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnEditPaycheck: UIButton!
    @IBOutlet weak var btnConfirmPaycheck: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionEditPaycheck(_ sender: UIButton) {
        let editVC = storyboard?.instantiateViewController(withIdentifier: "PaycheckDetailEditVC") as! PaycheckDetailEditVC
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func actionConfirmPaycheck(_ sender: UIButton) {
        let approvedVC = storyboard?.instantiateViewController(withIdentifier: "ApprovedVC") as! ApprovedVC
        self.navigationController?.pushViewController(approvedVC, animated: true)
    }
    
    @IBAction func actionRemove(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
