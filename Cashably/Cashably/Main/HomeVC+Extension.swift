//
//  HomeVC+Extension.swift
//  Cashably
//
//  Created by apollo on 7/21/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FittedSheets
import Alamofire

extension HomeVC {
    
    func configure() {
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
    
    func checkFaceEnable() {
        let face = UserDefaults.standard.bool(forKey: "enableFaceID")
        if !face {
            let faceVC = storyboard?.instantiateViewController(withIdentifier: "RequestFaceEnableVC") as! RequestFaceEnableVC
            faceVC.delegate = self
//            faceVC.isModalInPresentation = true
//            let nav = UINavigationController(rootViewController: faceVC)
//            nav.modalTransitionStyle = .coverVertical
//            if let sheet = nav.sheetPresentationController {
//                sheet.detents = [.medium()]
//                sheet.preferredCornerRadius = 25
//            }
//            self.presentVC(nav)
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
//            activityVC.isModalInPresentation = true
//            let nav = UINavigationController(rootViewController: activityVC)
//            nav.modalTransitionStyle = .coverVertical
//            if let sheet = nav.sheetPresentationController {
//                sheet.detents = [.medium(), .large()]
//                sheet.preferredCornerRadius = 25
//            }
//            self.presentVC(nav)
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
//            notificationVC.isModalInPresentation = true
//            let nav = UINavigationController(rootViewController: notificationVC)
//            nav.modalTransitionStyle = .coverVertical
//            if let sheet = nav.sheetPresentationController {
//                sheet.detents = [.medium(), .large()]
//                sheet.preferredCornerRadius = 25
//            }
//            self.presentVC(nav)
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
//            overdraftVC.isModalInPresentation = true
//            let nav = UINavigationController(rootViewController: overdraftVC)
//            nav.modalTransitionStyle = .coverVertical
//            if let sheet = nav.sheetPresentationController {
//                sheet.detents = [.medium(), .large()]
//                sheet.preferredCornerRadius = 25
//            }
//            self.presentVC(nav)
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
    
    func checkBankConnect() {
        self.startAnimating()
        AF.request("\(Constants.API)/user/check_connect_bank",
                   method: .get,
                   parameters: ["userId": Auth.auth().currentUser?.uid],
                   encoder: URLEncodedFormParameterEncoder.default)
                .responseDecodable(of: DecodableType.self) { response in
                    self.stopAnimating()
                    
                    if response.value?.status == true {
                        let approvedVC = self.storyboard?.instantiateViewController(withIdentifier: "ApprovedVC") as! ApprovedVC
                        self.navigationController?.pushViewController(approvedVC, animated: true)
                    } else {
                        let connectBankVC = self.storyboard?.instantiateViewController(withIdentifier: "ConnectBankVC") as! ConnectBankVC
                        connectBankVC.delegate = self
                        self.navigationController?.pushViewController(connectBankVC, animated: true)
                    }
                    
                }
            
    }
}
