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
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
    func moveUp(value: Double) {
        let delta = -value
        UIView.animate(withDuration: 0.5, delay: 0.0, options:[], animations: {
            self.transform = CGAffineTransform(translationX: 0, y: delta)
        }, completion: nil)
    }


    func moveDown(value: Double) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options:[], animations: {
//            let screenSize = UIScreen.main.bounds.size
            self.transform = CGAffineTransform(translationX: 0, y: value)
        }, completion: nil)
    }
    
    func moveLeft(value: Double) {
        let delta = -value
        UIView.animate(withDuration: 0.5, delay: 0.0, options:[], animations: {
            self.transform = CGAffineTransform(translationX: delta, y: 0)
        }, completion: nil)
    }
    
    func moveRight(value: Double) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options:[], animations: {
            self.transform = CGAffineTransform(translationX: value, y: 0)
        }, completion: nil)
    }
    
}
