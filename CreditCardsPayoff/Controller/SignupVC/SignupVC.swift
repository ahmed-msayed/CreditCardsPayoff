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
        navigationControllerSetup()
        textFieldsPaddingSetup()
    }
    
    func saveUserData(userId: String) {
        if let firstName = textFieldFirstName.text, let lastName = textFieldLastName.text, let email = Auth.auth().currentUser?.email {
            self.showSpinner(onView: self.view)
            db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "email": email, "userId": userId]) { [weak self](error) in
                self?.removeSpinner()
                if let error = error?.localizedDescription {
                    self?.showAlert(message: error , type: false)
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
    
    func navigationControllerSetup() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.titleView = UIImageView(image: UIImage(systemName: "circles.hexagongrid.fill"))
    }
    
    func textFieldsPaddingSetup() {
        textFieldFirstName.setLeftPadding(value: 15)
        textFieldLastName.setLeftPadding(value: 15)
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
        textFieldPassword2.setLeftPadding(value: 15)
    }
    
    // MARK: - User actions
    
    @IBAction func actionFacebook(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            if textFieldFirstName.text != "", textFieldLastName.text != "" {
                if email.isEmail {
                    if password.isValidPassword {
                        if textFieldPassword.text == textFieldPassword2.text {
                            self.showSpinner(onView: self.view)
                            Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, err in
                                self?.removeSpinner()
                                if let error = err?.localizedDescription {
                                    self?.showAlert(message: error , type: false)
                                    self?.textFieldEmail.text = ""
                                    self?.textFieldPassword.text = ""
                                    self?.textFieldPassword2.text = ""
                                } else {
                                    if let userId = Auth.auth().currentUser?.uid {
                                        self?.saveUserData(userId: userId)
                                    }
                                }
                            }
                        } else {
                            self.showAlert(message: "Passwords don't match!", type: false)
                        }
                    } else {
                        self.showAlert(message: "Password must be at least 6 characters!", type: false)
                    }
                } else {
                    self.showAlert(message: "Invalid Email Address!", type: false)
                }
            } else {
                self.showAlert(message: "Enter First Name & Last Name!", type: false)
            }
        }
    }
    
    @IBAction func actionTerms(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionPrivacy(_ sender: Any) {
        print(#function)
    }
}
