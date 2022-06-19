//
//  TopCornerRoundView.swift
//  Cashably
//
//  Created by apollo on 6/18/22.
//

import Foundation
import UIKit

open class TopCornderRoundView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        configure()
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
        self.backgroundColor = .white
        
        self.dropShadow()
        self.round()

    }
    
    
}
