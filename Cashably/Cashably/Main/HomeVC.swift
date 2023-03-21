//
//  HomeVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FittedSheets
import NVActivityIndicatorView

class HomeVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var userPhoto: UIImageView! {
        didSet {
            userPhoto.layer.cornerRadius = userPhoto.frame.size.width * 0.5
            userPhoto.clipsToBounds = true
        }
    }
    @IBOutlet weak var bottomView: UIView!
    
    var availabeAmount: Double = 0
    var mLoan: LoanModel?
    
    var emptyView: EmptyRequestPayView?
    var payView: RequestPayView?
    
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
        
        self.checkPermissions()
        loadPhoto()
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

        if emptyView != nil {
            emptyView?.isHidden = true
        }
        
        if payView != nil {
            payView?.isHidden = true
        }
   }
    
    private func loadPhoto() {
        let storage = Storage.storage(url: Constants.URL.PHOTO_STORAGE)
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let photoRef = storageRef.child("images/\(Shared.getUser().email!).jpg")
        
        photoRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            let image = UIImage(data: data!)
              self.userPhoto.image = image
          }
        }
    }
    
    private func checkPermissions() {
        self.checkFaceEnable()
        self.checkActivityEnable()
        self.checkNotificationEnable()
        self.checkOverdraftEnable()
        
    }
    
    func onRequest() {
        self.checkBank()
    }
    
    func onWithdrawMore() {
        self.withdrawMore()
    }
    
    func onPay() {
        if mLoan!.amount == 0 {
            self.showToast(message: "No received amount")
            return
        }
        let repayVC = self.storyboard?.instantiateViewController(withIdentifier: "RepayVC") as! RepayVC
        repayVC.loanAmount = mLoan!.amount
        self.navigationController?.pushViewController(repayVC, animated: true)
    }
    
    func onSnooze() {
        if mLoan!.amount == 0 {
            self.showToast(message: "No received amount")
            return
        }
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
    func updated() {
        
    }
    
    func connected() {
        requestLoan()
    }    
}
