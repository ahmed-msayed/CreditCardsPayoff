//
//  User.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 29/06/2023.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center

        spinnerView.addSubview(ai)
        onView.addSubview(spinnerView)
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
    }
}
