//
//  RoundBorderView.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

@IBDesignable class RoundBorderView: UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var radius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            layer.cornerRadius
        }
    }
    
    @IBInspectable var enableShadow: Bool {
        set {
            if newValue {
                shadow()
            }
        }
        get {
            return false
        }
    }
    
    
    private func shadow() {
        
        let shadows = UIView()
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)
        self.layer.shadowPath = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 15).cgPath
        self.layer.shadowColor = UIColor(red: 0.075, green: 0.306, blue: 0.251, alpha: 0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 110
        self.layer.shadowOffset = CGSize(width: 30, height: 50)
        self.layer.bounds = shadows.bounds
    }
    
}
