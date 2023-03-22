//
//  LoanTableViewCell.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

class LoanTableViewCell: UITableViewCell {
    @IBOutlet weak var lbBankName: UILabel!
    @IBOutlet weak var lbLoanAmount: UILabel!
    @IBOutlet weak var lbTips: UILabel!
    @IBOutlet weak var lbSnoozePay: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    @IBOutlet weak var lbInstantFee: UILabel!
    @IBOutlet weak var lbLoanId: UILabel!
}
