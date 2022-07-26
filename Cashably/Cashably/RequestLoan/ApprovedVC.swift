//
//  ApprovedVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Alamofire
import FirebaseAuth

class ApprovedVC: UIViewController, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
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
    
    @IBAction func actionAccept(_ sender: UIButton) {
        
        self.startAnimating()
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        AF.request("\(Constants.API)/loan/accept",
                   method: .post,
                   parameters: ["userId": user.uid],
                   encoder: URLEncodedFormParameterEncoder.default)
            .responseDecodable(of: StatusResponse.self) { response in
                self.stopAnimating()
                
                if response.value?.status == true {
                    let cashoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CashoutVC") as! CashoutVC
                    self.navigationController?.pushViewController(cashoutVC, animated: true)
                } else {
                    let alert = Alert.showBasicAlert(message: "Network error")
                    self.presentVC(alert)
                }
            }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
