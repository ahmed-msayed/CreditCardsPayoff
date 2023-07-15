//
//  HomeVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "\(user.firstName)"+" "+"\(user.lastName)"+" "+"\(user.email)"
    }
    
    func getUserData() {
        let userId = AuthenticationVM.getCurrentUserId()
        AuthenticationVM.getUserDataFromDB(userId: userId) { userVM, error in
            if let userVM = userVM {
                userVM.saveUserLocally()
            } else {
                self.showAlert(message: error ?? "Unknown Error", type: false)
            }
        }
    }
    
    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
        UserVM.removeLocalUser()
        UserDefaults.standard.synchronize()
        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
    }
}
