//
//  CardCell.swift
//  Cashably
//
//  Created by apollo on 7/12/22.
//

import Foundation
import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var fullView: RoundView!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var lbCardNo: UILabel!
    @IBOutlet weak var lbCardHolder: UILabel!
    @IBAction func actionOption(_ sender: UIButton) {
        self.btnOptionAction?()
    }
    @IBAction func actionFull(_ sender: UIButton) {
        self.btnFullAction?()
    }
    
    var btnOptionAction: (()->())?
    var btnFullAction: (()->())?
}
