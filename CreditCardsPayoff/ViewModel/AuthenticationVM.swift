//
//  AuthenticationVM.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 14/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationVM {
    
    static let db = Firestore.firestore()

    static func login(email: String, password: String, completion: @escaping (_ userId: String?, _ error: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil, let userId = Auth.auth().currentUser?.uid {
                completion(userId, nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
    }
    
    static func getUserDataFromDB(userId: String, completion: @escaping (_ userVM: UserVM?, _ error: String?) -> Void) {
        self.db.collection("users").whereField("userId", isEqualTo: userId)
            .getDocuments() { (response, error) in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else {
                    guard let document = response!.documents.first else { return }
                    let data = document.data()
                    let user: User? = data.getObject()
                    guard let user = user else { return }
                    let userVM = UserVM(user: user)
                    completion(userVM, nil)
                }
            }
    }
    
    
    
    
}
