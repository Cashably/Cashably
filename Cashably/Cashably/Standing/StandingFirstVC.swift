//
//  StandingFirstVC.swift
//  Cashably
//
//  Created by apollo on 7/12/22.
//

import Foundation
import UIKit

class StandingFirstVC: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTitle()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func configureTitle() {
        let attributedString = lbTitle.attributedText!.string
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        let attributedQuote = NSMutableAttributedString(string: attributedString, attributes: [NSAttributedString.Key.font: UIFont(name: "BRFirma-Regular", size: 30)!])
        attributedQuote.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedQuote.length))
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "BRFirma-Bold", size: 30)!]
        attributedQuote.setAttributes(attributes, range: NSRange(location: 8, length: 9))
        attributedQuote.setAttributes(attributes, range: NSRange(location: 21, length: 9))
        lbTitle.attributedText = attributedQuote
        
    }
    
        
    @IBAction func actionContinue(_ sender: UIButton) {
        let standingVC = self.storyboard?.instantiateViewController(withIdentifier: "StandingSecondVC") as! StandingSecondVC
        self.navigationController?.pushViewController(standingVC, animated: true)
    }
    
    @IBAction func actionSkip(_ sender: UIButton) {
        let standingVC = self.storyboard?.instantiateViewController(withIdentifier: "StandingSecondVC") as! StandingSecondVC
        self.navigationController?.pushViewController(standingVC, animated: true)
    }
}
