//
//  CreditVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import MKRingProgressView

class CreditVC: UIViewController {
    
    @IBOutlet weak var scoreChatView: UIView!
    
    @IBOutlet weak var weekIcon: UIImageView!
    @IBOutlet weak var lbWeekScore: UILabel!
    
    @IBOutlet weak var monthIcon: UIImageView!
    @IBOutlet weak var lbMonthScore: UILabel!
    
    @IBOutlet weak var breakdownChatView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MerchantTableViewCell", bundle: nil), forCellReuseIdentifier: "mercantCell")
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = 80
        
        self.drawChat()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func drawChat() {
        let ringProgressView = RingProgressView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        ringProgressView.startColor = UIColor(red: 0.886, green: 0.314, blue: 0.31, alpha: 1)
        ringProgressView.endColor = UIColor(red: 0.291, green: 0.896, blue: 0.078, alpha: 1)
        ringProgressView.ringWidth = 15
        ringProgressView.progress = 0.9
        ringProgressView.translatesAutoresizingMaskIntoConstraints = false
        self.scoreChatView.addSubview(ringProgressView)
        ringProgressView.centerXAnchor.constraint(equalTo: self.scoreChatView.centerXAnchor).isActive = true
        ringProgressView.centerYAnchor.constraint(equalTo: self.scoreChatView.centerYAnchor).isActive = true
        ringProgressView.widthAnchor.constraint(equalTo: self.scoreChatView.widthAnchor).isActive = true
        ringProgressView.heightAnchor.constraint(equalTo: self.scoreChatView.heightAnchor).isActive = true
        
    }
}

extension CreditVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CreditVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MerchantTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "mercantCell") as! MerchantTableViewCell
        
        return cell
    }
}
