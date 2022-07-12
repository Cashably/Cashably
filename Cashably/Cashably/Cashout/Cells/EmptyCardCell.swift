//
//  EmptyCardCell.swift
//  Cashably
//
//  Created by apollo on 7/12/22.
//

import Foundation
import UIKit

class EmptyCardCell: UICollectionViewCell {
    @IBAction func actionFull(_ sender: UIButton) {
        self.btnFullAction?()
    }
    
    var btnFullAction: (()->())?
}
