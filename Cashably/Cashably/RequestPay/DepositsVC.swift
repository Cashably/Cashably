//
//  ReviewDepositsVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit

class DepositsVC: UIViewController {
    
    public var connectedBankId: String = ""
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNewDeposit: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DepositTableViewCell", bundle: nil), forCellReuseIdentifier: "depositCell")
        tableView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionNewDeposit(_ sender: UIButton) {
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DepositsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let paycheckDetailVC = storyboard?.instantiateViewController(withIdentifier: "PaycheckDetailVC") as! PaycheckDetailVC
        navigationController?.pushViewController(paycheckDetailVC, animated: true)
    }
}

extension DepositsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DepositTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "depositCell") as! DepositTableViewCell
        cell.selectionStyle = .none
        cell.lbTitle.text = "Airbnb 4977"
        cell.lbDueDate.text = "On Tuesday of every week"
        cell.lbAmount.text = "$ 299.54"
        
        
        return cell
    }
}
