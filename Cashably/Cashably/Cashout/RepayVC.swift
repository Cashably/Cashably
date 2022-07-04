//
//  RepayVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class RepayVC: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var lbLoanAmount: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    @IBOutlet weak var lbRemainDays: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRepay: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        return cell
    }
}
