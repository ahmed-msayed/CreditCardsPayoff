//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 9/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChangeNameVC: UIViewController {
    
    let db = Firestore.firestore()
    var isDismissed: (() -> Void)?
        
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        navBarLayout()
    }
    
    func navBarLayout() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor.lightGray
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
    }
    
    func initializeViews() {
        firstNameTextField.text = UserVM.getLocalUser()?.firstName
        lastNameTextField.text = UserVM.getLocalUser()?.lastName
    }
    
    @IBAction func editNameTextButtonTapped(_ sender: UIButton) {
        firstNameTextField.isEnabled = true
        firstNameTextField.becomeFirstResponder()
    }
    
    @IBAction func editEmailTextButtonTapped(_ sender: UIButton) {
        lastNameTextField.isEnabled = true
        lastNameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        guard let fName = firstNameTextField.text else { return }
        guard let lName = lastNameTextField.text else { return }
        guard let user = UserVM.getLocalUser() else { return }
        if fName == "" || lName == "" {
            self.showAlert(message: "Enter Valid Name!", type: false)
        } else {
            self.showSpinner(onView: self.view)
            db.collection("users").whereField("userId", isEqualTo: user.userId)
                .getDocuments() { [weak self] (getResponse, error) in
                    self?.removeSpinner()
                    if let error = error?.localizedDescription {
                        self?.showAlert(message: error , type: false)
                    } else {
                        guard let document = getResponse!.documents.first else { return }
                        document.reference.updateData(["firstName" : fName, "lastName" : lName])
                        self?.showSpinner(onView: self?.view ?? UIView())
                        self?.db.collection("users").whereField("userId", isEqualTo: user.userId)
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
                }
        }
        
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}
