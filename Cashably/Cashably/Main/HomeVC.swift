//
//  HomeVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FittedSheets
import NVActivityIndicatorView

class HomeVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    var loanAmount: Double = 0
    
    
    private enum Permissions: Int {
        case faceid
        case activity
        case notification
        case overdraft
    }
    
    private var permissions: [Permissions] = [.faceid, .activity, .notification, .overdraft]
    
    struct DecodableType: Decodable {
        let status: Bool
    }
    
    struct UserType: Decodable {
        let loanAmount: Double
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.checkPermissions()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("home staus bar prefered")
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
        self.checkLoan()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    private func checkPermissions() {
        self.checkFaceEnable()
        self.checkActivityEnable()
        self.checkNotificationEnable()
        self.checkOverdraftEnable()
        
    }
    
    func onRequest() {
        self.requestLoan()
    }
    
    func onPay() {
        let repayVC = self.storyboard?.instantiateViewController(withIdentifier: "RepayVC") as! RepayVC
        repayVC.loanAmount = self.loanAmount
        self.navigationController?.pushViewController(repayVC, animated: true)
    }
    
    func onSnooze() {
        let paySnoozeVC = self.storyboard?.instantiateViewController(withIdentifier: "PaySnoozeVC") as! PaySnoozeVC
        self.navigationController?.pushViewController(paySnoozeVC, animated: true)
    }
    
    @objc func payAction(_ sender:UITapGestureRecognizer){
        self.onPay()
    }
    @objc func snoozeAction(_ sender:UITapGestureRecognizer){
        self.onSnooze()
    }
}

extension HomeVC: RequestFaceEnableDelegate {
    func dissmissFace() {
        self.checkActivityEnable()
        self.checkNotificationEnable()
        self.checkOverdraftEnable()
    }
}

extension HomeVC: RequestActivitiesEnableDelegate {
    func dissmissActivity() {
        self.checkNotificationEnable()
        self.checkOverdraftEnable()
    }
}

extension HomeVC: RequestNotificationEnableDelegate {
    func dissmissNotification() {
        self.checkOverdraftEnable()
    }
}

extension HomeVC: RequestOverdraftEnableDelegate {
    func dissmissOverdraft() {
        
    }
}

extension HomeVC: ConnectBankDelegate {
    func connected() {
        let depositsVC = self.storyboard?.instantiateViewController(withIdentifier: "ApprovedVC") as! ApprovedVC
        self.navigationController?.pushViewController(depositsVC, animated: true)
    }    
}
