//
//  CashoutTipVC+extension.swift
//  Cashably
//
//  Created by apollo on 7/21/22.
//

import Foundation
import UIKit
import Alamofire

extension CashoutTipVC {
    func setupSliderView() {
        let width = sliderView.frame.width + 100
        let frame = CGRect(x: sliderView.center.x-width/2, y: sliderView.center.y - width/2 + 50, width: width, height: width)     // center in superview
        let slider = MSCircularSlider(frame: frame)
        slider.delegate = self
        
        slider.lineWidth = 15
        
        slider.minimumValue = 2
        slider.maximumValue = 14

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
        
        slider.currentValue = 8
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        sliderView.addSubview(slider)
        
        slider.centerXAnchor.constraint(equalTo: self.sliderView.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.sliderView.centerYAnchor).isActive = true
        
    }
    
    func cashout(uid: String, amount: Double, donate: Double, company: String = "") {
        self.startAnimating()
        if donate > amount {
            let alert = Alert.showBasicAlert(message: "Can't cashout becuase donate is greater than cashout amount.")
            self.presentVC(alert)
            return
        }
        AF.request("\(Constants.API)/withdraw",
                   method: .post,
                   parameters: ["userId": uid, "amount": "\(amount)", "donate": "\(donate)", "company": company],
                   encoder: URLEncodedFormParameterEncoder.default)
                
            .responseDecodable(of: WithdrawResponse.self) { response in
                    self.stopAnimating()
                switch response.result {
                case .success:
                    if response.value?.status == true {
                        self.dismiss(animated: true) {
                            if donate == 0 {
                                self.delegate?.cashout(data: response.value!.data, donate: false)
                            } else {
                                self.delegate?.cashout(data: response.value!.data, donate: true)
                            }
                        }
                    } else {
                        let alert = Alert.showBasicAlert(message: response.value!.message)
                        self.presentVC(alert)
                    }
                    break
                case let .failure(error):
                    print(error)
                    let alert = Alert.showBasicAlert(message: "Network error!")
                    self.presentVC(alert)
                    break
                }
            }
    }
}

extension CashoutTipVC: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        self.lbAmount.text = "$\(ceil(value))"
        self.donate = ceil(value)
        
        if value >= 2 && value < 4 {
            emoWorriedView.active()
            emoSmileView.inactive()
            emoLoveView.inactive()
            emoBlushView.inactive()
            emoHeartView.inactive()
        } else if value >= 4 && value < 8 {
            emoWorriedView.inactive()
            emoSmileView.active()
            emoLoveView.inactive()
            emoBlushView.inactive()
            emoHeartView.inactive()
        } else if value >= 8 && value < 10 {
            emoWorriedView.inactive()
            emoSmileView.inactive()
            emoLoveView.inactive()
            emoBlushView.active()
            emoHeartView.inactive()
        } else if value >= 10 && value < 12 {
            emoWorriedView.inactive()
            emoSmileView.inactive()
            emoLoveView.inactive()
            emoBlushView.inactive()
            emoHeartView.active()
        } else if value >= 12 {
            emoWorriedView.inactive()
            emoSmileView.inactive()
            emoLoveView.active()
            emoBlushView.inactive()
            emoHeartView.inactive()
        }
    }
}
