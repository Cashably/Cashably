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
        
        lbEmail.text = Auth.auth().currentUser?.email
        lbName.text = Auth.auth().currentUser?.displayName
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
        tableView.register(UINib(nibName: "SettingsTableViewFooterCell", bundle: nil), forCellReuseIdentifier: "settingsFooter")
        tableView.backgroundColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("seting staus bar prefered")
        return .default
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
    
    func showLogoutAlert() {
        let alert = Alert.showConfirmAlert(message: "Are you sure logout?") { _ in
            self.logout()
        }
        self.presentVC(alert)
    }
    
    @IBAction func actionEdit(_ sender: Any) {
        let profileEditVC = storyboard?.instantiateViewController(withIdentifier: "ProfileEditVC") as! ProfileEditVC
        navigationController?.pushViewController(profileEditVC, animated: true)
    }
    
    
}

extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.settings[indexPath.row] {
        case .about:
            break
        case .cards:
            let cardsVC = storyboard?.instantiateViewController(withIdentifier: "CardsVC") as! CardsVC
            navigationController?.pushViewController(cardsVC, animated: true)
            break
        case .notification:
            let notificationsVC = storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
            navigationController?.pushViewController(notificationsVC, animated: true)
            break
        case .transactions:
            let txnVC = storyboard?.instantiateViewController(withIdentifier: "MyTransactionsVC") as! MyTransactionsVC
            navigationController?.pushViewController(txnVC, animated: true)
            break
        case .chat:
            let helpVC = storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
            navigationController?.pushViewController(helpVC, animated: true)
            break
        case .logout:
            self.showLogoutAlert()
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
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.imgIcon.image = UIImage(named: "ic_circle_dollar")
            cell.lbTitle.text = "My Transactions"
            cell.logoView.backgroundColor = UIColor(red: 0.133, green: 0.736, blue: 0.816, alpha: 0.1)
            break
        case 1:
            cell.imgIcon.image = UIImage(named: "ic_color_notification")
            cell.lbTitle.text = "Manage Notification"
            cell.logoView.backgroundColor = UIColor(red: 0.067, green: 0.733, blue: 0.412, alpha: 0.1)
            break
        case 2:
            cell.imgIcon.image = UIImage(named: "ic_bank")
            cell.lbTitle.text = "Connected Accounts"
            cell.logoView.backgroundColor = UIColor(red: 0.969, green: 0.576, blue: 0.102, alpha: 0.1)
            break
        case 3:
            cell.imgIcon.image = UIImage(named: "ic_color_info")
            cell.lbTitle.text = "About Us"
            cell.logoView.backgroundColor = UIColor(red: 0.933, green: 0.292, blue: 0.74, alpha: 0.1)
            break
        case 4:
            cell.imgIcon.image = UIImage(named: "ic_color_msg")
            cell.lbTitle.text = "Chat With Us"
            cell.logoView.backgroundColor = UIColor(red: 0.314, green: 0.227, blue: 0.749, alpha: 0.1)
            break
        case 5:
            cell.imgIcon.image = UIImage(named: "ic_color_msg")
            cell.lbTitle.text = "Log out"
            break
        default:
            let footer: SettingsTableViewFooterCell = self.tableView.dequeueReusableCell(withIdentifier: "settingsFooter") as! SettingsTableViewFooterCell
            footer.lbVersion.text = Bundle.main.fullVersion
            return footer
        }
        
        return cell
    }
}
