//
//  RoundView.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

open class RoundView: UIView {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.918, green: 0.922, blue: 0.937, alpha: 1).cgColor
        
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
