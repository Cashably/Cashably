//
//  RadioButton.swift
//  Cashably
//
//  Created by apollo on 7/12/22.
//

import Foundation
import UIButtonExtension
import UIKit

extension UIRadioButton {
        
    public func configure() {
        self.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)           //changes the color of the outer circle to red.
        self.selectedColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1) //changes the color of the inner circle to green
        self.borderWidth = 1        //changes the width of the outer circle to 5
        self.cornerRadius = 10      //changes the cornerRadius of the button to 20. (no longer a circle)
        self.selectedSize = 0.5     // changes the ratio of the inner circle size to the outer circle, only available from 0 to 1
        self.font = UIFont(name: "BRFirma-Medium", size: 15)
        self.fontSize = 15
        self.textColor = UIColor(red: 0.151, green: 0.127, blue: 0.2, alpha: 1)
    }
}
