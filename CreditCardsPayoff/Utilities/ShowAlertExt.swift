//
//  ShowAlertExt.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 29/06/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String, type: Bool) {
        if self is AlertVC {
            return
        }
        
        let alertVC = storyboard?.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC
        alertVC.alertMessageText = message
        alertVC.alertType = type
        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertVC, animated: true)
    }
}
