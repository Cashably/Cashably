//
//  SettingsVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import FirebaseAuth

class SettingsVC: UIViewController {
    
    
    
    private enum Settings: Int {
        case transactions
        case notification
        case cards
        case about
        case chat
        case logout
        case none
        
    }
    
    private var settings: [Settings] = [.transactions, .notification, .cards, .about, .chat, .logout, .none]
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
        tableView.register(UINib(nibName: "SettingsTableViewFooterCell", bundle: nil), forCellReuseIdentifier: "settingsFooter")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionEdit(_ sender: Any) {
        let profileEditVC = storyboard?.instantiateViewController(withIdentifier: "ProfileEditVC") as! ProfileEditVC
        navigationController?.pushViewController(profileEditVC, animated: true)
    }
    
    
}

extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.settings[indexPath.row] {
        case .transactions, .notification, .cards, .about, .chat:
            break
        case .logout:
            try! Auth.auth().signOut()
            let splashVC = storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
            navigationController?.pushViewController(splashVC, animated: true)
            break
        case .none:
            break
        }
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsTableViewCell
        switch indexPath.row {
        case 0:
            cell.imgIcon.image = UIImage(named: "ic_circle_dollar")
            cell.lbTitle.text = "Your Transaction"
            break
        case 1:
            cell.imgIcon.image = UIImage(named: "ic_color_notification")
            cell.lbTitle.text = "Manage Notification"
            break
        case 2:
            cell.imgIcon.image = UIImage(named: "ic_color_card")
            cell.lbTitle.text = "My Cards"
            break
        case 3:
            cell.imgIcon.image = UIImage(named: "ic_color_info")
            cell.lbTitle.text = "About Us"
            break
        case 4:
            cell.imgIcon.image = UIImage(named: "ic_color_msg")
            cell.lbTitle.text = "Chat With Us"
            break
        case 5:
            cell.imgIcon.image = UIImage(named: "ic_color_msg")
            cell.lbTitle.text = "Log out"
            break
        default:
            let footer: SettingsTableViewFooterCell = self.tableView.dequeueReusableCell(withIdentifier: "settingsFooter") as! SettingsTableViewFooterCell
            return footer
        }
        
        return cell
    }
}
