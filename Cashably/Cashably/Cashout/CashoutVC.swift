//
//  CashoutVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import FittedSheets

class CashoutVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnWithdraw: UIButton!
    
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var sliderView: UIView!
    
    private var rates = ["$0\n  |", "$25\n    |", "$50\n    |", "$75\n    |", "$100\n     |"]
    
    private var rateLabels: [UILabel] = []
    
    private var amount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setupRateLabels()
        setupSliderView()
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
    
    @objc func valueChanged(_ slider: CircularSlider) {
        lbAmount.text = "$\(slider.currentValue)"
    }
    
    private func setupSliderView() {
        
        let width = sliderView.frame.width + 100
        let frame = CGRect(x: sliderView.center.x-width/2, y: sliderView.center.y - sliderView.bounds.height / 2, width: width, height: width)     // center in superview
        let slider = MSCircularSlider(frame: frame)
        slider.delegate = self
        
        slider.lineWidth = 15
        
        slider.minimumValue = 0
        slider.maximumValue = 100

        slider.filledColor =  UIColor(red: 0.107, green: 0.696, blue: 0.51, alpha: 1)
        slider.unfilledColor =  UIColor(red: 0.214, green: 0.767, blue: 0.592, alpha: 1)

        slider.handleImage = UIImage(named: "ic_pointer")
        slider.handleRotatable = true
        slider.handleEnlargementPoints = 30
        slider.handleHighlightable = true
        slider.handleType = .largeCircle
        
        slider.labels = self.rates
        slider.labelColor = .white
//        slider.snapToLabels = true
        slider.labelFont = .systemFont(ofSize: 20.0)
        slider.labelOffset = 100
        
        slider.sliderPadding = 80
        
        slider.spaceDegree = 140
        slider.spaceUnFilledDegree = 110
        slider.clockwise = true
        
        slider.currentValue = 10
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        sliderView.addSubview(slider)
        
        slider.centerXAnchor.constraint(equalTo: self.sliderView.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.sliderView.centerYAnchor).isActive = true
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
    
    @IBAction func actionWithdraw(_ sender: UIButton) {
        if amount == 0 {
            let alert = Alert.showBasicAlert(message: "Please select amount")
            self.presentVC(alert)
            return
        }
        
        let tipVC = storyboard?.instantiateViewController(withIdentifier: "CashoutTipVC") as! CashoutTipVC
        tipVC.amount = self.amount
        tipVC.delegate = self
        
        let sheetController = SheetViewController(
            controller: tipVC,
            sizes: [.fixed(700)])
        sheetController.cornerRadius = 25
        sheetController.shouldRecognizePanGestureWithUIControls = false
        self.present(sheetController, animated: true, completion: nil)
    }
    
    @IBAction func actionInfo(_ sender: UIButton) {
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CashoutVC: CashoutTipDelegate {
    func cashout(data: WithdraW, donate: Bool) {
        if donate == true {
            let donationvc = storyboard?.instantiateViewController(withIdentifier: "DonationThanksVC") as! DonationThanksVC
            donationvc.withdrawData = data
            self.navigationController?.pushViewController(donationvc, animated: true)
        } else {
            let nodonationvc = storyboard?.instantiateViewController(withIdentifier: "NoDonationVC") as! NoDonationVC
            nodonationvc.withdrawData = data
            self.navigationController?.pushViewController(nodonationvc, animated: true)
        }
    }
    
}

extension CashoutVC: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        self.lbAmount.text = "$\((Int)(ceil(value)))"
        self.amount = ceil(value)
    }
}
