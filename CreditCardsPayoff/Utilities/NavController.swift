//
//  User.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 26/06/2023.
//

import UIKit

class NavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setNavigationBar()
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}

	func setNavigationBar() {

		let compactAppearance = UINavigationBarAppearance()
		compactAppearance.configureWithTransparentBackground()
		compactAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
		compactAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
		compactAppearance.backgroundColor = .systemBackground

		navigationBar.isTranslucent = true
		navigationBar.standardAppearance = compactAppearance
		navigationBar.compactAppearance = compactAppearance
		navigationBar.scrollEdgeAppearance = compactAppearance
		navigationBar.tintColor = AppColor.Theme
		navigationBar.layoutIfNeeded()
	}

	func setBackground(color: UIColor) {
		self.navigationBar.standardAppearance.backgroundColor = color
		self.navigationBar.compactAppearance?.backgroundColor = color
		self.navigationBar.scrollEdgeAppearance?.backgroundColor = color
	}
}
