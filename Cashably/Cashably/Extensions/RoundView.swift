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
        self.layer.cornerRadius = 10
    }
}
