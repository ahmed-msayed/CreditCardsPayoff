//
//  CustomButton.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 12/08/2021.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setShadow()
        
        if Helper.shared.isDarkMode == true {
            setTitleColor(.white, for: .normal)
        } else {
            setTitleColor(.black, for: .normal)
        }
        
        backgroundColor      = UIColor(named: "buttonsBackground")
        titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius   = 15
        layer.borderWidth    = 1.5
        layer.borderColor    = UIColor.darkGray.cgColor
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 5
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}
