//
//  CashoutTipVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import iOSDropDown
import NVActivityIndicatorView

protocol CashoutTipDelegate {
    func cashout(amount: Double, donate: Double, company: String)
}

class CashoutTipVC: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var btnCashoutWithTip: UIButton!
    @IBOutlet weak var btnCashout: UIButton!
    
    @IBOutlet weak var dropDown: DropDown! {
        didSet {
            dropDown.backgroundColor = .white
            dropDown.textColor = .black
            dropDown.layer.borderColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1).cgColor
            dropDown.rowHeight = 55
            dropDown.arrowColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
        }
    }
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var emoWorriedView: EmoView!
    @IBOutlet weak var emoBlushView: EmoView!
    @IBOutlet weak var emoSmileView: EmoView!
    @IBOutlet weak var emoHeartView: EmoView!
    @IBOutlet weak var emoLoveView: EmoView!
    
    
    var delegate: CashoutTipDelegate!
    
    var rates = ["$2\n  |", "$4\n   |", "$6\n   |", "$8\n   |", "$10\n   |", "$12\n   |", "$14\n   |"]
    
    var donate: Double = 0
    var amount: Double = 0
    var company = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupSliderView()
        
        dropDown.didSelect{(selectedText , index ,id) in
            self.company = selectedText
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
        getCharities()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func getCharities() {
        self.startAnimating()
        RequestHandler.getRequest(url:Constants.URL.GET_CHARITIES, parameter: [:], success: { (successResponse) in
            self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            if let data = dictionary["data"] as? [[String: Any]] {
                for obj in data {
                    let charity = CharityModel(fromDictionary: obj)
                    self.dropDown.optionArray.append(charity.name)
                    self.dropDown.optionIds?.append(charity.id)
                    self.dropDown.optionImageArray.append(charity.logo)
                }
            }
            
        }) { (error) in
            self.stopAnimating()
                        
//            let alert = Alert.showBasicAlert(message: error.message)
//            self.presentVC(alert)
        }
        
    }
   
    @IBAction func actionCashout(_ sender: UIButton) {
        self.dismissVC(completion: nil)
        self.delegate?.cashout(amount: self.amount, donate: 0, company: "")
    }
    
    @IBAction func actionCashoutWithTip(_ sender: UIButton) {
        self.dismissVC(completion: nil)
        self.delegate?.cashout(amount: self.amount, donate: self.donate, company: company)
    }
}


