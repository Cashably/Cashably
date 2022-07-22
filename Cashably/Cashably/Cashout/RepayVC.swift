//
//  RepayVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import FirebaseAuth
import Alamofire

class RepayVC: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var lbLoanAmount: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    @IBOutlet weak var lbRemainDays: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRepay: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var loanAmount: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lbLoanAmount.text = "$\(loanAmount)"
        
        let decoded  = UserDefaults.standard.object(forKey: "acceptedLoan") as! Data
        let decoder = JSONDecoder()
        let loan = try! decoder.decode(LoanResponse.self, from: decoded)
        
        lbLoanAmount.text = "$\(loan.amount)"
//        lbDueDate.text = loan.dueDate
        
        let dueTimestamp = loan.dueDateTimestamp
        let timestamp = Date().secondsSince1970
        let days: Int64 = (dueTimestamp - timestamp) / 3600 / 24
        lbRemainDays.text = "\(days) DAYS"
        
        let epochTime = TimeInterval(dueTimestamp)
        let date = Date(timeIntervalSince1970: epochTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        lbDueDate.text = dateFormatter.string(from: date)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LoanTableViewCell", bundle: nil), forCellReuseIdentifier: "loanCell")
        tableView.backgroundColor = .clear
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
   }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionRepay(_ sender: UIButton) {
        self.startAnimating()
        guard let user = Auth.auth().currentUser else {
            self.logout()
            return
        }
        AF.request("\(Constants.API)/repay",
                   method: .post,
                   parameters: ["userId": user.uid],
                   encoder: URLEncodedFormParameterEncoder.default)
                .responseDecodable(of: StatusResponse.self) { response in
                    self.stopAnimating()
                    
                    if response.value?.status == true {
                        self.showToast(message: "Repaid successfully.")
                        self.btnRepay.isEnabled = false
                    } else {
                        let alert = Alert.showBasicAlert(message: "Network error")
                        self.presentVC(alert)
                    }
                    
                }
    }
    
}

extension RepayVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RepayVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoanTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "loanCell") as! LoanTableViewCell
        cell.selectionStyle = .none
        let decoded  = UserDefaults.standard.object(forKey: "acceptedLoan") as! Data
        let decoder = JSONDecoder()
        let loan = try! decoder.decode(LoanResponse.self, from: decoded)
        cell.lbBankName.text = loan.to
//        cell.lbLoanId.text = Auth.auth().currentUser?.uid
        return cell
    }
}
