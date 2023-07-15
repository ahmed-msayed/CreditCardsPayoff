//
//  LoginVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit

class LoginVC: UIViewController {
        
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
        labelSubTitle.text = "A simple way to organize and payoff your credit cards"
    }
    
    func textFieldsPaddingSetup() {
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
        textFieldPassword.setRightPadding(value: 40)
    }
    
    func login(email: String, password: String) {
        self.showSpinner(onView: self.view)
        AuthenticationVM.login(email: email, password: password) { userId, error in
            self.removeSpinner()
            if let userId = userId {
                self.showSpinner(onView: self.view)
                AuthenticationVM.getUserDataFromDB(userId: userId) { userVM, error in
                    self.removeSpinner()
                    if let userVM = userVM {
                        userVM.saveUserLocally()
                        self.goToHomeVC()
                    } else {
                        self.showAlert(message: error ?? "Unknown Error", type: false)
                    }
                }
            } else {
                self.showAlert(message: error ?? "Unknown Error", type: false)
            }
        }
    }
    
    // MARK: - User actions
    
    @IBAction func actionHideShowPassword(_ sender: Any) {
        buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
        textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        if textFieldEmail.text == "" || !textFieldEmail.text!.isEmail {
            self.showAlert(message: "Enter Valid Email Address!", type: false)
            return
        }
        if textFieldPassword.text == "" {
            self.showAlert(message: "Enter Password!", type: false)
            return
        }
        self.login(email: textFieldEmail.text!, password: textFieldPassword.text!)
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
