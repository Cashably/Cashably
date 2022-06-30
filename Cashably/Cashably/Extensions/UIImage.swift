//
//  UIImage.swift
//  Cashably
//
//  Created by apollo on 6/30/22.
//

import Foundation
import UIKit

extension UIImage {
    
    open func image(withTint color:UIColor, blendAlpha alpha:CGFloat, blendMode mode:CGBlendMode) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let bounds = CGRect(origin: .zero, size: size)
//        UIRectFill(bounds)
        let context = UIGraphicsGetCurrentContext()
        
//        UIGraphicsPushContext(context!)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: CGFloat(bounds.width * 0.5), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        context?.addPath(circlePath.cgPath)
        draw(in: bounds, blendMode: mode, alpha: alpha)
        
        let tinted = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsPopContext()
        
        UIGraphicsEndImageContext()
        return tinted!
    }
    
    func resizeImage(_ scaleFactor: CGFloat) -> UIImage {

        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
   }
    
}
