//
//  CreditVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit

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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
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
