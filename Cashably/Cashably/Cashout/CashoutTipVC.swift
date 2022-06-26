//
//  CashoutTipVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol CashoutTipDelegate {
    func cashout()
    func cashoutWithTip()
}

class CashoutTipVC: UIViewController {
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var btnCashoutWithTip: UIButton!
    @IBOutlet weak var btnCashout: UIButton!
    
    @IBOutlet weak var sliderView: UIView!
    
    var delegate: CashoutTipDelegate!
    
    private var rates = ["$2", "$4", "$6", "$8", "$10", "$12", "$14"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSliderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    private func setupSliderView() {
        let width = sliderView.frame.width + 100
        let frame = CGRect(x: sliderView.center.x-width/2, y: sliderView.center.y - width/2 + 50, width: width, height: width)     // center in superview
        let slider = MSCircularSlider(frame: frame)
        slider.delegate = self
        
        slider.lineWidth = 15
        
        slider.minimumValue = 0
        slider.maximumValue = 14
//        slider.maximumAngle = 100
//        slider.minimumAngle = 0

        slider.filledColor =  UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
        slider.unfilledColor =  UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
//        slider.backgroundColor = UIColor(red: 0.107, green: 0.696, blue: 0.51, alpha: 1)

        slider.handleImage = UIImage(named: "ic_pointer")
        slider.handleRotatable = true
        slider.handleEnlargementPoints = 30
        
        slider.labels = self.rates
        slider.labelColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
//        slider.snapToLabels = true
        slider.labelOffset = 100
        
        slider.sliderPadding = 80
        
        slider.isSliding = false
        
        slider.spaceDegree = 140
        slider.spaceUnFilledDegree = 110
        slider.clockwise = true
        
        slider.currentValue = 10
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        sliderView.addSubview(slider)
        
        slider.centerXAnchor.constraint(equalTo: self.sliderView.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.sliderView.centerYAnchor).isActive = true
//        slider.widthAnchor.constraint(equalTo: self.sliderView.widthAnchor).isActive = true
//        slider.heightAnchor.constraint(equalTo: self.sliderView.heightAnchor).isActive = true
    }
    
   
    @IBAction func actionCashout(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.cashout()
        }
    }
    
    @IBAction func actionCashoutWithTip(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            self.delegate?.cashoutWithTip()
        }
    }
}

extension CashoutTipVC: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        self.lbAmount.text = "$\(ceil(value))"
    }
}
