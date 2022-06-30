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
                emo.image?.withRenderingMode(.alwaysTemplate)
            }
        }
        
    }
    
    func active() {
        backgroundColor = .white
//        emo.image = UIImage(named: "emo_\(name)")
//        emo.tintColor = .yellow
        emo.isHighlighted = true
    }
    
    func inactive() {
        backgroundColor = .clear
//        emo.image = UIImage(named: "emo_\(name)_inactive")
//        emo.tintColor = .gray
        emo.isHighlighted = false
    }
}
