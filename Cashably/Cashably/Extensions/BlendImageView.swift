//
//  BlendImageView.swift
//  Cashably
//
//  Created by apollo on 6/30/22.
//

import Foundation
import UIKit

@IBDesignable
open class BlendImageView:UIImageView {
    
    @IBInspectable open var color:UIColor? {
        didSet {
            if self.image != nil {
                self.image = self.image?.image(withTint: color!, blendAlpha: alpha, blendMode: .luminosity)
            }
        }
    }
    
    @IBInspectable open var blendAlpha:CGFloat = 1 {
        didSet {
            if self.image != nil && self.color != nil {
                self.image = self.image?.image(withTint: color!, blendAlpha: alpha, blendMode: .luminosity)
            }
        }
    }
    
//    open override func draw(_ rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//        context?.saveGState()
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: CGFloat(bounds.width * 0.5), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
//        context?.addPath(circlePath.cgPath)
//        context?.setBlendMode(CGBlendMode.luminosity)
//        context?.setFillColor(UIColor.lightGray.cgColor)
//        context?.restoreGState()
//    }
}
