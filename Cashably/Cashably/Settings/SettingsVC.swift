//
//  SettingsVC.swift
//  Cashably
//
//  Created by apollo on 6/19/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import NVActivityIndicatorView
import JGProgressHUD

class SettingsVC: UIViewController, NVActivityIndicatorViewable {
    
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
    @IBOutlet weak var userPhoto: UIImageView! {
        didSet {
            let photoGesture = UITapGestureRecognizer(target: self, action: #selector(self.openPhoto(_:)))
            userPhoto.addGestureRecognizer(photoGesture)
            userPhoto.isUserInteractionEnabled = true
            
            userPhoto.layer.cornerRadius = userPhoto.frame.size.width * 0.5
            userPhoto.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var photo: UIImage?
    
    var imagePicker = UIImagePickerController()
    var imageUrl: URL?
    
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .light)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lbEmail.text = Shared.getUser().email
        lbName.text = Shared.getUser().fullName
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
        tableView.register(UINib(nibName: "SettingsTableViewFooterCell", bundle: nil), forCellReuseIdentifier: "settingsFooter")
        tableView.backgroundColor = .white
        
        loadPhoto()
        
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
    
    private func loadPhoto() {
        let storage = Storage.storage(url: Constants.URL.PHOTO_STORAGE)
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let photoRef = storageRef.child("images/\(Shared.getUser().email!).jpg")
        
        photoRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            let image = UIImage(data: data!)
              self.userPhoto.image = image
          }
        }
    }
    
    @objc func openPhoto(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Upload photo", message: nil, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (actionIn) in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Photo gallery", style: .default) { (actionIn) in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (actionIn) in
            self.dismissVC(completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.presentVC(alert)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            
            self.presentVC(imagePicker)
        }
        else {
            let alert = Alert.showBasicAlert(message: "Camera is not available")
            self.presentVC(alert)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.presentVC(imagePicker)
        }
       
    }
    
    func showLogoutAlert() {
        let alert = Alert.showConfirmAlert(message: "Are you sure logout?") { _ in
            self.logout()
        }
        self.presentVC(alert)
    }
    
    func uploadImage() {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0%"
        uploadingProgressBar.show(in: self.view)
        
        let storage = Storage.storage(url: Constants.URL.PHOTO_STORAGE)
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let photoRef = storageRef.child("images/\(Shared.getUser().email!).jpg")

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        let uploadTask = photoRef.putData(self.photo!.jpegData(compressionQuality: 0.1)!, metadata: metadata) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
//        photoRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
        }
//        let uploadTask = photoRef.putFile(from: self.imageUrl!, metadata: metadata)
        uploadTask.observe(.progress) { snapshot in
          // A progress event occured
            let percentComplete = Double(snapshot.progress!.completedUnitCount)
            self.uploadingProgressBar.detailTextLabel.text = "\(percentComplete)%"
            self.uploadingProgressBar.setProgress(Float(percentComplete) / 100, animated: true)
        }
        
        uploadTask.observe(.success) { snapshot in
          // Upload completed successfully
            self.userPhoto.image = self.photo
            self.uploadingProgressBar.dismiss()
        }
        uploadTask.observe(.failure) { snapshot in
            self.uploadingProgressBar.dismiss()
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                  // File doesn't exist
                    print("File not exist")
                  break
                case .unauthorized:
                  // User doesn't have permission to access file
                    print("access file")
                  break
                case .cancelled:
                  // User canceled the upload
                    print("cancelled")
                  break

                case .unknown:
                  // Unknown error occurred, inspect the server response
                    print("unknown error")
                  break
                default:
                  // A separate error occurred. This is a good place to retry the upload.
                    print("default error")
                  break
                }
              }
        }
        
//        NetworkHandler.upload(url: Constants.URL.UPLOAD_USER_PHOTO, fileData: self.photo!.jpegData(compressionQuality: 0.1)!, fileName: "data", params: nil, uploadProgress: { (uploadProgress) in
//            print(uploadProgress)
//            let currentProgress = Float(uploadProgress)/100
//            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)%"
//            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
//            if uploadProgress == 100 {
//                self.uploadingProgressBar.dismiss()
//            }
//        }, success: { (successResponse) in
//            self.userPhoto.image = self.photo
//            self.uploadingProgressBar.dismiss()
//
//        }) { (error) in
//
//            self.uploadingProgressBar.dismiss()
//            let alert = Alert.showBasicAlert(message: error.message)
//            self.presentVC(alert)
//        }
    }
    
    @IBAction func actionEdit(_ sender: Any) {
        let profileEditVC = storyboard?.instantiateViewController(withIdentifier: "ProfileEditVC") as! ProfileEditVC
        navigationController?.pushViewController(profileEditVC, animated: true)
    }
    
}

extension SettingsVC: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismissVC(completion: nil)
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            
            let imageName = imageURL.lastPathComponent
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
            print(path)
            self.imageUrl = path
        }
        if let pickedImage = info[.originalImage] as? UIImage {
            self.photo = pickedImage
            self.uploadImage()
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismissVC(completion: nil)
    }
}

extension SettingsVC: UINavigationControllerDelegate {
    
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
