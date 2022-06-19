//
//  UIView.swift
//  Cashably
//
//  Created by apollo on 6/18/22.
//

import Foundation
import UIKit

extension UIView {
    
    func round() {
        self.layer.cornerRadius = 25
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat = 15) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func dropShadow(color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07), opacity: Float = 1, offSet: CGSize=CGSize(width: 0, height: -20), radius: CGFloat = 25, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
