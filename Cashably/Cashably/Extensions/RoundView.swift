//
//  RoundView.swift
//  Cashably
//
//  Created by apollo on 6/21/22.
//

import Foundation
import UIKit

open class RoundView: UIView {
    
    private var radius: CGFloat = 10
    @IBInspectable public var _radius:CGFloat {
        get {
            return radius
        }
        set {
            radius = newValue
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        
        self.layer.cornerRadius = radius
        
        
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

