//
//  HomeVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeVC: UIViewController {

    let db = Firestore.firestore()

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "\(user.firstName)" + " " +  "\(user.lastName)"
    }
    
    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
        UserVM.removeLocalUser()
        UserDefaults.standard.synchronize()
        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
    }
}
