//
//  CardsVC.swift
//  Cashably
//
//  Created by apollo on 7/11/22.
//

import Foundation
import UIKit
import FittedSheets
import UIButtonExtension

class CardsVC: UIViewController {
    
    @IBOutlet weak var radio1: UIRadioButton! {
        didSet {
            radio1.configure()
            radio1.rightText("Net Banking")
            
        }
    }
    @IBOutlet weak var radio2: UIRadioButton! {
        didSet {
            radio2.configure()
            radio2.rightText("Credit Card")
        }
    }
    @IBOutlet weak var radio3: UIRadioButton! {
        didSet {
            radio3.configure()
            radio3.rightText("Debit Card")
        }
    }
    @IBOutlet weak var radio4: UIRadioButton! {
        didSet {
            radio4.configure()
            radio4.rightText("UPI")
        }
    }
       
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        radio1.relate(otherUIRadioButtons: [radio2, radio3, radio4])
        radio1.button.addTarget(self, action: #selector(selectRadio1(_:)), for: .touchUpInside)
        radio2.button.addTarget(self, action: #selector(selectRadio2(_:)), for: .touchUpInside)
        radio3.button.addTarget(self, action: #selector(selectRadio3(_:)), for: .touchUpInside)
        radio4.button.addTarget(self, action: #selector(selectRadio4(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @objc func selectRadio1(_ sender: UIRadioButton? = nil) {
        
    }
    @objc func selectRadio2(_ sender: UIRadioButton? = nil) {
        
    }
    @objc func selectRadio3(_ sender: UIRadioButton? = nil) {
        
    }
    @objc func selectRadio4(_ sender: UIRadioButton? = nil) {
        
    }
    
    @IBAction func actionAdd(_ sender: UIButton) {
        let saveVC = storyboard?.instantiateViewController(withIdentifier: "SaveCardVC") as! SaveCardVC
        saveVC.delegate = self
        let options = SheetOptions(
            pullBarHeight: 0
        )
        let sheetController = SheetViewController(
            controller: saveVC,
            sizes: [.fixed(450)],
        options: options)
        sheetController.cornerRadius = 30
        sheetController.dismissOnOverlayTap = true
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionPay(_ sender: UIButton) {
    }
}

extension CardsVC: SaveCardDelegate{
    func addCard() {
        
    }
}
