//
//  HomeVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import FirebaseAuth

class HomeVC: UIViewController {
    
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    
    private enum Permissions: Int {
        case faceid
        case activity
        case notification
        case overdraft
    }
    
    private var permissions: [Permissions] = [.faceid, .activity, .notification, .overdraft]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.configure()
        
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
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    private func configure() {
        lbEmail.text = Auth.auth().currentUser?.email
        lbName.text = Auth.auth().currentUser?.displayName
        
        
        
        if UserDefaults.standard.float(forKey: "received") == 0 {
            let subview: EmptyRequestPayView = Bundle.main.loadNibNamed("EmptyRequestPayView", owner: self, options: nil)?[0] as! EmptyRequestPayView
            subview.onRequest = {() in self.onRequest()}
            self.bottomView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor).isActive = true
            subview.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor).isActive = true
            subview.widthAnchor.constraint(equalTo: self.bottomView.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: self.bottomView.heightAnchor).isActive = true
        } else {
            let subview = Bundle.main.loadNibNamed("RequestPayView", owner: self, options: nil)?[0] as! RequestPayView
            subview.onRequest = {() in self.onRequest()}
            subview.onPay = {() in self.onPay()}
            subview.onSnooze = {() in self.onSnooze()}
            let payGesture = UITapGestureRecognizer(target: self, action: #selector(self.payAction(_:)))
            let snoozeGesture = UITapGestureRecognizer(target: self, action: #selector(self.snoozeAction(_:)))
            subview.payView.addGestureRecognizer(payGesture)
            subview.snoozeView.addGestureRecognizer(snoozeGesture)
            self.bottomView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor).isActive = true
            subview.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor).isActive = true
            subview.widthAnchor.constraint(equalTo: self.bottomView.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: self.bottomView.heightAnchor).isActive = true
        }
        
    }
    
    private func checkFaceEnable() {
        let face = UserDefaults.standard.bool(forKey: "enableFaceID")
        if !face {
            let faceVC = storyboard?.instantiateViewController(withIdentifier: "RequestFaceEnableVC") as! RequestFaceEnableVC
            faceVC.delegate = self
            faceVC.isModalInPresentation = true
            let nav = UINavigationController(rootViewController: faceVC)
            nav.modalTransitionStyle = .coverVertical
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 25
            }
            self.presentVC(nav)
            return
        }
    }
    
    private func checkActivityEnable() {
        let activity = UserDefaults.standard.bool(forKey: "enableActivity")
        if !activity {
            let activityVC = storyboard?.instantiateViewController(withIdentifier: "RequestActivitiesEnableVC") as! RequestActivitiesEnableVC
            activityVC.delegate = self
            activityVC.isModalInPresentation = true
            let nav = UINavigationController(rootViewController: activityVC)
            nav.modalTransitionStyle = .coverVertical
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 25
            }
            self.presentVC(nav)
            return
        }
    }
    
    private func checkNotificationEnable() {
        let notification = UserDefaults.standard.bool(forKey: "enableNotification")
        if !notification {
            let notificationVC = storyboard?.instantiateViewController(withIdentifier: "RequestNotificationEnableVC") as! RequestNotificationEnableVC
            notificationVC.delegate = self
            notificationVC.isModalInPresentation = true
            let nav = UINavigationController(rootViewController: notificationVC)
            nav.modalTransitionStyle = .coverVertical
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 25
            }
            self.presentVC(nav)
            return
        }
    }
    
    private func checkOverdraftEnable() {
        let overdraft = UserDefaults.standard.bool(forKey: "enableOverdraft")
        if !overdraft {
            let overdraftVC = storyboard?.instantiateViewController(withIdentifier: "RequestOverdraftEnableVC") as! RequestOverdraftEnableVC
            overdraftVC.delegate = self
            overdraftVC.isModalInPresentation = true
            let nav = UINavigationController(rootViewController: overdraftVC)
            nav.modalTransitionStyle = .coverVertical
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 25
            }
            self.presentVC(nav)
            return
        }
    }
    
    private func checkPermissions() {
        self.checkFaceEnable()
        self.checkActivityEnable()
        self.checkNotificationEnable()
        self.checkOverdraftEnable()
        
    }
    
    func onRequest() {
        guard let connectedBankId = UserDefaults.standard.string(forKey: "connectedBankId") else {
            let connectBankVC = self.storyboard?.instantiateViewController(withIdentifier: "ConnectBankVC") as! ConnectBankVC
            connectBankVC.delegate = self
            self.navigationController?.pushViewController(connectBankVC, animated: true)
            return
        }
        
        let depositVC = self.storyboard?.instantiateViewController(withIdentifier: "DepositsVC") as! DepositsVC
        depositVC.connectedBankId = connectedBankId
        self.navigationController?.pushViewController(depositVC, animated: true)
        
    }
    
    func onPay() {
        let repayVC = self.storyboard?.instantiateViewController(withIdentifier: "RepayVC") as! RepayVC
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
        let depositsVC = self.storyboard?.instantiateViewController(withIdentifier: "DepositsVC") as! DepositsVC
        self.navigationController?.pushViewController(depositsVC, animated: true)
    }    
}
