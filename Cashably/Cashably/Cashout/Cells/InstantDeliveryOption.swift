//
//  InstantDeliveryOption.swift
//  Cashably
//
//  Created by apollo on 3/16/23.
//

import Foundation
import UIKit

class InstantDeliveryOption: UIView {
    
    @IBOutlet weak var fullView: RoundBorderView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var lbDes: UILabel!
    
    let nibName = "InstantDeliveryOption"
    var contentView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func actionFull(_ sender: UIButton) {
        selectedView()
        self.btnFullAction?()
    }
    
    var btnFullAction: (()->())?
    
    func selectedView() {
//        self.fullView.layer.borderWidth = 2
        self.fullView.layer.borderColor = UIColor(red: 0.979, green: 0.692, blue: 0.335, alpha: 1).cgColor
//        self.logo.tintColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.logo.image = UIImage(named:"ic_surround_active")
        self.checkImg.image = UIImage(named:"ic_tick-1")
    }
    func unselectedView() {
//        self.fullView.layer.borderWidth = 0
        self.fullView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        self.logo.image = UIImage(named:"ic_surround_inactive")
        self.checkImg.image = UIImage(named:"ic_tick_circle")
    }
    
    func setFree() {
        lbPrice.text = "Free"
        lbDes.text = "Express Delivery"
        selectedView()
        self.btnFullAction?()
    }
    
}
