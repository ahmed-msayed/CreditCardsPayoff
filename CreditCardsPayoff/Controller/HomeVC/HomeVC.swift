//
//  HomeVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    var welcomeLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.welcomeLabel.text = "\(UserDefaults.standard.getFirstName())" + " " +  "\(UserDefaults.standard.getLastName())"
            

    }
    
    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
        UserDefaults.standard.resetUserDefaults()
        
        welcomeLabel.text = "\(UserDefaults.standard.getFirstName())" + " " +  "\(UserDefaults.standard.getLastName())"
    }
    

}
