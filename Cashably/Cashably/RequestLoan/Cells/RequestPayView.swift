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
    
    @IBOutlet weak var payView: RoundView!
    @IBOutlet weak var snoozeView: RoundView!
    
    
    @IBAction func actionRequest(_ sender: UIButton) {
        self.onRequest?()
    }
    
    @IBAction func actionSnooze(_ sender: UIButton) {
        self.onSnooze?()
    }
    
    @IBAction func actionPay(_ sender: UIButton) {
        self.onPay?()
    }
    
    var onRequest: (() -> ())?
    var onSnooze: (() -> ())?
    var onPay: (() -> ())?
}
