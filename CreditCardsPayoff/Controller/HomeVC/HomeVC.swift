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
        if let userId = Auth.auth().currentUser?.uid {
            getUserData(userId: userId)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "\(user.firstName)"+" "+"\(user.lastName)"+" "+"\(user.email)"
    }
    
    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
        UserVM.removeLocalUser()
        UserDefaults.standard.synchronize()
        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
    }
    
    func getUserData(userId: String) {
        self.showSpinner(onView: self.view)
        db.collection("users").whereField("userId", isEqualTo: userId)
            .getDocuments() { [weak self] (response, error) in
                self?.removeSpinner()
                if let error = error?.localizedDescription {
                    self?.showAlert(message: error , type: false)
                } else {
                    guard let document = response!.documents.first else { return }
                    let data = document.data()
                    let user: User? = data.getObject()
                    guard let user = user else { return }
                    let userVM = UserVM(user: user)
                    userVM.saveUserLocally()
                }
            }
    }
}
