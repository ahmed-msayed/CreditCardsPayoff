//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 10/07/2023.
//

import UIKit

class ChangePasswordVC: UIViewController,UITextFieldDelegate {

    var textPlaceholder = ""

    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        navBarLayout()
    }
    
    func navBarLayout() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(named: "purple-dark")
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textPlaceholder = textField.placeholder ?? ""
//        textField.placeholder = ""
//        textField.textAlignment = Locale.current.languageCode == "en" ? NSTextAlignment.left : NSTextAlignment.right
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text == "" {
//        textField.placeholder = textPlaceholder
//        textField.textAlignment = Locale.current.languageCode == "en" ? NSTextAlignment.left : NSTextAlignment.right
//        }
    }
    
    @IBAction func savePasswordButtonTapped(_ sender: UIButton) {
//        guard let newPassword = newPasswordTextField.text else {return}
//        if newPassword.isValidPassword {
//            if newPasswordTextField.text == repeatPasswordTextField.text {
//                self.showSpinner(onView: self.view)
//                ProfileVM.changePassword(password: currentPasswordTextField.text!, newPassword: newPasswordTextField.text!) {success,error in
//                    self.removeSpinner()
//                    if success {
//                        self.showAlert(message: "Password changed successfully", type: true)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            self.navigationController?.popToRootViewController(animated: true)
//                        }
//                    } else {
//                        self.showAlert(message: error ?? "Unknown Error", type: false)
//                    }
//                }
//            } else {
//                self.showAlert(message: "Passwords don't match!", type: false)
//            }
//        } else {
//            self.showAlert(message: "Password must be at least 8 characters!", type: false)
//        }
    }
}
