//
//  PaySnoozeVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import MKRingProgressView

class PaySnoozeVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var anaView: UIView! {
        didSet {
            anaView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var lbAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.drawChat()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func drawChat() {
        let ringProgressView = RingProgressView(frame: CGRect(x: 0, y: 0, width: 164, height: 164))
        ringProgressView.startColor = .white
        ringProgressView.endColor = .white
        ringProgressView.ringWidth = 25
        ringProgressView.progress = 0.9
        ringProgressView.translatesAutoresizingMaskIntoConstraints = false
        self.chatView.addSubview(ringProgressView)
        ringProgressView.centerXAnchor.constraint(equalTo: self.chatView.centerXAnchor).isActive = true
        ringProgressView.centerYAnchor.constraint(equalTo: self.chatView.centerYAnchor).isActive = true
        ringProgressView.widthAnchor.constraint(equalTo: self.chatView.widthAnchor).isActive = true
        ringProgressView.heightAnchor.constraint(equalTo: self.chatView.heightAnchor).isActive = true
        
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
