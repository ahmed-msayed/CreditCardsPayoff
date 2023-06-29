//
//  SignupVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupVC: UIViewController {
    
    let db = Firestore.firestore()
    var userId = ""
    
    @IBOutlet var textFieldFirstName: UITextField!
    @IBOutlet var textFieldLastName: UITextField!
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var textFieldPassword2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.titleView = UIImageView(image: UIImage(systemName: "circles.hexagongrid.fill"))
        
        textFieldFirstName.setLeftPadding(value: 15)
        textFieldLastName.setLeftPadding(value: 15)
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
        textFieldPassword2.setLeftPadding(value: 15)
        
    }
    
    func saveUserData(userId: String) {
        if let firstName = textFieldFirstName.text, let lastName = textFieldLastName.text, let email = Auth.auth().currentUser?.email {
            db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "email": email, "userId": userId]) { [weak self](error) in
                if let error = error {
                    print(error)
                } else {
                    
                    UserDefaults.standard.setFirstName(value: firstName)
                    UserDefaults.standard.setLastName(value: lastName)
                    UserDefaults.standard.setUserID(value: userId)
                    UserDefaults.standard.setLoggedIn(value: true)
                    
                    self?.goToHomeVC()
                }
            }
        }
    }
    
    func goToHomeVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
    }
    
    // MARK: - User actions
    
    @IBAction func actionFacebook(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
                
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "error", message: "\(error.localizedDescription))", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    self?.textFieldEmail.text = ""
                    self?.textFieldPassword.text = ""
                    self?.textFieldPassword2.text = ""
                    
                } else {
                    
                    if let userId = Auth.auth().currentUser?.uid {
                        self?.saveUserData(userId: userId)
                    }
                }
            }
        }
        dismiss(animated: true)
    }
    
    @IBAction func actionTerms(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionPrivacy(_ sender: Any) {
        print(#function)
    }
}
