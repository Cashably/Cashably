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
    
    var loanAmount: Double = 0
    var dueDate: String = ""
    var availabeAmount: Double = 0
    
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
   }
    
    private func loadPhoto() {
        let storage = Storage.storage(url:"gs://cashably.appspot.com")
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
        self.requestLoan()
    }
    
    func onWithdrawMore() {
        self.withdrawMore()
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
