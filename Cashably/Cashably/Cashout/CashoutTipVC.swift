//
//  CashoutTipVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import iOSDropDown
import NVActivityIndicatorView
import Alamofire
import FirebaseAuth

protocol CashoutTipDelegate {
    func cashout(amount: Double)
    func cashoutWithTip(amount: Double)
}

class CashoutTipVC: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var btnCashoutWithTip: UIButton!
    @IBOutlet weak var btnCashout: UIButton!
    
    @IBOutlet weak var dropDown: DropDown! {
        didSet {
            dropDown.backgroundColor = .white
            dropDown.layer.borderColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1).cgColor
            dropDown.rowHeight = 55
            dropDown.arrowColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
        }
    }
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var emoWorriedView: EmoView!
    @IBOutlet weak var emoBlushView: EmoView!
    @IBOutlet weak var emoSmileView: EmoView!
    @IBOutlet weak var emoHeartView: EmoView!
    @IBOutlet weak var emoLoveView: EmoView!
    
    
    var delegate: CashoutTipDelegate!
    
    var rates = ["$2\n  |", "$4\n   |", "$6\n   |", "$8\n   |", "$10\n   |", "$12\n   |", "$14\n   |"]
    
    var donate: Double = 0
    var amount: Double = 0
    
    struct DecodableType: Decodable {
        let status: Bool
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupSliderView()
        
        dropDown.optionArray = ["Option 1", "Option 2", "Option 3"]
        dropDown.optionIds = [1,23,54,22]
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
   
    @IBAction func actionCashout(_ sender: UIButton) {
        
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        self.cashout(uid: user.uid, amount: self.amount, donate: 0)
    }
    
    @IBAction func actionCashoutWithTip(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        self.cashout(uid: user.uid, amount: self.amount, donate: self.donate)
    }
}


