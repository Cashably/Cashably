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
    }
}
