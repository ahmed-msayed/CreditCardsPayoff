//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 8/07/2023.
//

import UIKit

protocol AccountSettingsTapsDelegate: AnyObject {
    func didTapLanguage()
    func didTapCurrency()
    func didChangeModeToDark()
    func didChangeModeToLight()
}

class AccountSettingsCell: UITableViewCell {
    
    weak var delegate: AccountSettingsTapsDelegate?
    
    @IBOutlet weak var accountSettingsView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var languageArrowImage: UIImageView!
    @IBOutlet weak var currencyArrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        initializeGestures()
        setupArrowViews()
        setDarkModeSwitchState()
    }
    
    func setupViews() {
        accountSettingsView.layer.cornerRadius = 15
        accountSettingsView.layer.shadowColor = UIColor.lightGray.cgColor
        accountSettingsView.layer.shadowOffset = CGSize(width: 1, height: 1)
        accountSettingsView.layer.shadowRadius = 4
        accountSettingsView.layer.shadowOpacity = 0.5
        accountSettingsView.layer.masksToBounds = false
    }
    
    func setDarkModeSwitchState() {
        if Helper.shared.isDarkMode == true {
            darkModeSwitch.isOn = true
        } else {
            darkModeSwitch.isOn = false
        }
    }
    
    func setupArrowViews() {
        //        if Locale.current.languageCode == "en" {
        //            languageArrowImage.image = UIImage(named: "chevron-right-grey")
        //            currencyArrowImage.image = UIImage(named: "chevron-right-grey")
        //        } else if Locale.current.languageCode == "ar" {
        //            languageArrowImage.image = UIImage(named: "chevron-left-grey")
        //            currencyArrowImage.image = UIImage(named: "chevron-left-grey")
        //        }
    }
    
    func initializeGestures() {
        let languageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLanguageView(_:)))
        languageView.addGestureRecognizer(languageTapGestureRecognizer)
        let currencyTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCurrencyView(_:)))
        currencyView.addGestureRecognizer(currencyTapGestureRecognizer)
    }
    
    func bindData() {
        currencyLabel.text = CurrencyVM.getLocalUserCurrency()?.currencyCode
    }
    
    @objc func didTapLanguageView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapLanguage()
    }
    
    @objc func didTapCurrencyView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapCurrency()
    }
    
    @IBAction func notificationSwitchChange(_ sender: UISwitch) {
    }
    
    @IBAction func darkModeSwitchChange(_ sender: UISwitch) {
        if Helper.shared.isDarkMode == false {
            Helper.shared.isDarkMode = true
        } else {
            Helper.shared.isDarkMode = false
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
        resetWindow(with: tabBarController)
    }
    
    private func resetWindow(with vc: UIViewController?) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("could not get scene delegate ")
        }
        sceneDelegate.window?.rootViewController = vc
        sceneDelegate.reCheckInterfaceStyle()
    }
}
