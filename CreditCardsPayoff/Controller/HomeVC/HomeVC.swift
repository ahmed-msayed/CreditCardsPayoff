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
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "\(user.firstName)" + " " +  "\(user.lastName)"
    }
    
    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
        UserVM.removeLocalUser()
        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
    }
}
