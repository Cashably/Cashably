//
//  ConnectBankVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol ConnectBankDelegate {
    func connected()
}

class ConnectBankVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConnect: UIButton!
    
    var delegate: ConnectBankDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionConnect(_ sender: UIButton) {
        let processingVC = storyboard?.instantiateViewController(withIdentifier: "ConnectProcessingVC") as! ConnectProcessingVC
        processingVC.delegate = self
        self.navigationController?.pushViewController(processingVC, animated: true)
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ConnectBankVC: ConnectProcessingDelegate {
    func connected() {
        self.delegate.connected()
    }
}
