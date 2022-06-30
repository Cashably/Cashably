//
//  EmoView.swift
//  Cashably
//
//  Created by apollo on 6/28/22.
//

import Foundation
import UIKit

open class EmoView: UIView {
    private var emo: UIImageView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        backgroundColor = .clear
        self.layer.cornerRadius = self.frame.width * 0.5
        
        for subview in self.subviews {
            if let item = subview as? UIImageView {
                emo = item
//                emo.isHidden = true
//                var view = UILabel()
//                view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//                view.backgroundColor = .white
//                view.layer.compositingFilter = "luminosityBlendMode"
//                let layer0 = CALayer()
//                layer0.contents = item.image?.cgImage
//                layer0.bounds = view.bounds
//                layer0.position = view.center
//                view.layer.addSublayer(layer0)
//
//                var parent = self
//
//                parent.addSubview(view)
//
//                view.translatesAutoresizingMaskIntoConstraints = false
//
////                view.widthAnchor.constraint(equalToConstant: 20).isActive = true
////
////                view.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//                view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: 0).isActive = true
//
//                view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: 0).isActive = true


            }
        }
        
    }
    
    func active(_ name: String) {
        backgroundColor = .white
        emo.image = UIImage(named: "emo_\(name)")
    }
    
    func inactive(_ name: String) {
        backgroundColor = .clear
        emo.image = UIImage(named: "emo_\(name)_inactive")
    }
}
