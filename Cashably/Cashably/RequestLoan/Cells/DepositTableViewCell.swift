//
//  DepositTableViewCell.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

class DepositTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var btnPaycheck: UIButton!
    
    @IBAction func actionPaycheck(_ sender: UIButton) {
    }
    
}
