//
//  ToggleButton.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

open class ToggleButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    open override func updateConfiguration() {
        guard let configuration = configuration else {
                return
            }
        var updatedConfiguration = configuration
        var foregroundColor: UIColor
        var backgroundColor: UIColor
        switch self.state {
        case .normal:
            backgroundColor = .white
            foregroundColor = UIColor(red: 0.388, green: 0.384, blue: 0.384, alpha: 1)
            break
        case [.highlighted]:
            backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
            foregroundColor = .white
            break
        case .selected, .focused, .highlighted:
            backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
            foregroundColor = .white
            break
        default:
            backgroundColor = .white
            foregroundColor = UIColor(red: 0.388, green: 0.384, blue: 0.384, alpha: 1)
        }
//        var background = UIButton.Configuration.plain().background
//        background.backgroundColorTransformer = UIConfigurationColorTransformer { color in
//
//                return backgroundColor
//            }
        
        updatedConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in

                var container = incoming
                container.foregroundColor = foregroundColor
                
                return container
            }
        
//        updatedConfiguration.background = background
            
            self.configuration = updatedConfiguration
    }
    
    func configure() {
        self.layer.cornerRadius = 10
    }
}
