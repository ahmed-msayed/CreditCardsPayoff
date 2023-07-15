//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 10/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChangeEmailVC: UIViewController,UITextFieldDelegate {
    
    var textPlaceholder = ""
    let db = Firestore.firestore()
    var isDismissed: (() -> Void)?
    
    @IBOutlet weak var currentEmailTextField: UITextField!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var showHidePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmailTextField.delegate = self
        currentPasswordTextField.delegate = self
        newEmailTextField.delegate = self
        textFieldsPaddingSetup()
    }
    
    func textFieldsPaddingSetup() {
        currentEmailTextField.setLeftPadding(value: 15)
        currentPasswordTextField.setLeftPadding(value: 15)
        currentPasswordTextField.setRightPadding(value: 50)
        newEmailTextField.setLeftPadding(value: 15)
        currentPasswordTextField.isSecureTextEntry = true
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
    
    @IBAction func showHidePassword(_ sender: Any) {
        showHidePasswordButton.isSelected = !showHidePasswordButton.isSelected
        currentPasswordTextField.isSecureTextEntry = !showHidePasswordButton.isSelected
    }
    
    @IBAction func saveEmailButtonTapped(_ sender: UIButton) {
        if currentEmailTextField.text != UserVM.getLocalUser()?.email {
            self.showAlert(message: "Wrong current email!", type: false)
            return
        }
        authenticateCurrentUser()
    }
    
    func authenticateCurrentUser() {
        self.showSpinner(onView: self.view)
        Auth.auth().signIn(withEmail: currentEmailTextField.text!, password: currentPasswordTextField.text!) { [weak self] authResult, error in
            self?.removeSpinner()
            if error == nil {
                self?.changeEmail()
            } else {
                self?.showAlert(message: error?.localizedDescription ?? "", type: false)
            }
        }
    }
    
    func changeEmail() {
        self.showSpinner(onView: self.view)
        Auth.auth().currentUser?.updateEmail(to: newEmailTextField.text!) { error in
            self.removeSpinner()
            if error == nil, let userId = Auth.auth().currentUser?.uid {
                self.saveNewEmailToDB(userId: userId)
            } else {
                self.showAlert(message: error?.localizedDescription ?? "Unknown Error" , type: false)
            }
        }
    }
    
    func saveNewEmailToDB(userId: String) {
        self.showSpinner(onView: self.view)
        db.collection("users").whereField("userId", isEqualTo: userId)
            .getDocuments() { [weak self] (getResponse, error) in
                self?.removeSpinner()
                if let error = error?.localizedDescription {
                    self?.showAlert(message: error , type: false)
                } else {
                    guard let document = getResponse!.documents.first else { return }
                    guard let newEmail = self?.newEmailTextField.text else { return }
                    document.reference.updateData(["email" : newEmail])
                    self?.saveUserData(userId: userId)
                }
            }
    }
    
    func saveUserData(userId: String) {
            self.showSpinner(onView: self.view)
            self.db.collection("users").whereField("userId", isEqualTo: userId)
                .getDocuments() { [weak self] (saveResponse, error) in
                    self?.removeSpinner()
                    if let error = error?.localizedDescription {
                        self?.showAlert(message: error , type: false)
                    } else {
                        guard let document = saveResponse!.documents.first else { return }
                        let data = document.data()
                        let user: User? = data.getObject()
                        guard let user = user else { return }
                        let userVM = UserVM(user: user)
                        userVM.saveUserLocally()
                        UserDefaults.standard.synchronize()
                        self?.dismissModalVC()
                    }
                }
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}

