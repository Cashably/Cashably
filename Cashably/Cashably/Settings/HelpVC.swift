//
//  HelpVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Intercom

class HelpVC: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var sendView: UIView!
    
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var tfMsg: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        msgView.didTap(target: tfMsg)
        
        let sendGesture = UITapGestureRecognizer(target: self, action: #selector(self.sendAction(_:)))
        sendView.addGestureRecognizer(sendGesture)
        
        loginIntercom()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func loginIntercom() {
        let attributes = ICMUserAttributes()
        attributes.email = Shared.getUser().email
//        Intercom.loginUser(with: attributes) { result in
//            switch result {
//            case .success:
//                // Handle success
//                break
//            case .failure(let error):
//                // Handle error
//                break
//            }
//        }
//        Intercom.loginUnidentifiedUser { result in
//                switch result {
//                case .success:
//                    // Handle success
//                case .failure(let error):
//                    // Handle error
//                }
//            }
        Intercom.setLauncherVisible(true)
        Intercom.registerUser(withEmail: Shared.getUser().email)
        
    }
    
    @objc func sendAction(_ sender:UITapGestureRecognizer){
//        self.onSend()
        Intercom.presentMessenger()
//        Intercom.presentHelpCenter()
    }
    
    func onSend() {
        self.startAnimating()
        
        let params = [
            "message": tfMsg.text!
        ]
                
        RequestHandler.postRequest(url:Constants.URL.SEND_MESSAGE, parameter: params as! NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            self.showToast(message: "Sent successfully")
            self.tfMsg.text = ""
        }) { (error) in
            self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
            
        }
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        Intercom.logout()
        self.navigationController?.popViewController(animated: true)
    }
    
}
