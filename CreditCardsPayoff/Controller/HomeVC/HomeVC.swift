//
//  HomeVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell

        return cell
    }
    
//    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
//        UserVM.removeLocalUser()
//        UserDefaults.standard.synchronize()
//        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
//    }
}
