//
//  CashoutVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

class CashoutVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
        @IBOutlet weak var btnInfo: UIButton!
        @IBOutlet weak var btnWithdraw: UIButton!
        
        @IBOutlet weak var lbAmount: UILabel!
        
        @IBOutlet weak var selectView: UIView!
        @IBOutlet weak var sliderView: UIView!
        
        private var rates = ["$0", "$10", "$20", "$30", "$40", "$50", "$60", "$70", "$80", "$90", "$100"]
        
        private var rateLabels: [UILabel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
    //        setupRateLabels()
            setupSliderView()
    //        setupSliderView1()
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.isNavigationBarHidden = true
       }

        override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.isNavigationBarHidden = false
       }
        
        private func setupSliderView1() {
            let frame = CGRect(x: sliderView.center.x-sliderView.frame.width/2, y: sliderView.center.y - sliderView.frame.height, width: sliderView.frame.width, height: sliderView.frame.width)
            let slider = CircularSlider(frame: frame)
            // setup target to watch for value change
            slider.addTarget(self, action: #selector(valueChanged(_:)), for: UIControl.Event.valueChanged)
            
            // setup slider defaults
            slider.handleType = .bigCircle
            slider.currentValue = 10
            slider.lineWidth = 15
            slider.maximumAngle = 110
            slider.backgroundColor = UIColor(red: 0.107, green: 0.696, blue: 0.51, alpha: 1)
            slider.transform = slider.getRotationalTransform()
            // add to view
            sliderView.addSubview(slider)
        }
        
        @objc func valueChanged(_ slider: CircularSlider) {
            lbAmount.text = "$\(slider.currentValue)"
        }
        
        private func setupSliderView() {
            let width = 720.0 // sliderView.bounds.width
            let frame = CGRect(x: sliderView.center.x-width/2, y: sliderView.center.y - width/2, width: width, height: width)     // center in superview
            let slider = MSCircularSlider(frame: frame)
            slider.delegate = self
            
            slider.lineWidth = 15
            
            slider.minimumValue = 0
            slider.maximumValue = 100
//            slider.maximumAngle = 140
            slider.spaceDegree = 110
    //        slider.minimumAngle = 0
            slider.filledColor = .white// UIColor(red: 0.214, green: 0.767, blue: 0.592, alpha: 1)
            slider.unfilledColor = .blue // UIColor(red: 0.214, green: 0.767, blue: 0.592, alpha: 1)
            slider.backgroundColor = UIColor(red: 0.107, green: 0.696, blue: 0.51, alpha: 1)

            slider.handleImage = UIImage(named: "ic_pointer")
            slider.handleRotatable = true
            slider.handleEnlargementPoints = 30
            
            slider.labels = self.rates
            slider.labelColor = .white
            slider.snapToLabels = true
            slider.labelOffset = 80
            
            slider.sliderPadding = 100
            
            slider.isSliding = false
            
            
            slider.currentValue = 10
            
            slider.translatesAutoresizingMaskIntoConstraints = false
            
            sliderView.addSubview(slider)
            
            slider.centerXAnchor.constraint(equalTo: self.sliderView.centerXAnchor).isActive = true
            slider.centerYAnchor.constraint(equalTo: self.sliderView.centerYAnchor).isActive = true
    //        slider.widthAnchor.constraint(equalTo: self.sliderView.widthAnchor).isActive = true
    //        slider.heightAnchor.constraint(equalTo: self.sliderView.heightAnchor).isActive = true
        }
        
        private func setupRateLabels() {
            let n = rates.count
            let contentLength = 4 * Double.pi
            let ang = contentLength / Double(n)
            let view = UIView()
            for i in 0..<n {
                let p = PolarCoordinatedView(radius: 100, angle: ang * Double(i), frame: CGRect(x: 0, y: 0, width: 40, height: 30))
                let ratio = CGFloat(Double(i) / Double(n))
                p.backgroundColor = .clear
                let label = UILabel()
                label.text = self.rates[i]
                label.sizeToFit()
                label.textColor = .white
                label.center = p.center
                self.rateLabels.append(label)
                p.addSubview(label)
                view.addSubview(p)
            }
            self.selectView.addSubview(view)
        }
        
        private func withdraw() {
            let successVC = storyboard?.instantiateViewController(withIdentifier: "CashoutSuccessVC") as! CashoutSuccessVC
            self.navigationController?.pushViewController(successVC, animated: true)
        }
        
        
        @IBAction func actionWithdraw(_ sender: UIButton) {
            let tipVC = storyboard?.instantiateViewController(withIdentifier: "CashoutTipVC") as! CashoutTipVC
    //        tipVC.isModalInPresentation = true
            tipVC.delegate = self
            let nav = UINavigationController(rootViewController: tipVC)
            nav.modalTransitionStyle = .coverVertical
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.preferredCornerRadius = 25
            }
            self.presentVC(nav)
            
        }
        
        @IBAction func actionInfo(_ sender: UIButton) {
        }
        
        @IBAction func actionBack(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    extension CashoutVC: CashoutTipDelegate {
        func cashout() {
            guard let cardId = UserDefaults.standard.string(forKey: "cardid") else {
                let addcardVC = storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
                addcardVC.delegate = self
                self.navigationController?.pushViewController(addcardVC, animated: true)
                return
            }
            
            self.withdraw()
        }
        
        func cashoutWithTip() {
            guard let cardId = UserDefaults.standard.string(forKey: "cardid") else {
                let addcardVC = storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
                addcardVC.delegate = self
                self.navigationController?.pushViewController(addcardVC, animated: true)
                return
            }
            
            self.withdraw()
        }
        
        
    }

    extension CashoutVC: AddCardDelegate {
        func addCard() {
            self.withdraw()
        }
    }

    extension CashoutVC: MSCircularSliderDelegate {
        func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
            self.lbAmount.text = "$\(ceil(value))"
        }
        
}
