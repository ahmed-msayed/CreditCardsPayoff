//
//  SignupVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit

class SignupVC: UIViewController {
        
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
    
    func signUp(email: String, password: String) {
        self.showSpinner(onView: self.view)
        AuthenticationVM.signUp(email: email, password: password) { userId, error in
            self.removeSpinner()
            if error == nil, let userId = userId, let firstName = self.textFieldFirstName.text, let lastName = self.textFieldLastName.text {
                self.showSpinner(onView: self.view)
                AuthenticationVM.saveUserDataToDB(userId: userId, firstName: firstName, lastName: lastName, email: email) { userVM, error  in
                    self.removeSpinner()
                    if let userVM = userVM {
                        userVM.saveUserLocally()
                        self.saveDefaultCurrency()
                        self.goToHomeVC()
                    } else {
                        self.showAlert(message: error ?? "Unknown Error", type: false)
                    }
                }
            } else {
                self.showAlert(message: error ?? "Unknown Error" , type: false)
            }
        }
    }
    
    func saveDefaultCurrency() {
        let currency = Currency(country: "United States", currencyCode: "USD")
        let currencyVM = CurrencyVM(currency: currency)
        currencyVM.saveCurrencyLocally()
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func actionFacebook(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        if textFieldFirstName.text == "" || textFieldLastName.text == "" {
            self.showAlert(message: "Enter First Name & Last Name!", type: false)
            return
        }
        if !textFieldEmail.text!.isEmail {
            self.showAlert(message: "Invalid Email Address!", type: false)
            return
        }
        if !textFieldPassword.text!.isValidPassword {
            self.showAlert(message: "Password must be at least 6 characters!", type: false)
            return
        }
        if textFieldPassword.text != textFieldPassword2.text {
            self.showAlert(message: "Passwords don't match!", type: false)
            return
        }
        self.signUp(email: textFieldEmail.text!, password: textFieldPassword.text!)
    }
    
    @IBAction func actionTerms(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actionPrivacy(_ sender: Any) {
        print(#function)
    }
}
