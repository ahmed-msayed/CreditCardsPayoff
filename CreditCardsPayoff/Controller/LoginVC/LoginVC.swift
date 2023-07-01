//
//  LoginVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSubTitle: UILabel!
    @IBOutlet var imageViewLogo: UIImageView!
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var buttonHideShowPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationControllerSetup()
        textFieldsPaddingSetup()
        loadData()
    }
    
    func getUserData(userId: String) {
        self.showSpinner(onView: self.view)
        db.collection("users").whereField("userId", isEqualTo: userId)
            .getDocuments() { [weak self] (querySnapshot, err) in
                self?.removeSpinner()
                if let error = err?.localizedDescription {
                    self?.showAlert(message: error , type: false)
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String {
                            UserDefaults.standard.setFirstName(value: firstName)
                            UserDefaults.standard.setLastName(value: lastName)
                            UserDefaults.standard.setUserID(value: userId)
                            UserDefaults.standard.setLoggedIn(value: true)
                            self?.goToHomeVC()
                        }
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Data methods
    
    func loadData() {
        labelTitle.text = "Welcome to \nCredit Cards Payoff"
        labelSubTitle.text = "An exciting place to organize and payoff your credit cards"
    }
    
    func textFieldsPaddingSetup() {
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
        textFieldPassword.setRightPadding(value: 40)
    }
    
    // MARK: - User actions
    
    @IBAction func actionHideShowPassword(_ sender: Any) {
        buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
        textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            if textFieldEmail.text != "", textFieldEmail.text?.isEmail == true {
                if textFieldPassword.text != "" {
                    self.showSpinner(onView: self.view)
                    Auth.auth().signIn(withEmail: email, password: password) { [weak self]authResult, error in
                        self?.removeSpinner()
                        if let error = error?.localizedDescription {
                            self?.showAlert(message: error , type: false)
                            self?.textFieldEmail.text = ""
                            self?.textFieldPassword.text = ""
                        } else {
                            if let userId = Auth.auth().currentUser?.uid {
                                self?.getUserData(userId: userId)
                            }
                        }
                    }
                } else {
                    self.showAlert(message: "Enter Password!", type: false)
                }
            } else {
                self.showAlert(message: "Enter Valid Email Address!", type: false)
            }
        }
    }
    
    @IBAction func actionForgotPassword(_ sender: Any) {
        print(#function)
        dismiss(animated: true)
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        let signupVC : SignupVC = SignupVC(nibName :"SignupVC",bundle : nil)
        self.navigationController?.pushViewController(signupVC, animated: true)
        dismiss(animated: true)
    }
}
