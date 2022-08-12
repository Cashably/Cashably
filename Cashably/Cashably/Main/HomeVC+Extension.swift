//
//  HomeVC+Extension.swift
//  Cashably
//
//  Created by apollo on 7/21/22.
//

import Foundation
import UIKit
import FittedSheets

extension HomeVC {
    
    func configure() {
        lbEmail.text = Shared.getUser().email
        lbName.text = Shared.getUser().fullName
        
        if self.loanAmount == 0 {
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
            let storedLoan = Shared.getLoan()
            subview.lbAmount.text = "$\(self.loanAmount)"
            subview.lbDueDate.text = self.dueDate
            subview.lbApprovedAmount.text = "of $\(storedLoan.approved!)"
            let availabeAmount = storedLoan.approved - storedLoan.amount
            if availabeAmount == 0 {
                subview.moreView.isHidden = true
            }
            subview.lbAvailableAmount.text = "$\(availabeAmount)"
            subview.onWithdrawMore = {() in self.onWithdrawMore()}
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
    
    func checkFaceEnable() {
        let face = UserDefaults.standard.bool(forKey: "enableFaceID")
        if !face {
            let faceVC = storyboard?.instantiateViewController(withIdentifier: "RequestFaceEnableVC") as! RequestFaceEnableVC
            faceVC.delegate = self

            let options = SheetOptions(
                pullBarHeight: 0
            )
            let sheetController = SheetViewController(
                controller: faceVC,
                sizes: [.fixed(400)],
                options: options
                )
            sheetController.cornerRadius = 25
            sheetController.dismissOnOverlayTap = false
            self.present(sheetController, animated: true, completion: nil)
            return
        }
    }
    
    func checkActivityEnable() {
        let activity = UserDefaults.standard.bool(forKey: "enableActivity")
        if !activity {
            let activityVC = storyboard?.instantiateViewController(withIdentifier: "RequestActivitiesEnableVC") as! RequestActivitiesEnableVC
            activityVC.delegate = self

            let options = SheetOptions(
                pullBarHeight: 0
            )
            let sheetController = SheetViewController(
                controller: activityVC,
                sizes: [.fixed(600)],
            options: options)
            sheetController.cornerRadius = 25
            sheetController.dismissOnOverlayTap = false
            self.present(sheetController, animated: true, completion: nil)
            return
        }
    }
    
    func checkNotificationEnable() {
        let notification = UserDefaults.standard.bool(forKey: "enableNotification")
        if !notification {
            let notificationVC = storyboard?.instantiateViewController(withIdentifier: "RequestNotificationEnableVC") as! RequestNotificationEnableVC
            notificationVC.delegate = self

            let options = SheetOptions(
                pullBarHeight: 0
            )
            let sheetController = SheetViewController(
                controller: notificationVC,
                sizes: [.fixed(600)],
            options: options)
            sheetController.cornerRadius = 25
            sheetController.dismissOnOverlayTap = false
            self.present(sheetController, animated: true, completion: nil)
            return
        }
    }
    
    func checkOverdraftEnable() {
        let overdraft = UserDefaults.standard.bool(forKey: "enableOverdraft")
        if !overdraft {
            let overdraftVC = storyboard?.instantiateViewController(withIdentifier: "RequestOverdraftEnableVC") as! RequestOverdraftEnableVC
            overdraftVC.delegate = self

            let options = SheetOptions(
                pullBarHeight: 0
            )
            let sheetController = SheetViewController(
                controller: overdraftVC,
                sizes: [.fixed(600)],
            options: options)
            sheetController.cornerRadius = 25
            sheetController.dismissOnOverlayTap = false
            self.present(sheetController, animated: true, completion: nil)
            return
        }
    }
    
    func checkLoan() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.LOAN_CHECK, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            if let loan = dictionary["data"] as? [String:Any] {
                Shared.storeLoan(loan: loan)
                let storedLoan = Shared.getLoan()
                self.loanAmount = storedLoan.amount
                self.dueDate = storedLoan.dueDate
            }
                
            self.configure()
        }) { (error) in
            self.stopAnimating()
            self.loanAmount = 0
            self.configure()
        }
               
    }
    
    func requestLoan() {
        self.startAnimating()
                
        RequestHandler.getRequest(url:Constants.URL.LOAN_REQUEST, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let approvedVC = self.storyboard?.instantiateViewController(withIdentifier: "ApprovedVC") as! ApprovedVC
            self.navigationController?.pushViewController(approvedVC, animated: true)
        }) { (error) in
            self.stopAnimating()
                        
            let connectBankVC = self.storyboard?.instantiateViewController(withIdentifier: "ConnectBankVC") as! ConnectBankVC
            connectBankVC.delegate = self
            self.navigationController?.pushViewController(connectBankVC, animated: true)
        }
    }
    
    func withdrawMore() {
        let cashoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CashoutVC") as! CashoutVC
        self.navigationController?.pushViewController(cashoutVC, animated: true)
    }
}
