//
//  PaySnoozeVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Alamofire
import FirebaseAuth

class PaySnoozeVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lbTerms: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbSnoozeFee: UILabel!
    @IBOutlet weak var lbRemainSnooze: UILabel!
    @IBOutlet weak var lbNextDueDate: UILabel!
    @IBOutlet weak var lbTotalAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let loan: LoanResponse = Shared.getAcceptedLoan()
        let createdAt = Date(milliseconds: loan.createdAtTimestamp * 1000).dateFormat(format: "dd/MM")
        let dueAt = Date(milliseconds: loan.dueDateTimestamp * 1000).dateFormat(format: "dd/MM")
        lbTerms.text = "\(createdAt) - \(dueAt)"
        lbAmount.text = "$\(loan.amount)"
        lbSnoozeFee.text = "$\(loan.snoozeFee)"
        lbRemainSnooze.text = "Left \(loan.snooze) snooze"
        lbTotalAmount.text = "$\(loan.total + loan.snoozeFee)"
        lbNextDueDate.text = loan.nextDueDate
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func snoozePay() {
        self.startAnimating()
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        AF.request("\(Constants.API)/snooze_pay",
                   method: .post,
                   parameters: ["userId": user.uid],
                   encoder: URLEncodedFormParameterEncoder.default)
                .responseDecodable(of: MessageResponse.self) { response in
                    self.stopAnimating()
                    
                    if response.value?.status == true {
                        self.showToast(message: "Paid snooze fee successfully")
                    } else {
                        let alert = Alert.showBasicAlert(message: response.value!.message)
                        self.presentVC(alert)
                    }
                    
                }
    }
       
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSnoozePay(_ sender: UIButton) {
        let alert = Alert.showConfirmAlert(message: "Are you sure paying for snooze") { _ in
            self.snoozePay()
        }
        self.presentVC(alert)
    }
}
