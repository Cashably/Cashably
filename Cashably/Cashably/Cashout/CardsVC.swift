//
//  CardsVC.swift
//  Cashably
//
//  Created by apollo on 7/11/22.
//

import Foundation
import UIKit
import FittedSheets
import MBRadioButton

class CardsVC: UIViewController {
    
    @IBOutlet weak var radio1: RadioButton!
    @IBOutlet weak var radio2: RadioButton!
    @IBOutlet weak var radio3: RadioButton!
    @IBOutlet weak var radio4: RadioButton!
    
    var groupContainer = RadioButtonContainer()
    
    @IBOutlet weak var cardsCollectionView: UICollectionView! {
        didSet {
            cardsCollectionView.delegate = self
            cardsCollectionView.dataSource = self
            cardsCollectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
            cardsCollectionView.register(UINib(nibName: "EmptyCardCell", bundle: nil), forCellWithReuseIdentifier: "EmptyCardCell")
            cardsCollectionView.backgroundColor = .white
            cardsCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radio1.configure()
        radio2.configure()
        radio3.configure()
        radio4.configure()
        
        groupContainer.addButtons([radio1, radio2, radio3, radio4])
        groupContainer.selectedButton = radio1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
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
    
    func showCardOption() {
        let saveVC = self.storyboard?.instantiateViewController(withIdentifier: "CardActionVC") as! CardActionVC
//                saveVC.delegate = self
        let options = SheetOptions(
            pullBarHeight: 0
        )
        let sheetController = SheetViewController(
            controller: saveVC,
            sizes: [.fixed(150)],
        options: options)
        sheetController.cornerRadius = 30
        sheetController.dismissOnOverlayTap = true
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func showAddCard() {
        let saveVC = self.storyboard?.instantiateViewController(withIdentifier: "SaveCardVC") as! SaveCardVC
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
}

extension CardsVC: SaveCardDelegate{
    func addCard() {
        
    }
}

extension CardsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UserDefaults.standard.string(forKey: "cardid") != nil {
            return 3
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if UserDefaults.standard.string(forKey: "cardid") != nil {
            let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
                    
            cell.btnFullAction = { () in
                cell.fullView.layer.borderWidth = 2
                cell.fullView.layer.borderColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1).cgColor
            }
            cell.btnOptionAction = { () in
                self.showCardOption()
            }
            return cell
        } else {
            let cell: EmptyCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCardCell", for: indexPath) as! EmptyCardCell
                    
            cell.btnFullAction = { () in
                self.showAddCard()
            }
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.layer.bounds.width-40, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if UserDefaults.standard.string(forKey: "cardid") != nil {
            return UIEdgeInsets.zero
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
}
