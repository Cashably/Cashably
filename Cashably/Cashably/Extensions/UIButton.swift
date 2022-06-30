//
//  UIButton.swift
//  Cashably
//
//  Created by apollo on 6/29/22.
//

import Foundation
import UIKit

extension UIButton {
    
    public var customFont: Int {
        set {
            switch newValue {
            case 400:
                self.titleLabel?.font = UIFont(name: "BRFirma-Regular", size: (self.titleLabel?.font.pointSize)!)
                break
            case 500:
                self.titleLabel?.font = UIFont(name: "BRFirma-Medium", size: (self.titleLabel?.font.pointSize)!)
                break
            case 600:
                self.titleLabel?.font = UIFont(name: "BRFirma-SemiBold", size: (self.titleLabel?.font.pointSize)!)
                break
            case 700:
                self.titleLabel?.font = UIFont(name: "BRFirma-Bold", size: (self.titleLabel?.font.pointSize)!)
                break
            case 900, 800:
                self.titleLabel?.font = UIFont(name: "BRFirma-Black", size: (self.titleLabel?.font.pointSize)!)
                break
            default:
                self.titleLabel?.font = UIFont(name: "BRFirma-Regular", size: (self.titleLabel?.font.pointSize)!)
                break
            }
                
        }
        get {
            return 400
        }
    }
    
    @IBInspectable public var _customFont: Int {
        get {
            return customFont
        }
        set {
            customFont = newValue
        }
    }
    
}
