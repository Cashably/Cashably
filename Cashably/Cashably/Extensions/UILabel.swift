//
//  UILabel.swift
//  Cashably
//
//  Created by apollo on 6/29/22.
//

import Foundation
import UIKit

extension UILabel {
    
    public var customFont: Int {
        set {
            switch newValue {
            case 400:
                self.font = UIFont(name: "BRFirma-Regular", size: self.font.pointSize)
                break
            case 500:
                self.font = UIFont(name: "BRFirma-Medium", size: self.font.pointSize)
                break
            case 600:
                self.font = UIFont(name: "BRFirma-SemiBold", size: self.font.pointSize)
                break
            case 700:
                self.font = UIFont(name: "BRFirma-Bold", size: self.font.pointSize)
                break
            case 900, 800:
                self.font = UIFont(name: "BRFirma-Black", size: self.font.pointSize)
                break
            default:
                self.font = UIFont(name: "BRFirma-Regular", size: self.font.pointSize)
                break
            }
                
        }
        get {
            self.font = UIFont(name: "BRFirma-Regular", size: self.font.pointSize)
            return 400
        }
    }
    public var lineHeight: Float {
        set {
//            lineHeight = newValue
//            self.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
            
        }
        get {
            return lineHeight
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
    
    @IBInspectable public var _lineHeight: Float {
        get {
            return lineHeight
        }
        set {
            lineHeight = newValue
        }
    }
}
