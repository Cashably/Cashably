//
//  InputView.swift
//  Cashably
//
//  Created by apollo on 6/18/22.
//

import Foundation
import UIKit

open class InputView: UIView {
    
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
        self.backgroundColor = .clear
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1).cgColor
        self.layer.cornerRadius = 10

    }
    
    
}
