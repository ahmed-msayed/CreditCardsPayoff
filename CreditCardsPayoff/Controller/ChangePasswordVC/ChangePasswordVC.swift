//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 10/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChangePasswordVC: UIViewController,UITextFieldDelegate {

    var textPlaceholder = ""
    var isDismissed: (() -> Void)?

    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        textFieldsPaddingSetup()
    }
    
    func textFieldsPaddingSetup() {
        currentPasswordTextField.setLeftPadding(value: 15)
        newPasswordTextField.setLeftPadding(value: 15)
        repeatPasswordTextField.setLeftPadding(value: 15)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textPlaceholder = textField.placeholder ?? ""
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
        textField.placeholder = textPlaceholder
        }
    }
    
    @IBAction func savePasswordButtonTapped(_ sender: UIButton) {
        guard let newPassword = newPasswordTextField.text else {return}
        if !newPassword.isValidPassword {
            self.showAlert(message: "Write a valid password!", type: false)
            return
        }
        if newPasswordTextField.text != repeatPasswordTextField.text {
            self.showAlert(message: "Passwords don't match!", type: false)
            return
        }
        authenticateCurrentUser()
    }
    
    func authenticateCurrentUser() {
        self.showSpinner(onView: self.view)
        Auth.auth().signIn(withEmail: UserVM.getLocalUser()!.email, password: currentPasswordTextField.text!) { [weak self] authResult, error in
            self?.removeSpinner()
            if error == nil {
                self?.changePassword()
            } else {
                self?.showAlert(message: error?.localizedDescription ?? "", type: false)
            }
        }
    }
    
    func changePassword() {
        self.showSpinner(onView: self.view)
        Auth.auth().currentUser?.updatePassword(to: newPasswordTextField.text!) { error in
            self.removeSpinner()
            if error == nil {
                self.dismissModalVC()
            } else {
                self.showAlert(message: error?.localizedDescription ?? "Unknown Error" , type: false)
            }
        }
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}
