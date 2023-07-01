//
//  User.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 26/06/2023.
//

import UIKit

extension UIView {

	@IBInspectable
	var cornerRadius: CGFloat {

		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}

	@IBInspectable
	var borderWidth: CGFloat {

		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}

	@IBInspectable
	var borderColor: UIColor? {

		get {
			let color = UIColor.init(cgColor: layer.borderColor!)
			return color
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}
}
