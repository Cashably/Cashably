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
        
        if self.mLoan == nil {
            if emptyView == nil {
                addEmptyView()
            } else {
                emptyView?.isHidden = false
            }
        } else {
            if payView == nil {
                addPayView()
            } else {
                payView?.isHidden = false
            }
            
            payView!.lbAmount.text = "$\(mLoan!.amount ?? 0)"
            payView!.lbDueDate.text = mLoan!.dueDate
            payView!.lbApprovedAmount.text = "of $\(mLoan!.approved!)"
            availabeAmount = mLoan!.approved - mLoan!.amount
            if availabeAmount == 0 {
                payView!.moreView.isHidden = true
            } else {
                payView!.moreView.isHidden = false
            }
            payView!.lbAvailableAmount.text = "$\(availabeAmount)"
        }
    }
    
    func addPayView() {
        payView = Bundle.main.loadNibNamed("RequestPayView", owner: self, options: nil)?[0] as? RequestPayView
        payView!.onWithdrawMore = {() in self.onWithdrawMore()}
        payView!.onPay = {() in self.onPay()}
        payView!.onSnooze = {() in self.onSnooze()}
        let payGesture = UITapGestureRecognizer(target: self, action: #selector(self.payAction(_:)))
        let snoozeGesture = UITapGestureRecognizer(target: self, action: #selector(self.snoozeAction(_:)))
        payView!.payView.addGestureRecognizer(payGesture)
        payView!.snoozeView.addGestureRecognizer(snoozeGesture)
        self.bottomView.addSubview(payView!)
        payView!.translatesAutoresizingMaskIntoConstraints = false
        payView!.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor).isActive = true
        payView!.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor).isActive = true
        payView!.widthAnchor.constraint(equalTo: self.bottomView.widthAnchor).isActive = true
        payView!.heightAnchor.constraint(equalTo: self.bottomView.heightAnchor).isActive = true
    }
    
    func addEmptyView() {
        emptyView = Bundle.main.loadNibNamed("EmptyRequestPayView", owner: self, options: nil)?[0] as? EmptyRequestPayView
        self.emptyView!.onRequest = {() in self.onRequest()}
        self.bottomView.addSubview(self.emptyView!)
        self.emptyView!.translatesAutoresizingMaskIntoConstraints = false
        self.emptyView!.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor).isActive = true
        self.emptyView!.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor).isActive = true
        self.emptyView!.widthAnchor.constraint(equalTo: self.bottomView.widthAnchor).isActive = true
        self.emptyView!.heightAnchor.constraint(equalTo: self.bottomView.heightAnchor).isActive = true
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
                
                self.mLoan = LoanModel(fromDictionary: loan)
            }
                
            self.configure()
        }) { (error) in
            self.stopAnimating()
            self.mLoan = nil
            self.configure()
            
        }
               
    }
    
    func checkBank() {
        self.startAnimating()
        
        RequestHandler.getRequest(url:Constants.URL.BANK_CHECK, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            
            self.requestLoan()
        }) { (error) in
            self.stopAnimating()
            
            if error.status == Constants.NetworkError.generic {
                let connectBankVC = self.storyboard?.instantiateViewController(withIdentifier: "ConnectBankVC") as! ConnectBankVC
                connectBankVC.delegate = self
                self.navigationController?.pushViewController(connectBankVC, animated: true)
            } else {
                let alert = Alert.showBasicAlert(message: error.message)
                self.presentVC(alert)
            }
            
        }
    }
    
    func requestLoan() {
        self.startAnimating()
        
        RequestHandler.getRequest(url:Constants.URL.LOAN_REQUEST, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let approvedVC = self.storyboard?.instantiateViewController(withIdentifier: "ApprovedVC") as! ApprovedVC
            self.navigationController?.pushViewController(approvedVC, animated: true)
            let dictionary = successResponse as! [String: Any]
            if let amount = dictionary["approved"] as? Double {
                approvedVC.approved = amount
            }
            
        }) { (error) in
            self.stopAnimating()
            
            if error.status == Constants.NetworkError.generic {
                let notapprovedVC = self.storyboard?.instantiateViewController(withIdentifier: "NotApprovedVC") as! NotApprovedVC
                notapprovedVC.message = error.message
//                notapprovedVC.modalTransitionStyle = .coverVertical
                notapprovedVC.modalPresentationStyle = .overFullScreen
                self.presentVC(notapprovedVC)
            } else {
                let alert = Alert.showBasicAlert(message: error.message)
                self.presentVC(alert)
            }
            
        }
    }
    
    func withdrawMore() {
        let cashoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CashoutVC") as! CashoutVC
        if availabeAmount > 0 {
            cashoutVC.limitValue = availabeAmount
        }
        
        self.navigationController?.pushViewController(cashoutVC, animated: true)
    }
}
