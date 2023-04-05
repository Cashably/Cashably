//
//  CashoutTipVC+extension.swift
//  Cashably
//
//  Created by apollo on 7/21/22.
//

import Foundation
import UIKit

extension CashoutTipVC {
    func setupSliderView() {
        let width = sliderView.frame.width + 100
        let frame = CGRect(x: sliderView.center.x-width/2, y: sliderView.center.y - width/2 + 50, width: width, height: width)     // center in superview
        let slider = MSCircularSlider(frame: frame)
        slider.delegate = self
        
        slider.lineWidth = 15
        
        slider.maximumValue = self.limitValue
        
        if self.limitValue > 10 {
            slider.minimumValue = 8
            self.rates = [String]()
            let n = 5
            for i in 0..<n {
                let term = Int(self.limitValue) / 4 * i
                if term < 10 {
                    self.rates.append("$\(term)\n  |")
                }
                else { self.rates.append("$\(term)\n    |") }
            }
            self.rates[4] = "$\(Int(self.limitValue))\n    |"
        } else if self.limitValue <= 10 {
            slider.minimumValue = 1
            self.rates = [String]()
            let n = Int(self.limitValue) + 1
            print(floor(self.limitValue))
            for i in 1..<n {
                self.rates.append("$\(i)\n  |")
            }
        }

        slider.filledColor =  UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
        slider.unfilledColor =  .white

        slider.handleImage = UIImage(named: "ic_pointer")
        slider.handleRotatable = true
        slider.handleEnlargementPoints = 30
        
        slider.labels = self.rates
        slider.labelColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
//        slider.snapToLabels = true
        slider.labelFont = .systemFont(ofSize: 20.0)
        slider.labelOffset = 100
        
        slider.sliderPadding = 80
        
        slider.isSliding = false
        
        slider.spaceDegree = 140
        slider.spaceUnFilledDegree = 110
        slider.clockwise = true
        
        slider.enableOuterLine = true
        
        slider.currentValue = 1
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        sliderView.addSubview(slider)
        
        slider.centerXAnchor.constraint(equalTo: self.sliderView.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.sliderView.centerYAnchor).isActive = true
        
    }
}

extension CashoutTipVC: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        self.lbAmount.text = "$\(ceil(value))"
        self.donate = ceil(value)
        let percent = value / self.limitValue
        
        if percent < 0.2 {
            emoWorriedView.active()
            emoSmileView.inactive()
            emoLoveView.inactive()
            emoBlushView.inactive()
            emoHeartView.inactive()
        } else if percent >= 0.2 && percent < 0.4 {
            emoWorriedView.inactive()
            emoSmileView.active()
            emoLoveView.inactive()
            emoBlushView.inactive()
            emoHeartView.inactive()
        } else if percent >= 0.4 && percent < 0.6 {
            emoWorriedView.inactive()
            emoSmileView.inactive()
            emoLoveView.inactive()
            emoBlushView.active()
            emoHeartView.inactive()
        } else if percent >= 0.6 && percent < 0.8 {
            emoWorriedView.inactive()
            emoSmileView.inactive()
            emoLoveView.inactive()
            emoBlushView.inactive()
            emoHeartView.active()
        } else if percent >= 0.8 {
            emoWorriedView.inactive()
            emoSmileView.inactive()
            emoLoveView.active()
            emoBlushView.inactive()
            emoHeartView.inactive()
        }
    }
}
