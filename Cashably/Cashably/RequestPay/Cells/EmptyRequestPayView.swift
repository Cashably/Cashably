//
//  EmptyRequestPayView.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

class EmptyRequestPayView: UIView {
    
    @IBOutlet weak var btnRequest: UIButton!
    
    @IBAction func actionRequest(_ sender: UIButton) {
        self.onRequest?()
    }
    var onRequest: (() -> ())?
}
