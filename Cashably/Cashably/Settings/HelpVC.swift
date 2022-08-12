//
//  HelpVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class HelpVC: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var sendView: UIView!
    
    @IBOutlet weak var msgView: InputView!
    @IBOutlet weak var tfMsg: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        msgView.didTap(target: tfMsg)
        
        let sendGesture = UITapGestureRecognizer(target: self, action: #selector(self.sendAction(_:)))
        sendView.addGestureRecognizer(sendGesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @objc func sendAction(_ sender:UITapGestureRecognizer){
        self.onSend()
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
        self.navigationController?.popViewController(animated: true)
    }
    
}
