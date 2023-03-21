//
//  RequestPayView.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

class RequestPayView: UIView {
    
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var btnSnooze: UIButton!
    
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    @IBOutlet weak var lbAvailableAmount: UILabel!
    @IBOutlet weak var lbApprovedAmount: UILabel!
    
    @IBOutlet weak var payView: RoundBorderView!
    @IBOutlet weak var snoozeView: RoundBorderView!
    @IBOutlet weak var moreView: RoundBorderView!
    
    
    @IBAction func actionRequest(_ sender: UIButton) {
        self.onWithdrawMore?()
    }
    
    @IBAction func actionSnooze(_ sender: UIButton) {
        self.onSnooze?()
    }
    
    @IBAction func actionPay(_ sender: UIButton) {
        self.onPay?()
    }
    
    var onWithdrawMore: (() -> ())?
    var onSnooze: (() -> ())?
    var onPay: (() -> ())?
}
