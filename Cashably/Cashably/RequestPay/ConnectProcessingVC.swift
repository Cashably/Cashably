//
//  ConnectProcessingVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

protocol ConnectProcessingDelegate {
    func connected()
}

class ConnectProcessingVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    
    var delegate: ConnectProcessingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fakeTimer()
    }
    
    private func fakeTimer() {
        var runCount = 0

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            runCount += 1

            if runCount == 3 {
                timer.invalidate()
                UserDefaults.standard.set("1234", forKey: "connectedBankId")
                self.delegate.connected()
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
