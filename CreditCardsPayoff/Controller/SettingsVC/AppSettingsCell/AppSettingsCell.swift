//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 8/07/2023.
//

import UIKit

protocol AppSettingsTapsDelegate: AnyObject {
    func didTapChangePassword()
    func didTapChangeEmail()
}

class AppSettingsCell: UITableViewCell {

    weak var delegate: AppSettingsTapsDelegate?
    
    @IBOutlet weak var appSettingsView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var changeEmailView: UIView!
    @IBOutlet weak var passwordArrowImage: UIImageView!
    @IBOutlet weak var emailArrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        initializeGestures()
        setupArrowViews()
    }
    
    func setupViews() {
        appSettingsView.layer.cornerRadius = 15
        appSettingsView.layer.shadowColor = UIColor.lightGray.cgColor
        appSettingsView.layer.shadowOffset = CGSize(width: 1, height: 1)
        appSettingsView.layer.shadowRadius = 4
        appSettingsView.layer.shadowOpacity = 0.5
        appSettingsView.layer.masksToBounds = false
    }
    
    func setupArrowViews() {
//        if Locale.current.languageCode == "en" {
//            passwordArrowImage.image = UIImage(named: "chevron-right-grey")
//            emailArrowImage.image = UIImage(named: "chevron-right-grey")
//        } else if Locale.current.languageCode == "ar" {
//            passwordArrowImage.image = UIImage(named: "chevron-left-grey")
//            emailArrowImage.image = UIImage(named: "chevron-left-grey")
//        }
    }
    
    func initializeGestures() {
        let changeEmailTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapChangeEmailView(_:)))
        changeEmailView.addGestureRecognizer(changeEmailTapGestureRecognizer)
        let changePasswordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapChangePasswordView(_:)))
        changePasswordView.addGestureRecognizer(changePasswordTapGestureRecognizer)
    }
    
    @objc func didTapChangeEmailView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapChangeEmail()
    }
    
    @objc func didTapChangePasswordView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapChangePassword()
    }
}
