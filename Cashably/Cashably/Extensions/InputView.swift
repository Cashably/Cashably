//
//  InputView.swift
//  Cashably
//
//  Created by apollo on 6/18/22.
//

import Foundation
import UIKit

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var textfield: UITextField!
}

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
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 25
        self.layer.shadowOffset = CGSize(width: 0, height: 20)
        let shadows = UIView()
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)
        self.layer.shadowPath = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 10).cgPath

    }
    
    func didTap(target: Any) {
        let textfield = target as! UITextField
        let tap: CustomTapGestureRecognizer = CustomTapGestureRecognizer(
                    target: self,
                    action: #selector(focus(sender:)))
        tap.textfield = textfield
        //Add this tap gesture recognizer to the parent view
        self.addGestureRecognizer(tap)
    }
    
    @objc func focus(sender: CustomTapGestureRecognizer) {
        sender.textfield.becomeFirstResponder()
    }
}
