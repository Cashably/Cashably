//
//  MyTransactionsVC.swift
//  Cashably
//
//  Created by apollo on 7/11/22.
//

import Foundation
import UIKit
import FirebaseAuth
import Alamofire
import NVActivityIndicatorView

class MyTransactionsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var transactions: [TransactionResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "transactionCell")
        tableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        
        getTransactions()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func getTransactions() {
        self.startAnimating()
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        AF.request("\(Constants.API)/transactions",
                   method: .get,
                   parameters: ["userId": user.uid],
                   encoder: URLEncodedFormParameterEncoder.default)
            .responseDecodable(of: DataResponse.self) { response in
                self.stopAnimating()
                print(response)
                if response.value?.status == true {
                    self.transactions = response.value!.data
                    self.tableView.reloadData()
                }
                
            }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension MyTransactionsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyTransactionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionTableViewCell
        cell.selectionStyle = .none
        let transaction: TransactionResponse = self.transactions[indexPath.row]
        
        cell.lbDate.text = transaction.createdAt
        switch transaction.type {
        case "loan":
            cell.lbTitle.text = "From Cashably"
            cell.lbAmount.textColor = UIColor(red: 0, green: 0.775, blue: 0.171, alpha: 1)
            cell.lbAmount.text = "+$\(transaction.amount)"
            break
        case "repay":
            cell.lbTitle.text = "Sent to Cashably"
            cell.lbAmount.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            cell.lbAmount.text = "-$\(transaction.amount)"
            break
        case "donate":
            cell.lbTitle.text = "Sent to \(transaction.company)"
            cell.lbAmount.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            cell.lbAmount.text = "-$\(transaction.amount)"
            break
        case "snooze":
            cell.lbTitle.text = "Sent Snooze payment"
            cell.lbAmount.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            cell.lbAmount.text = "-$\(transaction.amount)"
            break
        default:
            break
        }
        
        return cell
    }
}
